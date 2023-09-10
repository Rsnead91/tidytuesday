
# TidyTuesday
# 12/10/2019
# Replicating plots


#---- Read in packages ------

library(tidycensus)
library(ggmap)
library(ggplot2)
library(summarytools)

#---- Read in data

squirrels <- readr::read_csv("2018_Central_Park_Squirrel_Census_-_Squirrel_Data.csv") 


#---- Load Google API

require(devtools)
devtools::install_github("dkahle/ggmap")

google_api_key <- "XXXXXXXXXX"

register_google(key = google_api_key)


#---- Check out data

#View(squirrels)
#str(squirrels)

#---- Format data for visual

squirrels <- dplyr::rename(squirrels, fur = 'Primary Fur Color') %>% 
              tidyr::drop_na(fur)

#freq(squirrels1$fur)


#---- Map squirrels data

ggmap::ggmap(get_googlemap(center = c(lon = -73.965667, lat = 40.782445), zoom = 14, maptype = "roadmap")) +
  geom_point(squirrels, mapping = aes(x = X, y = Y, color = factor(fur))) +
  scale_color_manual(values=c("Black", "Brown", "Gray")) +
  theme_void() +
  labs(title="Where the squirrels were found in Central Park") +
  guides(color=FALSE)

ggsave("squirrels.png")

