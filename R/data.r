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
#'   geom_point(aes(displ, colour = "mpg"), data = mpg)
#' str(plot_data(p3))
#'
#' td <- temp_dir()
#' save_data(p3, td)
#' if (interactive()) show(td)
save_data <- function(plot, path) {
  stopifnot(is.ggplot(plot))
  stopifnot(is.character(path), length(path) == 1,
    file.exists(path), is.dir(path))

  data <- plot_data(plot)
  out <- Map(function(x, name) save_one(x, name, base_dir = path),
    data, names(data))
  invisible(out)
}

save_one <- function(x, name, base_dir) {
  path <- file.path(base_dir, paste0(name, ".csv"))
  write.csv(x, path, row.names = FALSE)

  list(
    name = name,
    url = path,
    format = "csv"
  )
}

#' @rdname save_data
#' @importFrom digest digest
#' @export
plot_data <- function(plot) {
  stopifnot(is.ggplot(plot))
  plot <- ggplot2:::plot_clone(plot)

  # Standardise data and aesthetics to remove dependence on plot settings

  # If I wanted to support subset, it should be added here.
  data <- lapply(plot$layers, function(l) l$data %||% plot$data)

  aes <- lapply(plot$layers, function(l) {
    combine_aes(l$mapping, l$geom_params, plot_aes = plot$mapping,
      inherit = l$inherit.aes)
  })

  # For each, data set, figure out what aesthetics we need
  combine_aes <- function(x) unique(unlist(x, use.names = FALSE))

  data_hash <- vapply(data, digest, character(1))
  data_aes <- lapply(split(aes, data_hash), combine_aes)
  udata <- lapply(split(data, data_hash), "[[", 1)

  # Evaluate all aesthetics so we don't need to do any compution in
  # javascript
  Map(function(data, aes) render_data(data, aes, env = plot$plot_env),
    udata, data_aes)
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

combine_aes <- function(layer_aes, params, plot_aes = NULL, inherit = TRUE) {
  if (inherit) {
    aesthetics <- compact(modify_list(plot_aes, layer_aes))
  } else {
    aesthetics <- layer_aes
  }

  # Drop aesthetics that are set or calculated
  set <- names(aesthetics) %in% names(params)
  calculated <- is_calculated_aes(aesthetics)

  aesthetics[!set & !calculated]
}

is_calculated_aes <- function(aesthetics) {
  match <- "\\.\\.([a-zA-z._]+)\\.\\."
  stats <- rep(FALSE, length(aesthetics))
  grepl(match, vapply(aesthetics, deparse, character(1)))
}
