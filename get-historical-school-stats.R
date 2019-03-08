library(tidyverse)
library(rvest)

years <- 1995:2019
names(years) <- years

get_season_stats <- function(year) {
  
  url <- paste("https://www.sports-reference.com/cbb/seasons/", year, "-school-stats.html", sep = "")
  ncaa <- read_html(url)
  
  ncaa_tbl <- ncaa %>% html_table(fill = T) %>% `[[`(1)
  
  names(ncaa_tbl) <- paste(names(ncaa_tbl), ncaa_tbl[1,], sep = "_")
  
  ncaa_tbl <- ncaa_tbl[-1,]
  
  ncaa_tbl %>%
    rename(
      school = `_School`
    ) %>% 
    filter(
      school != "School", school != ""
    ) %>% 
    mutate(
      made_it = grepl(pattern = "NCAA$",x = school)
    ) %>% 
    mutate(
      school = str_replace(school,"NCAA","") %>% str_trim()
    ) %>% 
    mutate_at(vars(-school),as.numeric)
}

stats_df <- purrr::map_df(years,get_season_stats,.id = "year")

stats_df %>% 
  GGally::ggpairs(columns = c("Overall_W", "Overall_SRS", "Points_Tm.", "Points_Opp."),aes(colour = factor(made_it)))