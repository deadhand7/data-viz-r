#' scale ticks
#'
#' @description This is an auxiliary function which is used to determine the number of scale ticks in a plot.
#' @param n The number of ticks. Default to 10
#' @return ticks
#' @keywords ticks
#' @export
#' @examples scale.ticks(n = 10)

scale.ticks <- function(n = 10) {

  if (!is.numeric(n))
    stop("n must be a numeric input")

  function(limits) {pretty(limits, n)}

}
