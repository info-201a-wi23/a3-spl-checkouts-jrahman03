# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")

# Reading CSV file and storing in dataframe
spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = F)


# Creating New date column
spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d" )

# Filtering dataframe for Physical Books
physical_df <- spl_df %>% filter(str_detect(UsageClass, "Physical"))

# Filtering dataframe for Digital Books
digital_df <- spl_df %>% filter(str_detect(UsageClass, "Digital"))


# Calculating Physical Book Checkouts per Month 
physical_checkouts_per_month <- physical_df %>% group_by(date) %>% summarize(physical_total_checkouts_per_month = sum(Checkouts))

# Calculating Digital Book Checkouts per Month 
digital_checkouts_per_month <- digital_df %>% group_by(date) %>% summarize(digital_total_checkouts_per_month = sum(Checkouts))

# Merging dataframes for plotting
checkouts_per_month <- merge(physical_checkouts_per_month, digital_checkouts_per_month, by = "date", all = TRUE)

# Plotting data
ggplot(checkouts_per_month, aes(x = date)) +
  geom_line(aes(y = physical_total_checkouts_per_month, color = "Physical")) +
  geom_line(aes(y = digital_total_checkouts_per_month, color = "Digital")) +
  labs(title = "Digital Vs Physcial Checkouts Per Month", x = "Date", y = "Number of Checkouts") +
  scale_color_manual(values = c("orange", "violet"))

