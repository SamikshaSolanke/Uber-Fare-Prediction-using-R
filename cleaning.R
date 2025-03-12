install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(lubridate)
library(arrow)

uber_data <- merged_data

uber_data <- uber_data %>%
  filter(tpep_pickup_datetime >= as.POSIXct("2024-01-01") & 
           tpep_dropoff_datetime <= as.POSIXct("2024-12-31"))

uber_data_cleaned <- uber_data %>%
  filter(!is.na(fare_amount) & !is.na(trip_distance) & !is.na(passenger_count))

uber_data_cleaned$passenger_count[is.na(uber_data_cleaned$passenger_count)] <- 
  median(uber_data_cleaned$passenger_count, na.rm = TRUE)

uber_data_cleaned <- uber_data_cleaned %>%
  filter(trip_distance >= 0 & trip_distance <= 100)

uber_data_cleaned <- uber_data_cleaned %>%
  filter(fare_amount >= 0 & total_amount >= 0)

valid_payment_types <- c(1, 2, 3, 4, 5)
uber_data_cleaned <- uber_data_cleaned %>%
  filter(payment_type %in% valid_payment_types)

uber_data_cleaned <- uber_data_cleaned %>%
  filter(RatecodeID != 99)

uber_data_cleaned$RatecodeID[is.na(uber_data_cleaned$RatecodeID)] <- 1 
uber_data_cleaned$Airport_fee[is.na(uber_data_cleaned$Airport_fee)] <- 0

uber_data_cleaned <- uber_data_cleaned %>%
  drop_na(c(payment_type, fare_amount, trip_distance, passenger_count))

uber_data_cleaned <- uber_data_cleaned %>%
  mutate(row_number = row_number())

write_parquet(uber_data_cleaned, "cleaned_uber_data.parquet")

#EDA
df <- uber_data_cleaned
str(df)
summary(df)

colSums(is.na(df))

ggplot(uber_data_cleaned, aes(y = fare_amount)) +
  geom_boxplot(fill = "red", alpha = 0.6) +
  labs(title = "Fare Amount Boxplot", y = "Fare ($)")

hist(df$trip_distance, main = "Trip Distance Distribution After Cleaning", col = "green", breaks = 50)

fare_cutoff <- quantile(uber_data_cleaned$fare_amount, 0.99, na.rm = TRUE)
uber_data_cleaned <- uber_data_cleaned %>% filter(fare_amount <= fare_cutoff)

uber_data_cleaned <- uber_data_cleaned %>% filter(passenger_count > 0)

summary(uber_data_cleaned)

uber_data_cleaned <- uber_data_cleaned %>%
  select(-c(pickup_day, pickup_month, pickup_hour,trip_duration,pickup_date,pickup_time,dropoff_date,dropoff_time))

str(uber_data_cleaned)
glimpse(uber_data_cleaned)
