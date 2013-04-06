#' Convert a geom into a mark specification
convert_geom <- function(geom, data_name, data, aes, params) {
  f <- match.fun(paste0("convert_geom_", geom))
  f(data_name, data, aes, params)
}

convert_geom_point <- function(data_name, data, aes, params) {
  props <- make_props(aes, params, list(colour = "black"), c(
    "fill" = "fill",
    "stroke" = "colour",
    "size" = "size",
    "symbol" = "shape",
    "x" = "x",
    "y" = "y"
  ))

  if (has_name("stroke", props) && !has_name("fill", props)) {
    props$fill <- props$stroke
  }

  mark(
    type = "symbol",
    from = list(data = data_name),
    properties = mark_props(props)
  )
}

convert_geom_text <- function(data_name, data, aes, params) {
  props <- make_props(aes, params, list(colour = "black", size = 5), c(
    "align" = "hjust",
    "angle" = "angle",
    "baseline" = "vjust",
    "fill" = "colour",
    "fontSize" = "size",
    "style" = "family",
    "text" = "label",
    "weight" = "family",
    "x" = "x",
    "y" = "y"
  ))

  mark(
    type = "text",
    from = list(data = data_name),
    properties = mark_props(props)
  )
}

#' @importFrom plyr is.discrete
convert_geom_path <- function(data_name, data, aes, params) {
  props <- make_props(aes, params, list(colour = "black"), c(
    "fill" = "fill",
    "stroke" = "colour",
    "strokeWidth" = "size",
    "x" = "x",
    "y" = "y"
  ))

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

convert_geom_area <- function(data_name, data, aes, params) {
  mark <- convert_geom_line(data_name, data, aes, params)
  mark$marks[[1]]$type <- "area"
  mark$marks[[1]]$properties$update$y2 <- valref(0, scale = "y")

  mark
}

convert_geom_line <- function(data_name, data, aes, params) {
  mark <- convert_geom_path(data_name, data, aes, params)

  mark$from$transform <- c(
    list(list(
      type = "sort",
      by = paste0("data.", deparse(aes$x))
    )),
    mark$from$transform
  )

  mark
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

map_extract <- function(x, from) extract_many(x, from, "map")
set_extract <- function(x, from) extract_many(x, from, "set")

extract_many <- function(x, from, type = "map") {
  stopifnot(is.list(x))
  stopifnot(is.character(from), !is.null(names(from)), all(names(from) != ""))
  type <- match.arg(type, c("map", "set"))
  type_f <- list(map = map_value, set = set_value)[[type]]

  pieces <- Map(function(from, to) {
    type_f(x[[from]], to, from)},
    from, names(from))
  compact(pieces)
}

make_props <- function(aes, set, def, gg2v) {
  map <- map_extract(aes, gg2v)
  set <- set_extract(set, gg2v)
  def <- set_extract(def, gg2v)

  modify_list(def, modify_list(map, set))
}

convert_set <- function(x) {
  stopifnot(is.list(x))

  set <- list(
    x      = valref(x$x, scale = "x"),
    y      = valref(x$y, scale = "y"),
    fill   = valref(convert_fill(x$fill)),
    stroke = valref(convert_stroke(x$colour))
  )
  compact(set)
}
convert_map <- function(x) {
  stopifnot(is.list(x))

  map <- list(
    x = map_value(x$x, "x", "x"),
    y = map_value(x$y, "y", "y"),
    fill   = map_value(x$fill, "fill", "fill"),
    stroke = map_value(x$colour, "stroke", "colour")
  )
  compact(map)
}
