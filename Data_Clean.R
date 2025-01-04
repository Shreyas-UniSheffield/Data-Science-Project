#Filling the missing values for winner variables using case_when()
merged_data <- merged_data %>% 
  mutate(winner = case_when(
    home_score > away_score ~ home_team,
    home_score < away_score ~ away_team,
    TRUE ~ "Draw"
  ))
View(merged_data)

#Filtered matches from the 1st FIFA WC post World War II
merged_data <- merged_data %>% filter(date >= "1950-06-24") 
View(merged_data)

#Handle scorer, own_goal, penalty, minute, team, first_shooter variables for matches without data for these variables
merged_data_clean <- merged_data %>%
  mutate(
    scorer = ifelse(
      is.na(scorer) & (date %in% no_scorer_data$date),
      NA,
      scorer
    ),
    own_goal = ifelse(
      is.na(own_goal) & (date %in% no_scorer_data$date | (home_score == 0 & away_score == 0)),
      FALSE,
      own_goal
    ),
    penalty = ifelse(
      is.na(penalty) & (date %in% no_scorer_data$date | (home_score == 0 & away_score == 0)),
      FALSE,
      penalty
    ),
    minute = ifelse(
      is.na(minute) & (date %in% no_scorer_data$date),
      NA,
      minute
    ),
    team = ifelse(
      is.na(team) & (date %in% no_scorer_data$date | (home_score == 0 & away_score == 0)),
      NA,
      team
    ),
   
    first_shooter = ifelse(
      is.na(first_shooter) & (date %in% no_shootout_data$date),
      NA,
      first_shooter
    )
  )
View(merged_data_clean)

miss_var_summary(merged_data_clean) %>% gt() %>% gt_theme_guardian() %>% tab_header(title = "Missing Cleaned Merged Data info")

#Removing first_shooter, minute, scorer, team variables as they don't play significant role in my analysis aligning to my research question
ready_to_analyse_data <- merged_data_clean %>%
  select(-minute, -first_shooter, -team, -scorer)

#To check for any missing values in tabular format
miss_var_summary(ready_to_analyse_data) %>% gt() %>% gt_theme_guardian() %>% tab_header(title = "Missing Ready to Analyse Data info")

#Viewing the variable that is to be used for further analysis
View(ready_to_analyse_data)
