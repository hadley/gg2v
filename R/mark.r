
mark_props <- function(update = NULL, enter = NULL, exit = NULL) {
  compact(list(update = update, enter = enter, exit = exit))
}

mark <- function(type = NULL, name = NULL, description = NULL, from = NULL,
                 properties = NULL, delay = NULL, ease = NULL, ...) {
  compact(list(type = type, name = name, description = description, from = from,
    properties = properties, delay = delay, ease = ease, ...))
}

no_scales <- c("group", "label")
map_value <- function(x, visprop, scale = NULL) {
  if (is.null(x)) return()

  if (!is.null(scale) && scale %in% no_scales) scale <- NULL
  if (is.atomic(x)) {
    out <- valref(value = x, scale = scale)
  } else {
    out <- valref(field = deparse(x), scale = scale)
  }
  out
}


# Converts value (if converter available), and scales x and y values only
#
# This is what ggplot2 does: e.g. geom_point(x = 10, y = 10) places a
# point at (10, 10) in the data space, not the position space.
set_value <- function(x, visprop, scale = NULL) {
  if (is.null(x)) return()
  x_vega <- convert_value(x, visprop)

  out <- valref(value = x_vega, scale = if (scale %in% c("x", "y")) scale)
  out
}

valref <- function(value = NULL, field = NULL, scale = NULL, mult = NULL,
                   offset = NULL, band = NULL) {
  if (is.null(value) && is.null(field)) return()
  if (!is.null(value) && !is.null(field)) {
    stop("Can only specify one of field and value")
  }

  compact(list(
    value = value,
    field = if (!is.null(field)) paste0("data.", field),
    scale = scale,
    mult = mult,
    offset = offset,
    band = band
  ))
}
