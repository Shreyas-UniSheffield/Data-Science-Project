#Geographical Distribution (Number of Matches per Country)
location_count <- ready_to_analyse_data %>%
  count(country) %>%
  arrange(desc(n))

#coord_flip() to flip x and y coordinates, reorder x axis in descending order of country's count
ggplot(location_count, aes(x = reorder(country,n) , y = n )) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() + 
  labs(title = "Football Matches distribution according to Geography", x = "Country", y = "No.of matches")+
  theme_minimal()

#To make it more readable, we access top 10 countries from the overall count
top_countries <- location_count %>%
  arrange(desc(n)) %>%
  slice_head(n = 10)  # Select top 10 countries

ggplot(top_countries, aes(x = reorder(country, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Countries by Football Matches", x = "Country", y = "No. of Matches") +
  theme_minimal()

#Geographical Distribution on Map
world_map <- map_data("world")
location_count_map <- left_join(world_map, location_count, by = c("region" = "country"))
ggplot(location_count_map, aes(x = long, y = lat, group = group, fill = n)) +
  geom_polygon(color = "black") +
  scale_fill_viridis_c() +
  labs(title = "Geographical Distribution of Football Matches", fill = "Number of Matches") +
  theme_void()

#Add the match_outcome column

ready_to_analyse_data <- ready_to_analyse_data %>%
  mutate(
    match_outcome = case_when(
      winner == home_team ~ "Home",      # Home team wins
      winner == away_team ~ "Away",      # Away team wins
      winner == "Draw" | is.na(winner) ~ "Draw"  # No winner or Draw
    )
  )

#Summarizing country-wise match outcomes
outcome_by_country <- ready_to_analyse_data %>%
  group_by(country, match_outcome) %>%
  count() %>%
  pivot_wider(names_from = match_outcome, values_from = n, values_fill = list(n = 0))

#Total matches for each country
outcome_by_country <- outcome_by_country %>%
  mutate(total_matches = `Home` + `Away` + `Draw`)
