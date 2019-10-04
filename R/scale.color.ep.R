#' fill scale color
#'
#' @description This function creates ep formatted, standardized density plots.
#' @param palette The color palette.
#' @param discrete A logical variable. Defaults "FALSE".
#' @param reverse A logical variable. Defaults "FALSE".
#' @return ggplot
#' @keywords density
#' @import ggplot2
#' @export
#' @examples scale_color_ep(palette = "main")

scale.color.ep <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ep_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("ep_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

scale_fill_ep <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ep_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("ep_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
