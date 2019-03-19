library(tidyverse)
library(lme4)

tourney_data_1995_2016 <- read_csv("1985-2016-tourney-data.csv")
tourney_data_2017_2018 <- read_csv("2017-2018-tourney-data.csv")

tourney_data <-
  bind_rows(
    tourney_data_1995_2016,
    tourney_data_2017_2018
    )