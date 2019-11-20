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
                   plot.title = ggplot2::element_text(family = "Europace Sans Medium"),
                   text = ggplot2::element_text(family="Europace Sans Book",
                                                color = '#B9B9B9'),
                   panel.grid = ggplot2::element_line(color = '#E9E9E9', size = 1),
                   panel.grid.major.x = ggplot2::element_blank(),
                   panel.grid.major.x = ggplot2::element_blank(),
                   panel.border = ggplot2::element_blank()
                   )

  return(theme)

}
