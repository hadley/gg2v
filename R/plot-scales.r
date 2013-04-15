plot_scales <- function(plot, pd) {
  stopifnot(is.ggplot(plot))

  data <- pd$data
  data_hash <- pd$hash
  aes <- pd$aes

  # e.g. x, xmin and xmax are all mapped to the same scale:
  # need to combine specification
  uses <- list()
  for (i in seq_along(aes)) {
    # For each layer
    layer_map <- aes[[i]]
    layer_data <- data[[data_hash[i]]]

    for (j in seq_along(layer_map)) {
      # For each aesthetic mapping
      scale <- names(layer_map)[[j]]
      col <- layer_map[[j]]
      nm <- deparse(col)

      if (!has_name(nm, layer_data)) next

      visprop <- aes_to_scale[[scale]]
      if (is.null(visprop)) next
      append(uses[[visprop]]) <- dataref(data_hash[i], nm)
    }
  }
  # Until vega can handle it
  uses <- lapply(uses, "[[", 1)

  # Get or generate scales as needed
  get_scale <- function(aesthetic) {
    plot$scales$get_scales(aesthetic) %||%
      find_scale(aesthetic, data[data_hash], aes, plot$plot_env)
  }
  scales <- lapply(names(uses), get_scale)

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
  # Use first candidate variable for this scale
  aes <- scale_to_aes[[scale]]
  var <- aesthetics[intersect(aes, names(aesthetics))][[1]]

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
