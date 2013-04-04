scale <- function(name = NULL, type = NULL, domain = NULL, domainMin = NULL,
                  domainMax = NULL, range = NULL, rangeMin = NULL,
                  rangeMax = NULL, reverse = NULL, round = NULL) {

  compact(list(
    name = name,
    type = type,
    domain = domain,
    domainMin = domainMin,
    domainMax = domainMax,
    rangeMin = rangeMin,
    rangeMax = rangeMax,
    reverse = reverse,
    round = round))
}
