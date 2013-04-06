is.waiver <- function(x) inherits(x, "waiver")

"%||%" <- function(a, b) {
  if (is.null(a) || is.waiver(a)) b else a
}

compact <- function(x) Filter(Negate(is.null), x)

maybe <- function(f) {
  function(x, ...) {
    if (is.null(x) || length(x) == 0) return()
    f(x, ...)
  }
}

modify_list <- function(x, y, recurse = FALSE) {
  if (is.null(x)) x <- list()
  if (is.null(y)) y <- list()

  if (recurse) {
    modifyList(x, y)
  } else {
    x[names(y)] <- y
    x
  }

}

is.dir <- function(x) {
  file.info(x)$isdir
}


invert <- function(L) {
  t1 <- unlist(L)
  names(t1) <- rep(names(L), lapply(L, length))
  tapply(names(t1), t1, c)
}


has_name <- function(nm, x) {
  nm %in% names(x)
}
