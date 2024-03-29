#' fill scale color
#'
#' @description This function creates applies the ep palette to ggplot graphs.
#' @param palette The color palette.
#' @param discrete A logical variable. Defaults "FALSE".
#' @param reverse A logical variable. Defaults "FALSE".
#' @return ggplot
#' @keywords scale color
#' @import ggplot2
#' @export
#' @examples scale.color.ep(palette = "main")

scale.color.ep <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {

  pal <- ep.pal(palette = palette, reverse = reverse)

  if (discrete) {ggplot2::discrete_scale("colour", paste0("ep_", palette), palette = pal, ...)}

  else {ggplot2::scale_color_gradientn(colours = pal(256), ...)}
}
