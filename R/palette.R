#' ep palette
#'
#' @description This function creates ep color palette. It is used as a helper function for scale.color.ep and scale.fill.ep.
#' @param palette The color palette.
#' @param reverse A logical variable. Defaults "FALSE"
#' @return palette
#' @keywords palette
#' @import ggplot2
#' @export
#' @examples ep.pal(palette = "main")

ep.pal <- function(palette = "main", reverse = FALSE, ...) {

  ep.colors <- c(
    `red`        = "#f07855",
    `blue`       = "#3d5167",
    `light green`= "#abd8ce",
    `purple`     = "#cfc5d6",
    `yellow`     = "#ffdd86",
    `light blue` = "#bae2f5",
    `green`      = "#cbdd92"
  )

  ep.cols <- function(...) {
    cols <- c(...)

    if (is.null(cols))
      return (ep.colors)

    ep.colors[cols]
  }

  ep.palettes <- list(
    `main`  = ep.cols("red", "blue"),

    `cool`  = ep.cols('light green', "purple", "light blue"),

    `hot`   = ep.cols("yellow", "green", "red"),

    `mixed` = ep.cols("red", "blue", "yellow", "purple", "'light green'"),

    `dark`  = ep.cols("blue", "purple")
  )

  pal <- ep.palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}
