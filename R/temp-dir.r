#' Create a temporary directory.
#'
#' @export
temp_dir <- function() {
  path <- tempfile("gg2v-")
  dir.create(path)
  path
}
