#' Show gg2v output
#'
#' @param x path or url to show
#' @keywords internal
show <- function(x) {
  if (file.exists(x)) {
    browseURL(paste0("file://", td)
  } else {
    browseURL(x)
  }

}

