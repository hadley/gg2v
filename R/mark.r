
mark_props <- function(update = NULL, enter = NULL, exit = NULL) {
  compact(list(update = update, enter = enter, exit = exit))
}

mark <- function(type = NULL, name = NULL, description = NULL, from = NULL,
                 properties = NULL, delay = NULL, ease = NULL) {
  compact(list(type = type, name = name, description = description, from = from,
    properties = properties, delay = delay, ease = ease))
}

valref <- function(value = NULL, field = NULL, scale = NULL, mult = NULL,
                   offset = NULL, band = NULL) {
  if (is.null(value) && is.null(field)) return()
  if (!is.null(value) && !is.null(field)) {
    stop("Can only specify one of field and value")
  }

  compact(list(
    value = value,
    field = if (!is.null(field)) paste0("data.", field),
    scale = scale,
    mult = mult,
    offset = offset,
    band = band
  ))
}
