#Chi-Square Test (Location vs Match Outcome)
contigency_table <- table(ready_to_analyse_data$country, ready_to_analyse_data$winner)
print(contigency_table)

#Because certain countries have 0 values
contigency_table <- contigency_table[rowSums(contigency_table) > 0, ]

ready_to_analyse_data$country_grouped <- ifelse(
  ready_to_analyse_data$country %in% names(which(rowSums(contigency_table) < 5)),
  "Other",
  ready_to_analyse_data$country
)

# Recreate the contingency table
contigency_table_grouped <- table(ready_to_analyse_data$country_grouped, ready_to_analyse_data$winner)

#The Monte Carlo simulation (simulate.p.value = TRUE) is used when the assumptions of the chi-squared test 
#(e.g., expected frequencies >= 5) are violated. It provides a more accurate p-value by simulating the sampling distribution.
chi_square_outcome_grouped <- chisq.test(contigency_table_grouped, simulate.p.value = TRUE, B = 10000)
print(chi_square_outcome_grouped)

#X-squared = 3388855 : Its magnitude suggests a very large difference between observed and expected frequencies, indicating strong evidence of an association between the variables.
#Degrees of freedom (df) are not reported because the test used simulated p-values, which bypasses the usual approximation that relies on degrees of freedom.
#p-value = 9.999e-05 (approximately 0.0001)Geographical location (as represented by country or group) has a strong association with match outcomes.

#Correlation Between Location and Match Outcome (if needed)
correlation_result <- cor(ready_to_analyse_data$home_score, ready_to_analyse_data$away_score, use = "complete.obs")
print(correlation_result)

#The -0.25929 very weak negative value suggests that as the home team's score increases, the away team's score tends to decrease, or vice versa