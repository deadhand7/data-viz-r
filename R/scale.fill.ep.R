#' ep scale fill
#'
#' @description This function creates applies the ep palette to ggplot graphs
#' @param palette The color palette.
#' @param discrete A logical variable. Defaults "FALSE".
#' @param reverse A logical variable. Defaults "FALSE".
#' @return ggplot
#' @keywords scale fill
#' @import ggplot2
#' @export
#' @examples scale.fill.ep(palette = "main")

scale.fill.ep <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {

  pal <- ep.pal(palette = palette, reverse = reverse)

  if (discrete) {ggplot2::discrete_scale("fill", paste0("ep_", palette), palette = pal, ...)}

  else {ggplot2::scale_fill_gradientn(colours = pal(256), ...)}
}
