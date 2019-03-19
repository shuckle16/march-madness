#tl;dr: you aren't gonna need it

team_game %>% count(year) %>% ggplot(aes(x = year, y = n)) + geom_col()


dat <- 
  data.frame(
    sum_score_diff = moddf %>% ungroup() %>% pull(sum_score_diff),
    ngames = moddf %>% ungroup() %>% pull(ngames),
    year = moddf %>% ungroup() %>% pull(year),
    made_it = moddf %>% ungroup() %>% pull(made_it),
    rn = moddf %>% ungroup() %>% mutate(rn = paste(school, year)) %>% pull(rn),
    moddf %>% ungroup() %>% dplyr::select_if(is.numeric) %>% dplyr::select(-sum_score_diff,-year,-ngames,-made_it) %>% mutate_if(is.numeric,scale)
  ) %>% 
  dplyr::filter(made_it == 1 | year == 2019) %>%
  column_to_rownames(var = "rn") %>% 
  dplyr::select(-made_it)


princomp(dat[dat$year > 2015, -c(1,2,3)]) %>% 
  autoplot(label = T, data = dat %>% filter(year > 2015), shape = F, loadings = T, loadings.label = T)

pcompdf <- 
  stats_df2 %>% 
  na.omit() %>% 
  filter(year > 2015) %>% 
  remove_rownames() %>% 
  mutate(
    school = paste(school, year) 
  ) %>% 
  column_to_rownames(var = "school") %>% 
  dplyr::select(
    Overall_W, Overall_SRS, made_it
  ) 

autoplot(princomp(pcompdf %>% dplyr::select(-made_it)), data = pcompdf, label = T, loadings = T, loadings.label = T, colour = 'made_it')
