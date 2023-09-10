
# libraries ----

if (!require("pacman")) install.packages("pacman")

pacman::p_load('tidytuesdayR','tidyverse')

# data ----

tuesdata <- tidytuesdayR::tt_load(2023, week = 37) #, auth = github_pat("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"))


# demographics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/demographics.csv')
# wages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/wages.csv')
# states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/states.csv')
# 
# # tuesdata <- tidytuesdayR::tt_load('2023-09-05')
# ## OR
# tuesdata <- tidytuesdayR::tt_load(2023, week = 37) #, auth = github_pat("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"))
# 
# demographics <- tuesdata$demographics
# wages <- tuesdata$wages
# states <- tuesdata$states