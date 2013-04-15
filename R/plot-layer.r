
plot_layers <- function(plot, pd) {
  stopifnot(is.ggplot(plot))

  data <- pd$data
  data_hash <- pd$hash
  aes <- pd$aes

  geoms <- lapply(plot$layers, function(x) x$geom$objname)
  params <- lapply(plot$layers, function(x) x$geom_params)

  Map(convert_geom, geoms, data_hash, data[data_hash], aes, params)
}

bg_layer <- function()  {
  mark(
    type = "rect",
    name = "background",
    properties = mark_props(enter = list(
      fill = valref(convert_fill("grey90")),
      y2 = valref(0),
      y = valref(1000),
      x = valref(0),
      x2 = valref(1000)))
  )
}
