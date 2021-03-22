
years <- 1995:2021
names(years) <- years

fetch_season_stats <- function(year) {
  
  url <- paste("https://www.sports-reference.com/cbb/seasons/", year, "-school-stats.html", sep = "")
  ncaa <- read_html(url)
  
  ncaa_tbl <- ncaa %>% html_table(fill = T) %>% `[[`(1)
  
  names(ncaa_tbl) <- paste(names(ncaa_tbl), ncaa_tbl[1,], sep = "_")
  
  ncaa_tbl <- ncaa_tbl[-1,]
  
  ncaa_tbl %>%
    as_tibble(.name_repair = "unique") %>%
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
    mutate_at(vars(-school), as.numeric)
}

stats_df <- purrr::map_df(years, fetch_season_stats, .id = "year")
