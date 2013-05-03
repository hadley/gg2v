#' Compute and save layer datasets for a ggplot2 plot.
#'
#' @export
#' @param ggplot2 plot
#' @param path Existing directory in which to save plot datasets.
#' @return \code{save_data}: (invisibly) a list that can be transformed to JSON
#'   to produce vega data spec.
#' @examples
#' p1 <- ggplot(mtcars, aes(disp, cyl)) +
#'   geom_point()
#' str(plot_data(p1))
#'
#' str(plot_data(p1 + geom_point(aes(y = cyl + 1))))
#'
#' p2 <- p1 + geom_point(aes(displ * 61, cyl), data = mpg)
#' str(plot_data(p2))
#'
#' p3 <- ggplot(mapping = aes(y = cyl)) +
#'   geom_point(aes(disp, colour = "mtcars"), data = mtcars) +
#'   geom_point(aes(displ * 61, colour = "mpg"), data = mpg)
#' str(plot_data(p3))
#'
#' td <- temp_dir()
#' save_data(p3, td)
#' if (interactive()) show(td)
save_data <- function(plot, path) {
  stopifnot(is.ggplot(plot))
  stopifnot(is.character(path), length(path) == 1,
    file.exists(path), is.dir(path))

  data <- plot_data(plot)$data
  out <- Map(function(x, name) save_one(x, name, base_dir = path),
    data, names(data))
  invisible(unname(out))
}

save_one <- function(x, name, base_dir) {
  path <- file.path(base_dir, paste0(name, ".csv"))
  write.csv(x, path, row.names = FALSE)

  parse <- compact(lapply(x, parse_type))

  list(
    name = name,
    url = file.path("data", basename(path)),
    format = list(
      type = "csv",
      parse = parse)
  )
}

parse_type <- function(x) {
  if (is.numeric(x)) {
    "number"
  } else if (is.logical(x)) {
    "boolean"
  } else if (inherits(x, "POSIXt") || inherits(x, "Date")) {
    "date"
  } else {
    NULL
  }
}

#' @rdname save_data
#' @importFrom digest digest
#' @export
plot_data <- function(plot) {
  stopifnot(is.ggplot(plot))
  plot <- ggplot2:::plot_clone(plot)

  # Standardise data and aesthetics to remove dependence on plot settings
  data <- standard_data(plot)
  aes <- standard_aes(plot)

  # Process statistics which potentially change data and aesthetics.
  stats <- lapply(plot$layers, "[[", "stat")
  params <- lapply(plot$layers, "[[", "stat_param")
  out <- Map(function(data, aes, stats, params) {
    process_stats(data, aes, stats, params, plot$plot_env)
  }, data, aes, stats, params)

  data <- lapply(out, "[[", "data")
  aes <- lapply(out, "[[", "aes")

  # For each, data set, figure out what aesthetics we need
  data_hash <- vapply(data, digest, character(1))
  names(aes) <- data_hash

  combine_aes <- function(x) unique(unlist(x, use.names = FALSE))
  data_aes <- lapply(split(aes, data_hash), combine_aes)
  udata <- lapply(split(data, data_hash), "[[", 1)

  # Evaluate all aesthetics so we don't need to do any computation in js
  layer_data <- Map(function(data, aes) render_data(data, aes, env = plot$plot_env),
    udata, data_aes)

  list(hash = data_hash, data = layer_data, aes = aes)
}

process_stats <- function(data, aes, stat, params, env) {
  if (stat$objname == "identity" || is.null(data) || nrow(data) == 0) {
    return(list(data = data, aes = aes))
  }

  # Map variable names to aesthetics
  raw_aes <- aes[!is_calculated_aes(aes)]
  data <- lapply(raw_aes, eval, envir = data, enclos = env)
  data <- as.data.frame(data)

  # Add group
  data <- ggplot2:::add_group(data)

  # Make dummy scales
  scales <- list(x = scale_dummy(data$x), y = scale_dummy(data$y))

  # Compute statistic
  call <- combine(
    quote(stat$calculate_groups(stat, data = data, scales = scales)),
    params
  )

  out <- failwith(data.frame(), eval)(call, environment())

  # Generate new aesthetics
  if (!is.null(stat$default_aes)) {
    all_aes <- modify_list(stat$default_aes(), aes)
  } else {
    all_aes <- aes
  }
  stat_aes <- all_aes[is_calculated_aes(all_aes)]

  # Previous raw aesthetics now just get re-mapped. Computed aesthetics
  # get mapped
  raw2 <- setNames(lapply(names(raw_aes), as.name), names(raw_aes))
  stat2 <- lapply(stat_aes, {
    function(x) as.name(gsub("^\\.\\.|\\.\\.$", "", deparse(x)))
  })
  aes <- c(raw2, stat2)

  # Map aesthetics back to variable names
  list(data = out, aes = aes)
}

scale_dummy <- function(x) structure(list(x), class = "dummy")

#' @export
scale_dimension.dummy <- function(x, ...) {
  if (is.numeric(x[[1]])) {
    range(x[[1]])
  } else {
    length(unique(x[[1]]))
  }
}

render_data <- function(data, aes, env = parent.env()) {
  n <- nrow(data)
  out <- data[, 0]
  for (i in seq_along(aes)) {
    var <- aes[[i]]
    # Don't output constants
    if (is.atomic(var) && length(var) == 1) next

    val <- eval(var, data, env)
    stopifnot(is.atomic(val), length(val) == n)

    name <- paste(deparse(var), collapse = "")
    out[[name]] <- val
  }

  out
}

standard_data <- function(plot) {
  # If I wanted to support subset, it should be added here.
  lapply(plot$layers, function(l) l$data %||% plot$data)
}

standard_aes <- function(plot) {
  lapply(plot$layers, function(l) {
    combine_aes(l$mapping, l$geom_params, plot_aes = plot$mapping,
      inherit = l$inherit.aes)
  })
}

combine_aes <- function(layer_aes, params, plot_aes = NULL, inherit = TRUE) {
  if (inherit) {
    aesthetics <- compact(modify_list(plot_aes, layer_aes, recurse = TRUE))
  } else {
    aesthetics <- layer_aes
  }

  # Drop aesthetics that are set, calculated or constant
  set <- names(aesthetics) %in% names(params)
  calculated <- is_calculated_aes(aesthetics)
  constant <- vapply(aesthetics, is.atomic, logical(1))

  aesthetics[!set & !calculated & !constant]
}

is_calculated_aes <- function(aesthetics) {
  match <- "\\.\\.([a-zA-z._]+)\\.\\."
  stats <- rep(FALSE, length(aesthetics))
  grepl(match, vapply(aesthetics, deparse, character(1)))
}
