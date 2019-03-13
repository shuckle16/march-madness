years <- 2015:2018
names(years) <- years

get_season_stats <- function(year) {

  url <- paste("https://www.masseyratings.com/scores.php?s=cb", year, "&sub=ncaa-d1&all=1&sch=1", sep = "")
  
  tg <- 
    read_html(url) %>% 
    html_nodes("pre") %>% 
    html_text() %>% 
    strsplit("\n") %>% 
    unlist()

  tibble(
    year = year,
    date       = word(tg,1,11, sep = ""),
    home_team  = word(tg,12,36, sep = ""),
    home_score = word(tg,37,40,sep = "") %>% as.numeric(),
    away_team  = word(tg,41,66,sep = ""),
    away_score = word(tg,67,70, sep = "") %>% as.numeric(),
    other_info = word(tg,71,-1,sep = "")
  ) %>% 
    mutate(
      date = as.Date(date)
    )
}

season_stats <- purrr::map_df(years, get_season_stats)
