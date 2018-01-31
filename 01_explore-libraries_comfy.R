#' ---
#' output: github_document
#' ---
#' 

## Libraries 

library(usethis)
library(fs)
library(dplyr)

#' Which libraries does R search for packages?
.libPaths()
.Library # defualt library 
path_real(.Library) # show the true path (not sympolic link)


#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect
head(installed.packages())
pk <- as.data.frame(installed.packages())

## how many packages?
class(pk)
nrow(pk)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
summary(pk$LibPath)
summary(pk$Priority)
summary(pk$Version)
##   * what proportion need compilation?
##   * how break down re: version of R they were built on

## for tidyverts, here are some useful patterns
# data %>% count(var)
pk %>% count(LibPath)
pk %>% count(LibPath, Priority)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

##   * what proportion need compilation? # have C++?
pk %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
##   * how break down re: version of R they were built on
# how recently were the updated?
pk %>%
  count(Built) %>%
  mutate(prop = n / sum(n))

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- pk %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)

##   * how does the result of .libPaths() relate to the result of .Library?

ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

devtools::session_info()




