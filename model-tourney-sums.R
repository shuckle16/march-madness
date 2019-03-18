tourney_score_diff_sums <- 
  team_game2 %>% 
  group_by(year, winner_team, winner_seed) %>% 
  summarize(
    sum_score_diff = sum(winner_score - loser_score),
    ngames = n()
    ) %>% 
  rename(school = winner_team) %>% 
  ungroup()

stats_df2 <- 
  stats_df %>% 
  mutate(year = as.numeric(year)) %>% 
  dplyr::select(-`_NA`) %>% 
  filter(!is.na(Overall_SRS)) %>% 
  dplyr::select_if(funs(!any(is.na(.))))

names(stats_df2) <- str_replace_all(names(stats_df2), "\\%", "pct")
names(stats_df2) <- str_replace_all(names(stats_df2), "\\s+","")
names(stats_df2) <- str_replace_all(names(stats_df2), "\\.", "")
names(stats_df2) <- str_replace_all(names(stats_df2), "^\\_","")
names(stats_df2) <- str_replace_all(names(stats_df2), "\\-","")

moddf <- 
  stats_df2 %>%
  left_join(tourney_score_diff_sums)

moddf <- 
  moddf %>% 
  dplyr::select(
    year, school, ngames, made_it, 
    Overall_SRS, Overall_SOS, 
    sum_score_diff, 
    contains("pct"))

moddf_train <- 
  moddf %>% 
  filter(year > 2010, year < 2019) %>% 
  filter(made_it == 1, !is.na(ngames)) %>% 
  replace_na(list(sum_score_diff = 0))

moddf_test <- 
  moddf %>% 
  filter(year == 2019, made_it == 1)

rfmod <- ranger::ranger(sum_score_diff ~ . -ngames -year, data = moddf_train, num.trees = 500, importance = "impurity")

data.frame(importance(rfmod)) %>% 
  rownames_to_column(var = "variable") %>% 
  ggplot(
    aes(
      x = reorder(variable, importance.rfmod.), 
      y = importance.rfmod.
      )
    ) + 
  geom_col() + 
  coord_flip()

data.frame(
  moddf_train,
  pred = predictions(rfmod)
) %>% head()

data.frame(
  moddf_test,
  pred = predict(rfmod, data = moddf_test %>% ungroup())$predictions
) %>% 
  arrange(desc(pred)) %>% 
  head(64) %>% 
  ggplot(aes(x = reorder(school, pred), y = pred)) + 
  geom_col() + 
  coord_flip() + 
  ggtitle("Random Forest Predictions",
          subtitle = "sum(winning margin) for whole tournament")

# %>% 
#   ggplot(aes(x = sum_score_diff, y = pred, label = paste(school, year, winner_seed))) + 
#   geom_text() + 
#   geom_abline(slope = 1, intercept = 0, linetype = "dashed") + 
#   xlab("Sum of Score Differences")
