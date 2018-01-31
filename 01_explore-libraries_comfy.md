01\_explore-libraries\_comfy.R
================
dag
Wed Jan 31 16:26:38 2018

``` r
## Libraries 

library(usethis)
library(fs)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "C:/Users/dag/Documents/R/win-library/3.4"
    ## [2] "C:/Program Files/R/R-3.4.3/library"

``` r
.Library # defualt library 
```

    ## [1] "C:/PROGRA~1/R/R-34~1.3/library"

``` r
path_real(.Library) # show the true path (not sympolic link)
```

    ## C:/Program Files/R/R-3.4.3/library

Installed packages

``` r
## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect
head(installed.packages())
```

    ##            Package      LibPath                                   
    ## assertthat "assertthat" "C:/Users/dag/Documents/R/win-library/3.4"
    ## backports  "backports"  "C:/Users/dag/Documents/R/win-library/3.4"
    ## base64enc  "base64enc"  "C:/Users/dag/Documents/R/win-library/3.4"
    ## BH         "BH"         "C:/Users/dag/Documents/R/win-library/3.4"
    ## bindr      "bindr"      "C:/Users/dag/Documents/R/win-library/3.4"
    ## bindrcpp   "bindrcpp"   "C:/Users/dag/Documents/R/win-library/3.4"
    ##            Version    Priority Depends        Imports       LinkingTo    
    ## assertthat "0.2.0"    NA       NA             "tools"       NA           
    ## backports  "1.1.2"    NA       "R (>= 3.0.0)" "utils"       NA           
    ## base64enc  "0.1-3"    NA       "R (>= 2.9.0)" NA            NA           
    ## BH         "1.65.0-1" NA       NA             NA            NA           
    ## bindr      "0.1"      NA       NA             NA            NA           
    ## bindrcpp   "0.2"      NA       NA             "Rcpp, bindr" "Rcpp, plogr"
    ##            Suggests   Enhances License              License_is_FOSS
    ## assertthat "testthat" NA       "GPL-3"              NA             
    ## backports  NA         NA       "GPL-2"              NA             
    ## base64enc  NA         "png"    "GPL-2 | GPL-3"      NA             
    ## BH         NA         NA       "BSL-1.0"            NA             
    ## bindr      "testthat" NA       "MIT + file LICENSE" NA             
    ## bindrcpp   "testthat" NA       "MIT + file LICENSE" NA             
    ##            License_restricts_use OS_type MD5sum NeedsCompilation Built  
    ## assertthat NA                    NA      NA     "no"             "3.4.3"
    ## backports  NA                    NA      NA     "yes"            "3.4.3"
    ## base64enc  NA                    NA      NA     "yes"            "3.4.1"
    ## BH         NA                    NA      NA     "no"             "3.4.1"
    ## bindr      NA                    NA      NA     "no"             "3.4.3"
    ## bindrcpp   NA                    NA      NA     "yes"            "3.4.3"

``` r
pk <- as.data.frame(installed.packages())

## how many packages?
class(pk)
```

    ## [1] "data.frame"

``` r
nrow(pk)
```

    ## [1] 124

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
summary(pk$LibPath)
```

    ##       C:/Program Files/R/R-3.4.3/library 
    ##                                       30 
    ## C:/Users/dag/Documents/R/win-library/3.4 
    ##                                       94

``` r
summary(pk$Priority)
```

    ##        base recommended        NA's 
    ##          14          18          92

``` r
summary(pk$Version)
```

    ##      0.1    0.1-1    0.1-3    0.1.1    0.1.2    0.1.6   0.10.1  0.12.15 
    ##        3        1        1        1        1        1        1        1 
    ##      0.2   0.2-15    0.2.0    0.2.1    0.2.3    0.2.4  0.20-35   0.21.0 
    ##        1        1        4        1        1        1        1        1 
    ##      0.3    0.3-1    0.3-2    0.3.0    0.3.2    0.3.6    0.4.0    0.4.1 
    ##        1        1        1        1        1        1        1        1 
    ##    0.4.3      0.5    0.5.0      0.6   0.6.14      0.7    0.7.2    0.7.4 
    ##        2        1        1        1        1        2        1        1 
    ##      0.8   0.8-69    0.9.9    1.0-6    1.0.0    1.0.1    1.1-2    1.1.0 
    ##        1        1        1        1        4        2        1        5 
    ##    1.1.1    1.1.2    1.1.3    1.1.6   1.13.4   1.17.1     1.19   1.2-12 
    ##        3        1        1        1        1        1        1        1 
    ##    1.2.0    1.2.1    1.3-2   1.3-20    1.3.1    1.3.4    1.4.2    1.4.3 
    ##        6        1        2        1        1        1        1        1 
    ##      1.5    1.5-5 1.65.0-1    1.7.1    1.7.8      1.8   1.8-22   1.8-23 
    ##        2        1        1        1        1        1        1        1 
    ##    1.8.4    2.0-0    2.0.0    2.0.1    2.0.6    2.1.1   2.1.16    2.2.1 
    ##        1        1        1        2        1        1        1        1 
    ##    2.2.2  2.23-15   2.41-3      3.1  3.1-131    3.4.3   4.1-11   4.1-12 
    ##        1        1        1        1        1       15        1        1 
    ##   7.3-11   7.3-12   7.3-14   7.3-47   7.3-48 
    ##        1        1        1        1        1

