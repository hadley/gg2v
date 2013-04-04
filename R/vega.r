#' @importFrom whisker whisker.render
vega <- function(plot, base_path = ".", name = "test", width = 600, height = 400, padding = c(10, 10, 10, 10)) {
  stopifnot(is.numeric(padding), length(padding) == 4)
  stopifnot(is.character(base_path), length(base_path) == 1,
    file.exists(base_path), is.dir(base_path))

  base_path <- normalizePath(base_path)
  spec_path <- file.path(base_path, paste0(name, ".js"))
  html_path <- file.path(base_path, paste0(name, ".html"))

  # Copy needed files over
  vega_dir <- file.path(base_path, "vega")
  if (!file.exists(vega_dir)) dir.create(vega_dir)
  from <- dir(system.file("vega", package = "gg2v"), full.names = TRUE)
  to <- file.path(vega_dir, basename(from))
  file.copy(from, to)

  # Render html template
  tmpl <- readLines(system.file("templates", "render.html", package = "gg2v"))
  out <- whisker.render(tmpl, list(
    title = "My vega vis",
    spec_path = basename(spec_path)))
  writeLines(out, html_path)

  # Copy needed files over
  data_dir <- file.path(base_path, "data")
  if (!file.exists(data_dir)) dir.create(data_dir)

  data <- save_data(plot, data_dir)
  scales <- plot_scales(plot)
  layer <- plot_layers(plot)

  vis <- list(
    width = width,
    height = height,
    data = data,
    scales = scales,
    marks = layer,
    axes = list(
      list(type = "x", scale = "x"),
      list(type = "y", scale = "y")
    )
  )

  spec <- toJSON(vis, pretty = TRUE)
  writeLines(spec, spec_path)

  invisible()
}

default_name <- function(plot) {
  ggplot2:::digest.ggplot(plot)
}

