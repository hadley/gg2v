#' Convert a geom into a mark specification
convert_geom <- function(geom, data_name, data, aes, params) {
  f <- match.fun(paste0("convert_geom_", geom))
  f(data_name, data, aes, params)
}

convert_geom_point <- function(data_name, data, aes, params) {
  props <- modify_list(convert_map(aes), convert_set(params))

  if (!has_name("fill", props) && has_name("stroke", props)) {
    props$fill <- props$stroke
  }

  mark(
    type = "symbol",
    from = list(data = data_name),
    properties = mark_props(props)
  )
}

#' @importFrom plyr is.discrete
#' qplot(mpg, wt, data = mtcars, geom = "path")
#' gg2v("~/desktop/vega-test/", name = "path")
#' qplot(mpg, wt, data = mtcars, geom = "path", group = cyl)
#' gg2v("~/desktop/vega-test/", name = "path-group")
#' qplot(mpg, wt, data = mtcars, geom = "path", group = cyl, colour = cyl)
#' gg2v("~/desktop/vega-test/", name = "path-group-colour")
#' qplot(mpg, wt, data = mtcars, geom = "path", colour = factor(cyl))
#' gg2v("~/desktop/vega-test/", name = "path-colour")
convert_geom_path <- function(data_name, data, aes, params) {
  props <- modify_list(convert_map(aes), convert_set(params))

  mark(
    type = "group",
    from = list(
      data = data_name,
      transform = list(list(
        type = "facet",
        keys = group_by(aes, data)
      ))
    ),
    marks = list(mark(
      type = "line",
      properties = mark_props(props)
    ))
  )
}


group_by <- function(aes, data) {
  if (has_name("group", aes)) {
    group_by <- deparse(aes$group)
  } else {
    is_discrete <- vapply(data, is.discrete, logical(1))
    group_by <- names(data)[is_discrete]
  }
  if (length(group_by) > 0) group_by <- paste0("data.", group_by)

  as.list(group_by)
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

