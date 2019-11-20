#' bar plot
#'
#' @description This function creates ep formatted, standardized box plots.
#' @param df A data frame.
#' @param x A categorical variable for the x axis groupings.
#' @param y A numerical variable for the y axis levels.
#' @param fill Select an additional grouping variable to be used for density plotting. Defaults to NULL.
#' @param facet Select an additional faceting variable to create facets. Defaults to NULL.
#' @param ticks Select the number of ticks on the x and y axis. Defaults to 10.
#' @param angle Select the rotation angle for the x axis labels. Defaults to 0.
#' @template title Should the plot title appear automatically. Defaults to TRUE.
#' @param subtitle Text that is displayed on the subtitle. Defaults to NULL.
#' @param caption Text that is displayed on the caption. Defaults to NULL.
#' @param x.lab Text that is displayed on the x axis. Defaults to "range".
#' @param y.lab Text that is displayed on the y axis. Defaults to "Density".
#' @param suffix Suffix added to  x-axis adn y-axis.
#' @param legend.position Where should the plot legend appear. Defaults to "none".
#' @return ggplot
#' @keywords box plot
#' @import dplyr, ggplot2, rlang, tidyquant
#' @export
#' @examples plot.bar(df = df, x = x, y = y)
#'
plot.bar <- function(df, x, y, fill, facet = NULL,
                     ticks = 10, angle = 0, title = TRUE, subtitle = NULL, caption = NULL,
                     x.lab = "Value range", y.lab = "Bar", suffix = '', legend.position = "none") {

  if (!is.data.frame(df)) stop("object must be a data frame")

  var_x     <- rlang::enquo(x)
  var_y     <- rlang::enquo(y)
  var_fill  <- rlang::enquo(fill)
  var_facet <- rlang::enquo(facet)

  max_y     <- df %>% dplyr::summarise(max = max({{y}}, na.rm = TRUE)) %>% dplyr::pull()

  plot <- df %>%
    ggplot2::ggplot(aes(x = {{x}}, y = {{y}}, fill = factor({{fill}}))) +
    ggplot2::geom_bar(stat="identity") +
    ggplot2::geom_text(aes(label= round({{y}}, digits = 1), y = {{y}}),
              position = position_dodge(width = 0.9),
              hjust = 0.5 , vjust= 1.5,
              color = 'white', size = 4) +
    ggplot2::ggtitle(label =
              if (title == TRUE) {glue::glue("Histogramm: {rlang::quo_text(var_x)}")}
            else if (is.character(title)) {title}
            else {element_blank()}) +
    ggplot2::labs(fill = glue::glue("{ggrapid::first_to_upper(rlang::quo_text(var_fill))}:"),
         x = x.lab, y = y.lab) +
    ggplot2::labs(subtitle =
           if (is.null(subtitle)) {ggplot2::element_blank()}
         else {subtitle}) +
    ggplot2::labs(caption =
           if (is.null(caption)) {ggplot2::element_blank()}
         else {caption}) +
    ggplot2::scale_y_continuous(labels = scales::number_format(suffix = {{suffix}}, prefix = "", big.mark = '.', decimal.mark = ','),
                                limits = c(0, max_y*1.2)) +
    scale.fill.ep(palette = 'main') +
    ep.theme(legend.position = {{legend.position}}, angle = angle) +
    geom_hline(yintercept = 0) +
    ep.theme(legend.position = {{legend.position}}, angle = angle)

  if (!rlang::quo_is_null(var_facet)) {

    plot <- plot +
      ggplot2::facet_wrap(rlang::quo_text(var_facet), scales = "free_y")

  }

  return(plot)

}
