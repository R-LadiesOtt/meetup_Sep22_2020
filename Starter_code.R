#### R-Ladies Ottawa
### September 22, 2020

require(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(lubridate)

## Section 1 (code provided by https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-09-22) 

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-22')
#tuesdata <- tidytuesdayR::tt_load(2020, week = 39)

# # Or read in the data manually
# 
# members <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/members.csv')
# expeditions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/expeditions.csv')
# peaks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/peaks.csv')

## Section 2 - Analysis

# Sort data into separate data frames
members <- tuesdata$members
peaks <- tuesdata$peaks
expeditions <- tuesdata$expeditions

#examine structure of the datasets
str(members)
str(peaks)
str(expeditions)

# show summary statistics
skimr::skim(peaks)

# tally termination reasons
expeditions %>% 
  group_by(termination_reason) %>% 
  tally()

# Ratio of success to fail
exp_clean <- expeditions %>% 
  mutate(climb_status = if_else(grepl("Success", termination_reason), "Success", "Fail")) %>% 
  group_by(climb_status) %>% 
  tally() %>% 
  mutate(ratio = n/sum(n)*100) %>% 
  select(- n)

# Fail/success by season
expeditions %>% 
  mutate(climb_status = if_else(grepl("Success", termination_reason), "Success", "Fail")) %>% 
  group_by(season, climb_status) %>% 
  tally()  %>% 
  mutate(season = factor(season, levels = c("Autumn",  "Spring", "Winter",  "Summer",  "Unknown"))) %>% 
  ggplot(aes(season, n, fill = climb_status)) +
  geom_col(position = position_dodge())  +
  theme_classic()+
  ylab("number of attempts")

# Fail/success by year
expeditions %>% 
  mutate(climb_status = if_else(grepl("Success", termination_reason), "Success", "Fail")) %>% 
  group_by(year, climb_status) %>% 
  tally()  %>% 
  ggplot(aes(year, n, colour = climb_status)) +
  geom_line()  +
  theme_classic()+
  ylab("number of attempts")

# Distribution of average age of the expedition by fail/success
members %>% 
  group_by(expedition_id) %>% 
  summarize(average_age = mean(age, na.rm = TRUE)) %>% 
  ungroup() %>% 
  left_join(expeditions, by = "expedition_id") %>% 
  mutate(climb_status = if_else(grepl("Success", termination_reason), "Success", "Fail")) %>% 
  ggplot()+
  geom_density(aes(average_age, colour = climb_status))+ 
  theme_classic()+
  ylab("density")

# Success/fail by sex  
members %>% 
  group_by(expedition_id, sex) %>% 
  tally() %>% 
  ungroup() %>% 
  left_join(expeditions, by = "expedition_id") %>% 
  mutate(climb_status = if_else(grepl("Success", termination_reason), "Success", "Fail")) %>% 
  ggplot(aes(sex, n, fill = climb_status))+
  geom_col(position = position_dodge())+ 
  theme_classic()+
  ylab("Number of attempts")
