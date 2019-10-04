#' histogram
#'
#' @description This function creates ep formatted, standardized box plots.
#' @param df A data frame.
#' @param x A numerical variable to plot.
#' @param fill Select an additional grouping variable to be used for density plotting. Defaults to NULL.
#' @param facet Select an additional faceting variable to create facets. Defaults to NULL.
#' @param binwidth A numerical variable to determine the bin size.
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
#' @examples plot.histogram(df = df, x = x, y = y)

plot.histogram <- function (df, x, fill = "#f07855", facet = NULL, binwidth = 5,
                            ticks = 10, angle = 0, title = TRUE, subtitle = NULL, caption = NULL,
                            x.lab = "Value range", y.lab = "Density", suffix = '', legend.position = "none",
                            quantile.low = 0, quantile.high = 1) {

  if (!is.data.frame(df)) stop("object must be a data frame")

  number_ticks <- function(n = 10) {

    if (!is.numeric(n))
      stop("n must be a numeric input")

    function(limits) {pretty(limits, n)}

  }

  var_x     <- rlang::enquo(x)
  var_fill  <- rlang::enquo(fill)
  var_facet <- rlang::enquo(facet)

  limits <- df %>%
    dplyr::select(value = !!var_x) %>%
    dplyr::summarise(min = stats::quantile(value, quantile.low[[1]], na.rm = TRUE),
                     max = stats::quantile(value, quantile.high[[1]], na.rm = TRUE))

  plot <- df %>%
    ggplot2::ggplot(aes(x = {{x}})) +
    ggplot2::geom_histogram(aes(fill = "#3d5167", color = {{fill}}), binwidth = {{binwidth}}) +
    ggplot2::geom_vline(aes(xintercept=median({{x}})), linetype = 2, size = 1, color = "#3d5167", alpha = 0.8) +
    ggplot2::ggtitle(label =
              if (title == TRUE) {glue::glue("Histogramm: {rlang::quo_text(var_x)}")}
            else if (is.character(title)) {title}
            else {ggplot2::element_blank()}) +
    ggplot2::labs(fill = glue::glue("{ggrapid::first_to_upper(rlang::quo_text(var_fill))}:"),
         x = x.lab, y = y.lab) +
    ggplot2::labs(subtitle =
           if (is.null(subtitle)) {ggplot2::element_blank()}
         else {subtitle}) +
    ggplot2::labs(caption =
           if (is.null(caption)) {ggplot2::element_blank()}
         else {caption}) +
    ggplot2::scale_x_continuous(limits = c(limits$min, limits$max),
                       breaks = number_ticks(ticks),
                       labels = scales::number_format(suffix = {{suffix}}, prefix = "", big.mark = '.', decimal.mark = ',')) +
    ggplot2::scale_y_continuous(breaks = number_ticks(ticks),
                       labels = scales::number_format(suffix = {{suffix}}, prefix = "", big.mark = '.', decimal.mark = ',')) +
    scale.color.ep(palette = 'main') +
    tidyquant::theme_tq() +
    ggplot2::theme(legend.position = {{legend.position}},
                   panel.grid.minor = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_text(angle = angle, hjust = ifelse(angle != 0, 1, 0.5)),
                   text = ggplot2::element_text(family = "Europace Sans Light"),
                   plot.title = ggplot2::element_text(family = "Europace Sans Medium"))

  if (!rlang::quo_is_null(var_facet)) {

    plot <- plot +
      facet_wrap(rlang::quo_text(var_facet), scales = "free_x")

  }

  return(plot)

}
