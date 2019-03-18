kp <- 
  read_html("https://kenpom.com/") %>% 
  html_table() %>% 
  `[[`(1)

names(kp) <- paste(names(kp),
                   kp[1,], 
                   sep = "")

names(kp) <- make.unique(names(kp))

kp <- kp[-1,]

kp <- 
  kp %>% 
  filter(!(Rk == "Rk"),
         !(Rk == ""))

kp <- 
  kp %>% 
  mutate(
    seed = str_match_all(string = Team, pattern = "\\d+$") %>% as.numeric(), 
    Team = str_replace_all(string = Team, pattern = "\\d+$","") %>% str_trim()
    ) %>% 
  mutate(
    Team = str_replace(string = Team, pattern = "St.$", "State"),
    Team = str_replace(string = Team, pattern = "VCU$","Virginia Commonwealth"),
    Team = str_replace(string = Team, pattern = "LSU$", "Louisiana State"),
    Team = str_replace(string = Team, pattern = "UCF$", "Central Florida"),
    Team = str_replace(string = Team, pattern = "UC Irvine", "UC-Irvine"),
    Team = str_replace(string = Team, pattern = "Saint Mary's", "Saint Mary's (CA)"),
    Team = str_replace(string = Team, pattern = "St. John's", "St. John's (NY)"),
    Team = str_replace(string = Team, pattern = "Gardner Webb", "Gardner-Webb"),
    Team = str_replace(string = Team, pattern = "Prairie View A&M", "Prairie View")
  )

kp %>% 
  inner_join(
    moddf_test %>% mutate(pred = predict(rfmod, data = moddf_test %>% ungroup())$predictions), 
    by = c("Team" = "school")) %>% 
  ggplot(aes(x = as.numeric(Rk), y = pred)) + 
  geom_text(aes(label = Team)) + scale_y_log10() + 
  scale_x_log10()
