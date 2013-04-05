#' Convert a geom into a mark specification
convert_geom <- function(geom, data_name, data, aes, params) {
  f <- match.fun(paste0("convert_geom_", geom))
  f(data_name, data, aes, params)
}

convert_geom_point <- function(data_name, data, aes, params) {
  def <- list(fill = "black")
  params <- modify_list(def, params)
  if (!is.null(params$size)) {
    # size is in pixels^2
    params$size <- params$size ^ 2
  }

  map <- convert_map(aes)
  map$size <- map_value(aes$size, "size")
  map$symbol <- map_value(aes$shape, "shape")

  par <- convert_set(params)
  par$size <- valref(convert_size(params$size))
  par$shape <- valref(convert_shape(params$shape))

  props <- modify_list(map, par)
  if (!has_name("fill", props) && has_name("stroke", props)) {
    props$fill <- props$stroke
  }

  mark(
    type = "symbol",
    from = list(data = data_name),
    properties = mark_props(props)
  )
}

convert_geom_text <- function(data_name, data, aes, params) {
  map <- convert_map(aes)
  map$stroke <- NULL
  map$fill <- map_value(aes$colour, "colour")
  map$text <- map_value(aes$label)
  map$fontSize <- map_value(aes$size, "size")

  par <- convert_set(params)
  par$stroke <- NULL
  par$fill <- valref(params$colour)
  par$text <- valref(params$label)
  par$fontSize <- valref(convert_size(params$size))
  par$align <- valref(params$hjust)
  par$baseline <- valref(params$vjust)
  par$angle <- valref(params$angle)

  # Font settings
  face <- convert_face(params$fontface)
  par$font <- valref(params$fontfamily)
  par$fontWeight <- valref(face$weight)
  par$fontStyle <- valref(face$style)

  props <- modify_list(map, par)
  props$fontSize <- props$fontSize %||% valref(convert_size(5))
  props$fill <- props$fill %||% valref(convert_colour("black"))

  mark(
    type = "text",
    from = list(data = data_name),
    properties = mark_props(props)
  )
}

#' @importFrom plyr is.discrete
convert_geom_path <- function(data_name, data, aes, params) {
  props <- modify_list(convert_map(aes), convert_set(params))
  props$stroke <- props$stroke %||% valref(convert_colour("black"))

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

convert_map <- function(x) {
  stopifnot(is.list(x))

  map <- list(
    x      = map_value(x$x, "x"),
    y      = map_value(x$y, "y"),
    fill   = map_value(x$fill, "fill"),
    stroke = map_value(x$colour, "colour")
  )
  compact(map)
}

map_value <- function(mapping, scale = NULL) {
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
    stroke = valref(convert_colour(x$colour))
  )
  compact(set)
}

