#' box plot
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
#' @param quantile.low Select lower percentile for outliers exclusion. Defaults to 0.0\%.
#' @param quantile.high Select upper percentile for outliers exclusion. Defaults to 1.0\%.
#' @return ggplot
#' @keywords box plot
#' @import dplyr, ggplot2, rlang, tidyquant
#' @export
#' @examples plot.boxplot(df = df, x = x, y = y)

plot.boxplot <- function (df, x, y, fill = "#f07855", facet = NULL, ticks = 10, angle = 0,
                          title = TRUE, subtitle = NULL, caption = NULL, x.lab = "Level",
                          y.lab = "Value range", suffix = '', legend.position = "none",
                          quantile.low = 0, quantile.high = 1)
{

  if (!is.data.frame(df)) stop("object must be a data frame")

  number_ticks <- function(n = 10) {

    if (!is.numeric(n))
      stop("n must be a numeric input")

    function(limits) {pretty(limits, n)}

  }

  var_x     <- rlang::enquo(x)
  var_y     <- rlang::enquo(y)
  var_fill  <- rlang::enquo(fill)
  var_facet <- rlang::enquo(facet)

  limits <- df %>%
    dplyr::select(value = !!var_y) %>%
    dplyr::summarise(min = stats::quantile(value, quantile.low[[1]], na.rm = TRUE),
                     max = stats::quantile(value, quantile.high[[1]], na.rm = TRUE))

  plot <- df %>%
    ggplot2::ggplot() +
    ggplot2::geom_boxplot(aes(x = {{x}}, y = {{y}}, fill = factor({{fill}})), color = '#3d5167') +
    ggplot2::geom_hline(aes(yintercept = mean({{y}})), linetype = 2, size = 1, color = "#3d5167", alpha = 0.8) +
    ggplot2::ggtitle(label =
              if (title == TRUE) {glue::glue("Boxplot: {rlang::quo_text(var_y)} nach {rlang::quo_text(var_x)}")}
            else if (is.character(title)) {title}
            else {element_blank()}) +
    ggplot2::labs(fill = glue::glue("{ggrapid::first_to_upper(rlang::quo_text(var_fill))}:"),
         x = x.lab, y = y.lab) +
    ggplot2::labs(subtitle =
           if (is.null(subtitle)) {element_blank()}
         else {subtitle}) +
    ggplot2::labs(caption =
           if (is.null(caption)) {element_blank()}
         else {caption}) +
    ggplot2::scale_y_continuous(limits = c(limits$min, limits$max),
                       breaks = number_ticks(ticks),
                       labels = scales::number_format(suffix = {{suffix}}, prefix = "", big.mark = '.', decimal.mark = ',')) +
    scale.fill.ep(palette = 'main') +
    ep.theme(legend.position = {{legend.position}}, angle = angle)

  if (!rlang::quo_is_null(var_facet)) {

    plot <- plot + ggplot2::facet_wrap(rlang::quo_text(var_facet),
                              scales = "free_x")
  }

  return(plot)

}
