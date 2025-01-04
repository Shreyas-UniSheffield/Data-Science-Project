#Analysing Trends in Football Tournaments: 
#A Focus on Geographical Distribution of international football matches, Match Outcomes, Scoring Patterns, and Regional Influences

install.packages(c("dplyr", "ggplot2", "lubridate", "tidyr", "ggmap", "sf", "tmap"))
library(dplyr) #data manipulation and transformation
library(ggplot2) #Grammar of Graphics for complex plots
library(lubridate) #Dealing with date and time
library(tidyr) #Data transformation for easier analysis
library(ggmap) #Accessing and using plots from Google Maps or related
library(sf) #Tools for dealing spatial data
library(tmap) #Creating maps with spatial data
install.packages("naniar")
library(naniar) #For creating and customizing tables
library(tidyverse) #For data transformation and presentation
install.packages("gtExtras")
library(gtExtras) #For creating customised tables

#Reading the csv files
result_info <- read.csv("results.csv")
shootout_info <- read.csv("shootouts.csv")
scorers_info <- read.csv("goalscorers.csv")

#Finding the rows and columns via dim() function
dim(result_info)
dim(shootout_info)
dim(scorers_info)

#Finding out datatypes of initial values of each variable
glimpse(result_info)
glimpse(shootout_info)
glimpse(scorers_info)

#Statistical summary of the data
summary(result_info)
summary(shootout_info)
summary(scorers_info)

#Checking any missing data
miss_var_summary(result_info) %>% gt() %>% gt_theme_guardian() %>% tab_header("Missing result info")
miss_var_summary(shootout_info) %>% gt() %>% gt_theme_guardian() %>% tab_header("Missing shootout info")
miss_var_summary(scorers_info) %>% gt() %>% gt_theme_guardian() %>% tab_header("Missing goalscorers info")

#Checking the missing observations in scorer and minute variable
View(scorers_info[is.na(scorers_info$scorer), ])
View(scorers_info[is.na(scorers_info$minute),])

#View tabular data
View(result_info)
View(shootout_info)
View(scorers_info)

#Merging the dataset
merged_data <- result_info %>% 
  left_join(shootout_info, by = c("date","home_team","away_team")) %>%
  left_join(scorers_info, by = c("date","home_team","away_team"))

View(merged_data)  

#Checking for any missing values
sum(is.na(merged_data))
miss_var_summary(merged_data) %>% gt() %>% gt_theme_guardian() %>% tab_header("Missing Merged info")
