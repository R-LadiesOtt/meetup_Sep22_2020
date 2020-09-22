#### R-Ladies Ottawa
### September 22, 2020

require(tidytuesdayR)

.libpaths()## Section 1 code provided by https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-09-22 

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

# Sort data into separate data frames
members <- tuesdata$members
peaks <- tuesdata$peaks
expeditions <- tuesdata$expeditions
