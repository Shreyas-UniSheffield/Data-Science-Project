library(ggplot2)
library(dplyr)
library(ggalluvial)
library(tidyr)
library(tidyverse)

#Impact of Penalties and Own Goals on Match Outcomes in top 5 continental football tournaments
major_tournaments <- ready_to_analyse_data %>%
  filter(tournament %in% c("Copa América", "AFC Asian Cup", "African Cup of Nations", "UEFA Euro", "Gold Cup"))

alluvial_plot <- major_tournaments %>%
  group_by(tournament, penalty, own_goal, match_outcome) %>%
  summarise(count = n(), .groups= "drop")

alluvial_plot <- alluvial_plot %>%
  mutate(
    penalty = ifelse(penalty, "Penalty: Yes", "Penalty: No"),
    own_goal = ifelse(own_goal, "Own Goal: Yes", "Own Goal: No")
  )

sankey_plot <- ggplot(alluvial_plot,
                      aes(axis1 = penalty, axis2 = own_goal, axis3 = match_outcome, y = count)) +
  geom_alluvium(aes(fill = match_outcome)) +
  geom_stratum() +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 3) +
  scale_x_discrete(labels = c("Penalty", "Own Goal", "Match Outcome")) +
  facet_wrap(~tournament) +
  labs(
    title = "Alluvial Plot : Influence of Penalties and Own Goals on Match Outcomes Across Tournaments",
    x = "",
    y = "Match Count",
    fill = "Match Outcome"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 10, face = "bold"))


print(sankey_plot)

# Exploring Match Outcomes Over Time in top5 continental football tournaments

major_tournaments$year <- year(major_tournaments$date)

time_data_year <- major_tournaments %>%
  group_by(tournament, year, match_outcome) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(tournament, year) %>%
  mutate(proportion = count / sum(count))

line_chart <- ggplot(time_data_year, aes(x = year, y = proportion, color = match_outcome, group = match_outcome)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  facet_wrap(~ tournament, scales = "free_x") +  # Separate plot for each tournament
  labs(
    title = "Line Chart : Match Outcome Proportions Over Time (By Year) in Major Tournaments",
    x = "Year",
    y = "Proportion",
    color = "Match Outcome"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.text = element_text(size = 12, face = "bold")
  )

print(line_chart)

#Distribution of matches across top 5 continental football tournaments
library(treemapify)

treemap_data <- major_tournaments %>%
  group_by(tournament) %>%
  summarise(total_matches = n())

treemap <- ggplot(treemap_data, aes(area = total_matches, label = tournament, fill = total_matches)) +
  geom_treemap() +
  geom_treemap_text(fontface = "italic", place = "centre", color = "white")+
  scale_fill_gradient(low = "lightblue", high = "darkblue")+
  labs(
    title = "Treemap : Proportion of Matches by Tournament",
    fill = "Total Matches"
  ) +
  theme_minimal()

print(treemap)

#Analyze the win rates of top 5 teams across top 5 continental football tournaments

top5_major_tournaments <- ready_to_analyse_data %>%
  filter(
    tournament %in% c("Copa América", "AFC Asian Cup", "African Cup of Nations", "UEFA Euro", "Gold Cup"),
    winner != "Draw" # Exclude Draw
  )

top_teams_per_tournament <- top5_major_tournaments %>%
  group_by(tournament, winner) %>%
  summarise(total_wins = n(), .groups = "drop") %>%
  arrange(tournament, desc(total_wins)) %>%
  group_by(tournament) %>%
  slice_max(total_wins, n = 5)


win_rate_data <- top5_major_tournaments %>%
  semi_join(top_teams_per_tournament, by = c("tournament", "winner")) %>%
  group_by(tournament, winner) %>%
  summarise(wins = n(), .groups = "drop") %>%
  group_by(tournament) %>%
  mutate(total_matches = sum(wins)) %>%
  mutate(win_rate = wins / total_matches)

heat_map<- ggplot(win_rate_data, aes(x = tournament, y = winner, fill = win_rate)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(
    title = "Heatmap : Win Rates of Top 5 Teams in Major Tournaments",
    x = "Tournament",
    y = "Team",
    fill = "Win Rate"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(heat_map)


#Creating a Composite Visualization:
library(patchwork)
composite_visualization <- (treemap+line_chart) /(sankey_plot+heat_map)+
  plot_annotation(
    title = "Analysis of key trends in top 5 continental football tournaments", 
    subtitle = "A deep dive into distribution of matches, match outcomes, influence of penalty & own_goals and win rates of top 5 teams",
    theme = theme(
      plot.title = element_text(size = 18, face = "bold", hjust = 0.5),       # Bold title with increased font size
      plot.subtitle = element_text(size = 16, face = "bold", hjust = 0.5)    # Bold subtitle with slightly smaller font
    )
  )

#Saving the composite visualisation
ggsave("new_composite_visualizations.pdf", plot = composite_visualization ,width = 32, height = 20, dpi = 300)
