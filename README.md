# Analyzing Trends in Football Tournaments : A Focus on Geographical Distribution of International Football Matches, Match Outcomes, Scoring Patterns, and Regional Influences

## This project examines trends in football tournaments, focusing on the geographical distribution of matches, match outcomes, scoring patterns, and regional influences. 
It leverages datasets from Kaggle to analyze key variables and patterns across top international tournaments.

### Research Questions
1.	How does the geographical distribution of the international football matches vary across the countries?
2.	How does geographical location influence match outcomes in international football tournaments?
3.	Analysing the variation of home and away team scores across tournaments and in between neutral and non-neutral venues.
4.	Investigating tournament-specific trends on how average goals scored and frequency of draws changes.

### File Structure
D:\
└── Data_Science/
    └── Intnl_Football/
        ├── data/
        │   ├── Results.csv        # Dataset containing match results
        │   ├── Shootouts.csv      # Dataset with penalty shootout details
        │   ├── Goalscorers.csv    # Dataset containing goalscorers data
        ├── scripts/
        │   ├── Data_Explore.R   # Code for installing packages and exploring the data
        │   ├── Data_Clean.R   # Code for preprocessing datasets
        │   ├── Exploratory_Data_Analysis.R  # Exploratory data analysis and visualizations
        │   ├── Location_vs_MatchOutcomeTests.R   # Statistical analyses (Chi-Square, Correlation Tests)
        │   ├── home_away_scores_tournaments_venues.R   # Code for testing correlation of these variables
        │   ├── Time_Series_Analysis.R  # Time-series analysis of average goals score and frequency of draw
        ├── README.md          # Project overview and setup instructions
        ├── Intnl_Football.Rproj # R project file

### Analytical Techniques
#### Exploratory Data Analysis (EDA):
- Analyzed global match distribution using bar graphs and choropleth maps.
- Compared match outcomes by venue type (neutral vs. non-neutral).

#### Statistical Analysis:
- Chi-Square Test to investigate the relationship between venue type and match outcomes.
- Compared scoring trends across tournaments and regions.

#### Time-Series Analysis:
- Analyzed scoring patterns and draw rates over time for five major tournaments.

#### ANOVA Analysis:
- Conducted tests to assess variations in goals and draw rates across tournaments.

### Setup Instructions
1. Prerequisites
Ensure the following are installed:
- R: Version 4.0+
- RStudio
- Git (optional, for version control)
2. Install R and R Studio
  - Download https://posit.co/download/rstudio-desktop/ (Windows/macOS).
  - Use your package manager (Linux).
3. Clone the Repository
- Open the `Intnl_Football.Rproj` file in RStudio.
- To clone the repository from GitHub: git clone https://github.com/YourUsername/Data-Science-Project.git
4. Install Required R Packages
Run the following commands in R:
- install.packages(c("tidyverse", "naniar", "gt", "ggplot2", "dplyr", "ggmap"))
5. Open the Project
- Open the Intnl_Football.Rproj file in RStudio.
6. Run Analysis Scripts
- Data Exploration and reading datasets : scripts/Data_Explore.R.R
- Data Cleaning: scripts/Data_Clean.R
- EDA: scripts/Exploratory_Data_Analysis.R
- Statistical analyses (Chi-Square, Correlation Tests): scripts/Location_vs_MatchOutcomeTests.R
- Scoring Patterns Analysis : scripts/home_away_scores_tournaments_venues.R
- Time-Series Analysis: scripts/Time_Series_Analysis.R

### Key Insights
- RQ1: The results of match counts and its visualization via bar plots and choropleth maps indicated significant differences at the regional level in hosting frequencies.
- RQ2: Chi-square tests and correlation analyses indicated a strong association between match location and outcomes, validating the impact of geographical factors such as home advantage.
- RQ3: Correlation analysis per tournament and per type of venue showed a very slight home edge on non-neutral venues, underlining the impact of familiarity and crowd.
- RQ4: Time-series analysis and ANOVA revealed that scoring trends were decreasing over time, while draw rates did not vary significantly.

### Future Work
1. Incorporate additional variables like weather, stadium capacity, and travel distances.
2. Explore emerging football nations' roles in global trends.
