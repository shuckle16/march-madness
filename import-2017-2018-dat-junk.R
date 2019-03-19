tourney_dat2017 <- read_csv("2017-tourney-data.csv") %>% rename_all(tolower)
tourney_dat2018 <- read_csv("2018-tourney-data.csv") %>% rename_all(tolower)


tourney_dat2017_2018 <- 
  tourney_dat2017 %>% 
  bind_rows(tourney_dat2018) %>% 
  rename(
    winner_team = winner
  )

tourney_dat2017_2018 <- 
  tourney_dat2017_2018 %>% 
  mutate(
    loser_score = str_replace(loser_score, pattern = "\"", replacement = "")
  ) %>% 
  mutate(
    loser_score = str_replace(loser_score, pattern = " 1 OT", "")
  ) %>% 
  mutate(
    winner_score = as.numeric(winner_score),
    loser_score = as.numeric(loser_score)
  ) %>% 
  mutate(
    score_diff = winner_score - loser_score
  )
