#' Convert a geom into a mark specification
convert_geom <- function(geom, data, aes, params) {
  f <- match.fun(paste0("convert_geom_", geom))
  f(data, aes, params)
}

convert_geom_point <- function(data, aes, params) {
  props <- modify_list(convert_map(aes), convert_set(params))

  mark(
    type = "symbol",
    from = list(data = data),
    properties = mark_props(props)
  )
}

convert_map <- function(x) {
  stopifnot(is.list(x))

  x <- lapply(x, deparse)

  # If aesthetic is a constant, need to use value instead of field

  map <- list(
    x      = valref(field = x$x, scale = "x"),
    y      = valref(field = x$y, scale = "y"),
    fill   = valref(field = x$fill, scale = "fill") %||% valref("black"),
    stroke = valref(field = x$colour, scale = "colour"),
    size   = valref(field = x$size, scale = "size"),
    shape  = valref(field = x$shape, scale = "shape")
  )
  compact(map)
}

convert_set <- function(x) {
  stopifnot(is.list(x))

  set <- list(
    x      = valref(x$x, scale = "x"),
    y      = valref(x$y, scale = "y"),
    fill   = valref(convert_colour(x$fill)),
    stroke = valref(convert_colour(x$colour)),
    size   = valref(convert_size(x$size)),
    symbol = valref(convert_shape(x$shape))
  )
  compact(set)
}

