# Data Visualisation
# Analysis of Key Trends in Top 5 Continental Football Tournaments
## A deep dive into the distribution of matches, match outcomes, influence of penalties & own goals, and win rates of top teams.
## Project Overview
This project analyzes key trends in five major continental football tournaments:
- UEFA Euro
- Copa América
- Gold Cup
- AFC Asian Cup
- AFCON (African Cup of Nations)

Using advanced data visualization techniques in R, this analysis explores the geographical distribution of matches, evolving match outcomes, the role of penalties and own goals, and win rates of top-performing teams.
## File Structure
Data-Science-Project/
├── Data_Visualisation/
│   ├── Composite_Data_Visualisation.R          # R script for creating composite visualizations
│   ├── new_composite_visualizations.pdf        # Output of the R script in PDF format
│   ├── ReadMe.md                               # Documentation for the Data Visualization project
├── Results.csv                                 # Dataset containing match results
├── Shootouts.csv                               # Dataset with penalty shootout data
├── Goalscorers.csv                             # Dataset containing goalscorer details
├── LICENSE                                     # Project license (MIT License)
## ## Dependencies
This project relies on the following scripts from the `Data-Science-Project` folder:
- `Data_Explore.R`: Handles initial data exploration and summary.
- `Data_Clean.R`: Performs data cleaning and preprocessing.

Ensure these scripts are run before using the `Data_Visualisation` scripts.
- source("../Data-Science-Project/Data_Explore.R")  #Path for Data_Explore script
- source("../Data-Science-Project/Data_Clean.R") #Path for Data_Clean script
## Setup Instructions
1. Prerequisites
- R version 4.0 or higher
- RStudio (recommended)
- R packages: tidyverse, ggplot2, ggalluvial, tidyr, dplyr, treemapify, patchwork
2. Installation
- Clone the repository: git clone https://github.com/Shreyas-UniSheffield/Data-Science-Project.git
- Navigate to the Data_Visualisation folder: cd Data-Science-Project/Data_Visualisation
3. Running the R Script
- Open Composite_Data_Visualisation.R in RStudio.
- Install the required R packages if not already installed:
install.packages(c("tidyverse", "ggplot2", "ggalluvial", "tidyr", "dplyr", "treemapify", "patchwork"))
- Run the script to generate visualizations
- View the output in new_composite_visualizations.pdf
## Key Insights from Visualizations
### 1. Treemap
- Description: Visualizes the distribution of matches across tournaments.
- Key Insight: Highlights factors like infrastructure, grassroots participation, and regional prominence influencing tournament significance.
### 2. Line Chart
- Description: Tracks trends in match outcomes (wins, draws, and losses) over time.
- Key Insight: Reflects tactical evolution, competitive balance, and regional dynamics in match outcomes.
### 3. Alluvial Plot
- Description: Explores the impact of penalties and own goals on match dynamics.
- Key Insight: Reveals how emotional resilience and tactical discipline shape outcomes, especially in high-stakes games.
### 4. Heatmap
- Description: Compares win rates of the top five teams in each tournament.
- Key Insight: Highlights disparities in team performance due to external factors like resources, talent development, and tournament structures.
## License
This project is licensed under the MIT License.
