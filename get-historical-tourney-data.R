library(tidyverse)
library(lme4)

team_game <- read_csv("https://raw.githubusercontent.com/mmclaughlin87/march-madness-historical-perfomance/master/raw_data/team_game_level_data.csv")

team_game %>% count(year) %>% ggplot(aes(x = year, y = n)) + geom_col()

team_game2 <- 
  team_game %>% 
  filter(win == 1) %>% 
  dplyr::select(
    everything(), 
    -game_id, -date, -win, -seed_id, -overtime, 
    loser_seed = opponent_seed, 
    loser = opponent, 
    loser_score = opponent_score, 
    winner_team = team, 
    winner_score = score, 
    winner_seed = seed)
