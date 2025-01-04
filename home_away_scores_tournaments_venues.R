#Based on tournament type and neutral vs non-neutral matches
# Grouping by Tournament and calculating correlation for each group
correlation_by_tournament <- ready_to_analyse_data %>%
  group_by(tournament) %>%
  summarise(correlation = cor(home_score, away_score, use = "complete.obs"))

print(correlation_by_tournament)

# Grouping by Tournament and calculating correlation for each group, with a check for variance
correlation_by_tournament <- ready_to_analyse_data %>%
  group_by(tournament) %>%
  summarise(
    correlation = ifelse(
      sd(home_score, na.rm = TRUE) > 0 & sd(away_score, na.rm = TRUE) > 0, 
      cor(home_score, away_score, use = "complete.obs"),
      NA
    )
  )

print(correlation_by_tournament)
#This weak negative correlation could suggest that, on average, home teams may score slightly more than away teams


# Grouping by Neutral vs Non-Neutral Venue and calculating correlation for each group
correlation_by_venue <- ready_to_analyse_data %>%
  group_by(neutral) %>%
  summarise(correlation = cor(home_score, away_score, use = "complete.obs"))

print(correlation_by_venue)
#Both neutral and non-neutral venues show weak negative correlations, meaning the home and away scores tend to move in opposite directions, but the relationship is not strong.
#The slight difference in correlation values between neutral and non-neutral venues (where non-neutral venues have a slightly stronger negative correlation) suggests that the venue may have a small effect on the match outcome, but this effect is not substantial.

#Tournament-wise visualizations
# Bar plot for correlation by tournament
sample_correlation_tournament <- correlation_by_tournament %>%
  sample_n(10)
ggplot(sample_correlation_tournament, aes(x = tournament, y = correlation)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  coord_flip() +
  labs(title = "Correlation between Home and Away Scores by Tournament",
       x = "Tournament",
       y = "Correlation")

#Venue-Wise
# Bar plot for correlation by neutral vs non-neutral venue
ggplot(correlation_by_venue, aes(x = factor(neutral), y = correlation, fill = factor(neutral))) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Correlation between Home and Away Scores by Venue",
       x = "Neutral Venue (0 = No, 1 = Yes)",
       y = "Correlation")
