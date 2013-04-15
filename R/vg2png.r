#' Render a vega plot spec to png.
#'
#' @param src path to vega json file
#' @param dest path to write output png. If not specified, defaults
#'  the same path as \code{src} but with extension \file{.png}.
#' @importFrom tools file_path_sans_ext
#' @export
vg2png <- function(src, dest = NULL) {
  stopifnot(file.exists(src))

  vg2png <- Sys.which("vg2png")[[1]]
  if (vg2png == "") stop("Can't find vg2png", call. = FALSE)

  dest <- dest %||% paste0(file_path_sans_ext(src), ".png")

  cmd <- paste0("vg2png ", shQuote(src), " ", shQuote(dest))
  system(cmd)
}


