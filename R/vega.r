vega <- function(plot, base_dir, width = 600, height = 400, padding = c(10, 10, 10, 10)) {
  stopifnot(is.numeric(padding), length(padding) == 4)

  data <- save_data(plot, base_dir)
  scales <- plot_scales(plot)
  layer <- plot_layers(plot)


  list(
    width = width,
    height = height,
    data = data,
    scales = scales,
    marks = layer
  )

}
