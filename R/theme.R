#' ep theme
#'
#' @description This function creates a theme using "Europace Sans Medium" front
#' @param legend.position The position of the legend. Default to none
#' @param angle Select the rotation angle for the x axis labels. Defaults to 0.
#' @return theme
#' @keywords theme
#' @import ggplot2, tidyquant
#' @export
#' @examples ep.theme(legend.position = 'none', angle = 0)

ep.theme <- function(legend.position = 'none', angle = 0) {

  theme <- tidyquant::theme_tq() +
    ggplot2::theme(legend.position = {{legend.position}},
                   panel.grid.minor = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_text(angle = angle, hjust = ifelse(angle != 0, 1, 0.5)),
                   text = ggplot2::element_text(family = "Europace Sans Medium"),
                   plot.title = ggplot2::element_text(family = "Europace Sans Medium"))

  return(theme)

}
