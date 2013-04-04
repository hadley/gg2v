plot_scales <- function(plot) {
  stopifnot(is.ggplot(plot))

  data <- plot_data(plot)
  data_hash <- vapply(standard_data(plot), digest, character(1))

  aes <- standard_aes(plot)
  names(aes) <- data_hash

  # For each scale, build a list of all datasets that use it
  aesthetics <- unique(unlist(lapply(aes, names)))

  make_ref <- function(scale, hash) {
    col <- aes[[hash]][[scale]]
    if (is.null(col)) return()

    nm <- deparse(col)
    if (!has_name(nm, data[[hash]])) return()

    dataref(hash, nm)
  }
  uses <- lapply(aesthetics, function(scale) {
    compact(lapply(data_hash, make_ref, scale = scale))
  })
  # Until vega can handle
  uses <- lapply(uses, "[[", 1)

  # Get or generate scales as needed
  get_scale <- function(aesthetic) {
    plot$scales$get_scales(aesthetic) %||%
      find_scale(aesthetic, data[data_hash], aes, plot$plot_env)
  }
  scales <- lapply(aesthetics, get_scale)

  compact(Map(convert_scale, scales, uses))
}

find_scale <- function(scale, data, aesthetics, env) {
  stopifnot(is.character(scale), length(scale) == 1)
  stopifnot(is.list(data), is.list(aesthetics),
    length(data) == length(aesthetics))
  stopifnot(is.environment(env))

  for(i in seq_along(data)) {
    candidate <- default_scale(scale, data[[i]], aesthetics[[i]], env)
    if (!is.null(candidate)) return(candidate)
  }

  # stop("Could not generate defaults for scale ", scale, call. = FALSE)
  NULL
}


default_scale <- function(scale, data, aesthetics, env) {
  var <- aesthetics[[scale]]

  # Variable not used on this layer
  if (is.null(var)) return()

  var <- deparse(var)
  val <- data[[var]]
  # Value not present on this layer
  if (is.null(val)) return()

  type <- ggplot2:::scale_type(val)
  scale_name <- paste("scale", scale, type, sep="_")
  scale_f <- ggplot2:::find_global(scale_name, env)

  # Aesthetics doesn't need a scale
  if (is.null(scale_f)) return()

  scale_f()
}