``` r
##   * what proportion need compilation?
##   * how break down re: version of R they were built on

## for tidyverts, here are some useful patterns
# data %>% count(var)
pk %>% count(LibPath)
```

    ## # A tibble: 2 x 2
    ##   LibPath                                      n
    ##   <fct>                                    <int>
    ## 1 C:/Program Files/R/R-3.4.3/library          30
    ## 2 C:/Users/dag/Documents/R/win-library/3.4    94

``` r
pk %>% count(LibPath, Priority)
```

    ## # A tibble: 5 x 3
    ##   LibPath                                  Priority        n
    ##   <fct>                                    <fct>       <int>
    ## 1 C:/Program Files/R/R-3.4.3/library       base           14
    ## 2 C:/Program Files/R/R-3.4.3/library       recommended    15
    ## 3 C:/Program Files/R/R-3.4.3/library       <NA>            1
    ## 4 C:/Users/dag/Documents/R/win-library/3.4 recommended     3
    ## 5 C:/Users/dag/Documents/R/win-library/3.4 <NA>           91

``` r
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

##   * what proportion need compilation? # have C++?
pk %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <fct>            <int>  <dbl>
    ## 1 no                  53 0.427 
    ## 2 yes                 65 0.524 
    ## 3 <NA>                 6 0.0484

``` r
##   * how break down re: version of R they were built on
# how recently were the updated?
pk %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   Built     n    prop
    ##   <fct> <int>   <dbl>
    ## 1 3.4.1     8 0.0645 
    ## 2 3.4.2     1 0.00806
    ## 3 3.4.3   115 0.927

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- pk %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ## [1] "translations"

``` r
##   * how does the result of .libPaths() relate to the result of .Library?

ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F         55 0.444
    ## 2 T         69 0.556

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

devtools::session_info()
```

    ## Session info -------------------------------------------------------------

    ##  setting  value                       
    ##  version  R version 3.4.3 (2017-11-30)
    ##  system   x86_64, mingw32             
    ##  ui       RTerm                       
    ##  language (EN)                        
    ##  collate  English_United States.1252  
    ##  tz       America/Chicago             
    ##  date     2018-01-31

    ## Packages -----------------------------------------------------------------

    ##  package    * version date       source        
    ##  assertthat   0.2.0   2017-04-11 CRAN (R 3.4.3)
    ##  backports    1.1.2   2017-12-13 CRAN (R 3.4.3)
    ##  base       * 3.4.3   2017-12-06 local         
    ##  bindr        0.1     2016-11-13 CRAN (R 3.4.3)
    ##  bindrcpp   * 0.2     2017-06-17 CRAN (R 3.4.3)
    ##  cli          1.0.0   2017-11-05 CRAN (R 3.4.3)
    ##  compiler     3.4.3   2017-12-06 local         
    ##  crayon       1.3.4   2017-09-16 CRAN (R 3.4.3)
    ##  datasets   * 3.4.3   2017-12-06 local         
    ##  devtools     1.13.4  2017-11-09 CRAN (R 3.4.3)
    ##  digest       0.6.14  2018-01-14 CRAN (R 3.4.3)
    ##  dplyr      * 0.7.4   2017-09-28 CRAN (R 3.4.3)
    ##  evaluate     0.10.1  2017-06-24 CRAN (R 3.4.3)
    ##  fs         * 1.1.0   2018-01-26 CRAN (R 3.4.3)
    ##  glue         1.2.0   2017-10-29 CRAN (R 3.4.3)
    ##  graphics   * 3.4.3   2017-12-06 local         
    ##  grDevices  * 3.4.3   2017-12-06 local         
    ##  htmltools    0.3.6   2017-04-28 CRAN (R 3.4.3)
    ##  knitr        1.19    2018-01-29 CRAN (R 3.4.3)
    ##  magrittr     1.5     2014-11-22 CRAN (R 3.4.3)
    ##  memoise      1.1.0   2017-04-21 CRAN (R 3.4.3)
    ##  methods    * 3.4.3   2017-12-06 local         
    ##  pillar       1.1.0   2018-01-14 CRAN (R 3.4.3)
    ##  pkgconfig    2.0.1   2017-03-21 CRAN (R 3.4.3)
    ##  R6           2.2.2   2017-06-17 CRAN (R 3.4.3)
    ##  Rcpp         0.12.15 2018-01-20 CRAN (R 3.4.3)
    ##  rlang        0.1.6   2017-12-21 CRAN (R 3.4.3)
    ##  rmarkdown    1.8     2017-11-17 CRAN (R 3.4.3)
    ##  rprojroot    1.3-2   2018-01-03 CRAN (R 3.4.3)
    ##  stats      * 3.4.3   2017-12-06 local         
    ##  stringi      1.1.6   2017-11-17 CRAN (R 3.4.2)
    ##  stringr      1.2.0   2017-02-18 CRAN (R 3.4.3)
    ##  tibble       1.4.2   2018-01-22 CRAN (R 3.4.3)
    ##  tools        3.4.3   2017-12-06 local         
    ##  usethis    * 1.2.0   2018-01-19 CRAN (R 3.4.3)
    ##  utf8         1.1.3   2018-01-03 CRAN (R 3.4.3)
    ##  utils      * 3.4.3   2017-12-06 local         
    ##  withr        2.1.1   2017-12-19 CRAN (R 3.4.3)
    ##  yaml         2.1.16  2017-12-12 CRAN (R 3.4.3)
