convert_scale <- function(x, uses, ...) UseMethod("convert_scale")

convert_scale.position_c <- function(x, uses, ...) {
  var <- x$aesthetics[[1]]
  scale(
    name = var,
    type = convert_trans(x$trans),
    domain = x$limits %||% uses,
    range = c(x = "width", y = "height")[[var]])
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

