
plot_layers <- function(plot) {
  stopifnot(is.ggplot(plot))

  data <- standard_data(plot)
  data_hash <- vapply(data, digest, character(1))
  aes <- standard_aes(plot)

  geoms <- lapply(plot$layers, function(x) x$geom$objname)
  params <- lapply(plot$layers, function(x) x$geom_params)

  Map(convert_geom, geoms, data_hash, aes, params)
}

bg_layer <- function()  {
  mark(
    type = "rect",
    name = "background",
    properties = mark_props(enter = list(
      fill = valref(convert_colour("grey90")),
      y2 = valref(0),
      y = valref(1000),
      x = valref(0),
      x2 = valref(1000)))
  )
}
