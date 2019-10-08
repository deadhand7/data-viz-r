
# DataVizR

## Installation

``` r
# install.packages("devtools")
devtools::install_github("deadhand7/data-viz-r")
```

    ## Skipping install of 'DataVizR' from a github remote, the SHA1 (09e7e297) has not changed since last install.
    ##   Use `force = TRUE` to force installation

## Overview

The package provides a palette based on Europace color codes and a
custom theme which uses the Europace fronts. Additionally, some flexible
quick-access plotting functions are included.

### Main Functions

  - `ep.theme()`
  - `scale.fill.ep()`
  - `scale.color.ep`
  - `plot.histogram`
  - `plot.density`
  - `plot.boxplot`

### Customize an existing ggplot

``` r
iris %>% 
  ggplot(aes(x = Species, y = Sepal.Width, fill = Species)) +
  geom_violin() +
  scale.fill.ep('cool') +
  ep.theme()
```

![](man/figures/unnamed-chunk-3-1.png)<!-- -->

### Histogram

``` r
plot.histogram(df = mtcars, x = mpg, binwidth = 1, ticks = 5)  
```

![](man/figures/unnamed-chunk-4-1.png)<!-- -->

### Facets

``` r
DataVizR::plot.histogram(df = iris, x = Petal.Width, binwidth = 1, facet = Species, ticks = 3)  
```

![](man/figures/unnamed-chunk-5-1.png)<!-- -->

### Density Plot

``` r
plot.density(df = mtcars, x = qsec)  
```

![](man/figures/unnamed-chunk-6-1.png)<!-- -->

### Box-Plot

``` r
plot.boxplot(df = iris, x = Species, y = Sepal.Length, fill = Species, x.lab = 'Species', ticks = 4)
```

![](man/figures/unnamed-chunk-7-1.png)<!-- -->
