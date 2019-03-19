final_df <- 
  kp %>% 
  inner_join(
    moddf_test %>% mutate(pred = predict(rfmod, data = moddf_test %>% ungroup())$predictions), 
    by = c("Team" = "school")
    ) %>% 
  mutate(
    my_rank = rank(1 / pred)
  ) %>% 
  mutate(
    combo_rank = (Rk + my_rank) / 2
  )

final_df %>%
  dplyr::select(
    Team, Conf, Rk, my_rank, combo_rank
  ) %>% 
  arrange(combo_rank)

data.frame(importance(rfmod)) %>% 
  rownames_to_column(var = "variable") %>% 
  ggplot(
    aes(
      x = reorder(variable, importance.rfmod.), 
      y = importance.rfmod.
    )
  ) + 
  geom_col() + 
  coord_flip() +
  ggtitle("Which Features Are Important?")

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

final_df %>% 
  ggplot(aes(x = as.numeric(Rk), y = pred)) + 
  geom_text(aes(label = Team)) + scale_y_log10() + 
  scale_x_log10() + 
  ggtitle("My Predictions vs Ken Pom",
          subtitle = "Mostly Correlated, some discrepancies")
