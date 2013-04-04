#' Render a ggplot2 graphic with vega.
#'
#' @section Use:
#' This function creates all the files necesary to render a vega visualisation:
#' but currently you're responsible for running a server to send them to
#' the browser.  You can't run directly from disk (with a \code{file://})
#' url, because browser security settings make it impossible to load data
#' from relative urls.
#'
#' @export
#' @param plot ggplot2 graphic
#' @param base_path path in which to save all visualisation files.  Must
#'   already exist.
#' @param name name of visualisation. Used to name html and js spec files
#' @param width width of visualisation in pixels
#' @param height height of visualisation in pixels
#' @param padding a numeric vector of length 4 giving the padding on the
#'  top, right, bottom and left sides respectively.
#' @importFrom whisker whisker.render
#' @importFrom ggplot2 is.ggplot
#' @importFrom RJSONIO toJSON
#' @docType package
gg2v <- function(plot, base_path = ".", name = "test", width = 600,
                 height = 400, padding = c(10, 10, 10, 10)) {
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
    title = paste0("gg2v: ", name),
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

