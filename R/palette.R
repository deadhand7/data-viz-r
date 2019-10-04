#' ep palette
#'
#' @description This function creates ep color palette. It is used as a helper function for scale.color.ep and scale.fill.ep.
#' @param palette The color palette.
#' @param reverse A logical variable. Defaults "FALSE"
#' @return palette
#' @keywords palette
#' @import ggplot2
#' @export
#' @examples ep_pal(palette = "main")

ep_pal <- function(palette = "main", reverse = FALSE, ...) {

  ep_colors <- c(
    `red`        = "#f07855",
    `blue`       = "#3d5167",
    `light green`= "#abd8ce",
    `purple`     = "#cfc5d6",
    `yellow`     = "#ffdd86",
    `light blue` = "#bae2f5",
    `green`      = "#cbdd92"
  )

  ep_cols <- function(...) {
    cols <- c(...)

    if (is.null(cols))
      return (ep_colors)

    ep_colors[cols]
  }

  ep_palettes <- list(
    `main`  = ep_cols("red", "blue"),

    `cool`  = ep_cols('light green', "purple", "light blue"),

    `hot`   = ep_cols("yellow", "green", "red"),

    `mixed` = ep_cols("red", "blue", "yellow", "purple", "'light green'"),

    `dark`  = ep_cols("blue", "purple")
  )

  pal <- ep_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}
