# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")

# Reading CSV file and storing in dataframe
spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = F)

# Filtering dataframe for any Hunger Games Books by Suzanne Collins
hg_df <- spl_df %>% filter(str_detect(Creator, "Suzanne Collins")) %>% filter(str_detect(Title, "Hunger Games"))

# Filtering dataframe for any Divergent Books by Veronica Roth
divergent_df <- spl_df %>% filter(str_detect(Creator, "Veronica Roth")) %>% filter(str_detect(Title, "Divergent"))

# Getting total Checkouts and Binding to 2 rows for plot
total_checkouts <- bind_rows(hg_df %>% summarize(Checkouts = sum(Checkouts)), divergent_df %>% summarize(Checkouts = sum(Checkouts)))


# Plotting
ggplot(total_checkouts, aes(x = c("Hunger Games", "Divergent"), y = Checkouts)) +
  geom_col() +
  labs(title = "Hunger Games VS Divergent Checkouts ",
       x = "Author",
       y = "Total Checkouts")


