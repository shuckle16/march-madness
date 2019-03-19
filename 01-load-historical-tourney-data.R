library(tidyverse)
library(lme4)
library(rvest)

tourney_data_1995_2016 <- read_csv("data/1985-2016-tourney-data.csv")
tourney_data_2017_2018 <- read_csv("data/2017-2018-tourney-data.csv")

tourney_data <-
  bind_rows(
    tourney_data_1995_2016,
    tourney_data_2017_2018
    )