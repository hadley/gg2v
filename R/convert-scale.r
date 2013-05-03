convert_scale <- function(x, uses, ...) UseMethod("convert_scale")

#' @S3method convert_scale NULL
convert_scale.NULL <- function(x, uses, ...) NULL

#' @S3method convert_scale position_c
convert_scale.position_c <- function(x, uses, ...) {
  var <- x$aesthetics[[1]]
  scale(
    name = var,
    type = convert_trans(x$trans),
    domain = x$limits %||% uses,
    range = c(x = "width", y = "height")[[var]],
    zero = FALSE,
    nice = TRUE
  )
}

#' @S3method convert_scale position_d
convert_scale.position_d <- function(x, uses, ...) {
  var <- x$aesthetics[[1]]
  scale(
    name = var,
    type = "ordinal",
    domain = x$limits %||% uses,
    points = TRUE,
    range = c(x = "width", y = "height")[[var]]
  )
}

#' @S3method convert_scale hue
convert_scale.hue <- function(x, uses, ...) {
  scale(
    name = x$aesthetics,
    type = "ordinal",
    domain = x$limits %||% uses,
    points = TRUE,
    range = x$palette(5)
  )
}


#' @S3method convert_scale gradient
convert_scale.gradient <- function(x, uses, ...) {
  scale(
    name = x$aesthetics,
    type = "linear",
    domain = x$limits %||% uses,
    range = x$palette(c(0, 1))
  )
}


convert_trans <- function(x) {
  map <- c(
    "identity" = "linear", "sqrt" = "sqrt",
    "log-10" = "log", "log-2.7" = "log", "log2" = "log")

  nm <- x$name
  if (!(nm %in% names(map))) {
    stop("No equivalent transformation in vega: ", nm, call. = FALSE)
  }

  map[[nm]]
}

