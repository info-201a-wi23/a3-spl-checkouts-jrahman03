library("dplyr")

spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = F)

# Formatting Dates
spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d" )


total_checkouts <- spl_df %>% summarize(total_checkouts = sum(Checkouts))

min_checkout_month <- spl_df %>% group_by(date) %>% summarise(total_checkouts = sum(Checkouts)) %>% filter(total_checkouts == min(total_checkouts))
  
max_checkout_month <- spl_df %>% group_by(date) %>% summarise(total_checkouts = sum(Checkouts)) %>% filter(total_checkouts == max(total_checkouts))

 
most_popular_item <- spl_df %>% group_by(Title) %>% summarise(total_checkouts = sum(Checkouts)) %>% filter(total_checkouts == max(total_checkouts))

least_popular_item <- spl_df %>% group_by(Title) %>% summarise(total_checkouts = sum(Checkouts)) %>% filter(total_checkouts == min(total_checkouts))

