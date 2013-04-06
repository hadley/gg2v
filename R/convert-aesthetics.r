convert_value <- function(x, visprop = NULL) {
  if (is.null(visprop)) return(x)
  stopifnot(is.character(visprop), length(visprop) == 1)

  f <- paste0("convert_", visprop)
  if (!exists(f, mode = "function")) return(x)

  get(f, mode = "function")(x)
}

convert_fill <- convert_stroke <- function(x) {
  if (is.null(x)) return(x)

  rgb(t(col2rgb(x)), max = 255)
}

convert_symbol <- function(x) {
  if (is.null(x)) return(x)

  # http://www.cookbook-r.com/Graphs/Shapes_and_line_types/
  shape <- c(
    "square", "circle", "triangle-up", NA, "cross", NA,
    "triangle-down", NA, NA, NA, NA, NA,
    NA, NA, NA, "square", "circle", "triangle-up",
    "diamond", "circle", "circle", "circle", "square", "diamonds",
    "triangle-up", "triangle-down", NA, NA, "circle", "circle",
    NA, NA, NA, NA, NA, NA)

  shape[x]
}

shape_aesthetics <- function(x) {
  if (is.null(x)) return(x)

  if (pch <= 14) {
    c("stroke" = "colour")
  } else if (pch <= 20) {
    c("stroke" = "colour", "fill" = "colour")
  } else {
    c("stroke" = "colour", "fill" = "fill")
  }
}

#' Approximately convert mm to pixels
convert_strokeWidth <- convert_fontSize <- function(x, dpi = 72) {
  if (is.null(x)) return(x)

  x / 25.4 * dpi
}
convert_size <- function(x, dpi = 72) {
  if (is.null(x)) return(x)
  convert_fontSize(x, dpi = dpi) ^ 2
}

# The specification of ‘fontface’ can be an integer or a string.  If
# an integer, then it follows the R base graphics standard: 1 =
# plain, 2 = bold, 3 = italic, 4 = bold italic.  If a string, then
# valid values are: ‘"plain"’, ‘"bold"’, ‘"italic"’, ‘"oblique"’,
# and ‘"bold.italic"’.  For the special case of the HersheySerif
# font family, ‘"cyrillic"’, ‘"cyrillic.oblique"’, and ‘"EUC"’ are
# also available.
convert_weight <- function(x) {
  if (is.null(x)) return()

  list(
    bold = "bold",
    bold.italic = "bold"
  )[[x]]
}
convert_style <- function(x) {
  if (is.null(x)) return()

  list(
    italic = "italic",
    bold.italic = "italic",
    oblique = "oblique"
  )[[x]]
}
