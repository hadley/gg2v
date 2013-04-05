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
#' @param ... other arguments passed on to \code{\link{plot_spec}}
#' @param debug if \code{TRUE} embeds spec in file and uses svg renderer,
#'   which makes the plot easier to debug
#' @importFrom whisker whisker.render
#' @importFrom ggplot2 is.ggplot
#' @importFrom RJSONIO toJSON
#' @docType package
gg2v <- function(base_path = ".", plot = last_plot(), name = "test", ...,
                 debug = TRUE) {
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

  # Copy needed files over
  data_dir <- file.path(base_path, "data")
  if (!file.exists(data_dir)) dir.create(data_dir)

  spec <- plot_spec(plot, data_dir = data_dir, ...)
  spec_js <- toJSON(vis, pretty = debug)

  # Render html template
  if (!debug) {
    tmpl <- readLines(system.file("templates", "render.html", package = "gg2v"))
    out <- whisker.render(tmpl, list(
      title = paste0("gg2v: ", name),
      spec_path = basename(spec_path)))
    writeLines(out, html_path)

    writeLines(spec_js, spec_path)
  } else {
    tmpl <- readLines(system.file("templates", "debug.html", package = "gg2v"))
    out <- whisker.render(tmpl, list(
      title = paste0("gg2v: ", name),
      spec = spec_js))
    writeLines(out, html_path)

  }

  invisible()
}

default_name <- function(plot) {
  ggplot2:::digest.ggplot(plot)
}


#' @param width width of visualisation in pixels
#' @param height height of visualisation in pixels
#' @param padding a numeric vector of length 4 giving the padding on the
#'  top, right, bottom and left sides respectively.
#' @export
plot_spec <- function(plot,
                      width = 600, height = 400,
                      padding = c(20, 20, 20, 20),
                      embed_data = FALSE, data_dir = NULL) {
  stopifnot(is.ggplot(plot))
  stopifnot(is.numeric(width), length(width) == 1, width > 0)
  stopifnot(is.numeric(height), length(height) == 1, height > 0)
  stopifnot(is.numeric(padding), length(padding) == 4)

  if (embed_data) {
    data <- plot_data(plot)
    data_df <- lapply(data, d3df)
    data <- unname(Map(function(name, values) list(name = name, values = values),
      names(data), data_df))
  } else {
    stopifnot(is.character(data_dir), length(data_dir) == 1,
      file.exists(data_dir), is.dir(data_dir))
    data <- save_data(plot, data_dir)
  }
  scales <- plot_scales(plot)
  layer <- c(list(bg_layer()), plot_layers(plot))

  padding <- as.list(padding)
  names(padding) <- c("top", "right", "bottom", "left")

  list(
    width = width,
    height = height,
    data = data,
    scales = scales,
    marks = layer,
    axes = list(
      list(type = "x", scale = "x"),
      list(type = "y", scale = "y")
    ),
    padding = padding
  )
}

save_spec <- function(path, plot = last_plot(), ...) {
  stopifnot(is.character(path), length(path) == 1, file.exists(dirname(path)))

  spec <- plot_spec(plot, embed_data = TRUE, ...)
  spec_js <- toJSON(spec, pretty = TRUE)
  writeLines(spec_js, path)
}

d3df <- function(x) {
  n <- nrow(x)
  lapply(seq_len(n), function(i) as.list(x[i, ]))
}
