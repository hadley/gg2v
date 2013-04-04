#' Convert a geom into a mark specification
convert_geom <- function(geom, data, aes, params) {
  f <- match.fun(paste0("convert_geom_", geom))
  f(data, aes, params)
}

convert_geom_point <- function(data, aes, params) {
  props <- modify_list(convert_map(aes), convert_set(params))

  if (!has_name("fill", props) && has_name("stroke", props)) {
    props$fill <- props$stroke
  }

  mark(
    type = "symbol",
    from = list(data = data),
    properties = mark_props(props)
  )
}

convert_map <- function(x) {
  stopifnot(is.list(x))

  map <- list(
    x      = map_value(x$x, "x"),
    y      = map_value(x$y, "y"),
    fill   = map_value(x$fill, "fill"),
    stroke = map_value(x$colour, "colour") %||% valref("black"),
    size   = map_value(x$size, "size"),
    shape  = map_value(x$shape, "shape")
  )
  compact(map)
}

map_value <- function(mapping, scale) {
  if (is.atomic(mapping)) {
    valref(value = mapping, scale = scale)
  } else {
    valref(field = deparse(mapping), scale = scale)
  }
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

