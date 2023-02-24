# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")

# Reading CSV file and storing in dataframe
spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = F)

# Creating New date column
spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d" )

# Filtering dataframe for Orwell works
author_df <- spl_df %>% filter(str_detect(Creator, "Orwell"))

# Calculating Checkouts by date
checkouts_per_month <- author_df %>% group_by(date) %>% summarize(total_checkouts_per_month = sum(Checkouts))

# Graph Creation
ggplot(checkouts_per_month) +
  geom_line(aes(x = date, y = total_checkouts_per_month, color = "Total Checkouts")) +
  scale_color_brewer(palette = "Set2") +
  labs(title = "SPL Checkouts for George Orwell Works", x = "Date/Month", y = "Total Checkouts", color = "Total Checkouts") +
  guides(color = guide_legend(override.aes = list(size=7))) 
