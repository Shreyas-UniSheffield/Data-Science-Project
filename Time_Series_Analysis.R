#Investigate tournament-specific trends focusing on changes in the average number of goals scored or the frequency of draws
#Chosen 5 major continent based tournaments and mutated a year column
tournaments_picked <- ready_to_analyse_data %>%
  filter(tournament %in% c("Copa América", "AFC Asian Cup", "African Cup of Nations", "UEFA Euro", "Gold Cup")) %>%
  mutate(year = as.numeric(format(as.Date(date), "%Y")))

#Comparing tournament wise and year how scores&draw varies
tournament_trend <- tournaments_picked %>%
  group_by(tournament, year) %>%
  summarise(
    avg_score = mean(home_score + away_score, na.rm = TRUE),
    draw_rate = mean(winner == "Draw", na.rm = TRUE)
  )

ggplot(tournament_trend, aes(x = year, y = avg_score, color = tournament)) +
  geom_line(linewidth = 1) +
  labs(title = "Average Goals Scored per Match by Tournament",
       x = "Year", y = "Average Goals",
       color = "Tournament"
  ) +
  theme_minimal()

ggplot(tournament_trend, aes(x = year, y = draw_rate, color = tournament)) +
  geom_line(linewidth = 1) +
  labs(title = "Frequency of Draws over the years", x = "Years", y = "Draw_Rate", color = "Tournament") +
  theme_minimal()

#Hypothesis Testing (ANOVA)
#Ho : The Average goals scored across all the tournaments are the same
#Ha :  The Average goals scored across all the tournaments differ
anova_of_goals <- aov(avg_score ~ tournament, data = tournament_trend)
summary(anova_of_goals)

#Since 0.025 < 0.05,we reject null hypothesis and perform Post-Hoc Analysis
tukey_avg_goals <- TukeyHSD(anova_of_goals)
print(tukey_avg_goals)

#Difference: 0.605, P-value: 0.044, CI: [0.010,1.199], Copa América has significantly higher average goals per match compared to the African Cup of Nations.
#other pairwise comparisons (e.g., Gold Cup vs. AFC Asian Cup, UEFA Euro vs. Copa América) have p-values > 0.05, meaning no significant difference in average goals scored.


#Ho : The Draw_Rate across all the tournaments are the same
#Ha :  The Draw_Rate across all the tournaments differ
anova_draw_rate <- aov(draw_rate ~ tournament, data = tournament_trend)
summary(anova_draw_rate)

#p-value is greater than the significance level of 0.05.This means there is no statistically significant difference in the draw rates across tournaments.
#This means Post-Hoc test is not necessary