is.waiver <- function(x) inherits(x, "waiver")

"%||%" <- function(a, b) {
  if (is.null(a) || is.waiver(a)) b else a
}

compact <- function(x) Filter(Negate(is.null), x)

modify_list <- function(x, y) {
  if (is.null(x)) x <- list()
  if (is.null(y)) y <- list()

  modifyList(x, y)
}


is.dir <- function(x) {
  file.info(x)$isdir
}
