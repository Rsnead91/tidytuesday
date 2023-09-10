# TidyTuesday
# 12/16/2019
# Adoptable Dogs


#---- load packages and fonts ------

library(tidycensus)
library(dplyr)
library(tidyr)
library(ggplot2)
library(summarytools)
library(geofacet)
library(stringr)
library(extrafont)

font_import(paths = "C:\Windows\Fonts", prompt = F) # loading fonts

#---- Read in data

dog_moves        <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_moves.csv')
dog_travel       <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_travel.csv')
dog_descriptions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_descriptions.csv')

#---- Data Manipulation

dog_descriptions_state <-
  dog_descriptions %>%
    left_join(us_state_grid2, by = c("contact_state" = "code")) %>% # Joining state grid with data set
    group_by(contact_state, breed_primary) %>% 
    add_tally() %>%                                                 # Counting number of primary breeds by state
    distinct(contact_state, breed_primary, row, col, n) %>%         # Removing duplicate rows
    group_by(contact_state) %>% 
    top_n(n = 1, wt = n) %>%                                        # Retaining the top primary breed in each state
    drop_na(col) %>%                                                # Removing territories and rows not attached to states
    distinct(contact_state, .keep_all = TRUE) %>%                  # For simplicity just removing ties randomly
    mutate(breed_primary = str_replace_all(breed_primary, c("Mixed Breed" = "Mixed\nBreed", "Pit Bull Terrier" = "Pit Bull\nTerrier", "Labrador Retriever" = "Labrador\nRetriever", "Border Collie" = "Border\nCollie")))

#---- Visualize

dog_descriptions_state %>% 
  ggplot(aes(x=col, y=row)) +
  geom_tile(aes(fill=n)) +
  scale_y_reverse(breaks=NULL) +
  scale_x_continuous(breaks=NULL) +
  geom_text(aes(label=contact_state), size=3, vjust=-1, fontface="bold", color="white") +
  geom_text(aes(label=breed_primary), size=1.8, vjust= 0.7, fontface="bold", color="white") +
  scale_fill_viridis_c(option = "magma", 
                       alpha = .9,
                       name = NULL,
                       end = .8,
                       breaks=c(10,750),
                       labels = c("Few Dogs", "Many Dogs")) +
  theme(text = element_text(family = "Liberation Mono"),
        axis.ticks = NULL,
        legend.position = "top",
        legend.justification = "left",
        legend.title = element_text(size=8, vjust = -.25, hjust = 5),
        legend.background = element_rect(color = 'white', fill = 'white'),
        plot.background = element_rect(color = 'white', fill = 'white'),
        panel.background = element_rect(color = 'white', fill = 'white'),
        plot.caption = element_text(color = "black", hjust=0),
        plot.title = element_text(color = "black", size = 10)) +
  labs(title="Primary Breeds of Most Available Adoptable Dogs by State",
       caption="Data Source: All Adoptable Dogs from Petfinder.com via The Pudding\n@ryansnead", 
       x="", y="", color="white") 

ggsave("C:\\Users\\Rsnea\\Documents\\R\\TidyTuesday\\20191216_AdoptableDogs\\20191216_AdoptableDogs.png")

