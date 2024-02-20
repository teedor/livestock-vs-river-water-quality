# Install packages if they're not already installed
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("lubridate", quietly = TRUE)) install.packages("lubridate")
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("modelr", quietly = TRUE)) install.packages("modelr")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")


library(dplyr)
library(lubridate)
library(readr)
library(modelr)
library(tidyr)

# Load the data
data_url <- "https://github.com/teedor/team-8-assignment/raw/main/working-csv-data/river-water-samples-with-livestock-data_final.csv"
df <- read_csv(data_url)

# Function to get season from date
get_season <- function(date) {
  month <- month(date)
  day <- day(date)
  if (month %in% 3:5) {
    return('Spring')
  } else if (month %in% 6:8) {
    return('Summer')
  } else if (month %in% 9:11) {
    return('Autumn')
  } else {
    return('Winter')
  }
}

# Add Season column
df$ISO_DATE <- as.Date(df$ISO_DATE)
df$Season <- sapply(df$ISO_DATE, get_season)

# One-hot encode the 'Season' column
df <- df %>%
  mutate(Season_Spring = as.numeric(Season == 'Spring'),
         Season_Summer = as.numeric(Season == 'Summer'),
         Season_Autumn = as.numeric(Season == 'Autumn'),
         Season_Winter = as.numeric(Season == 'Winter'))

# Order by ISO_DATE, then split the data
df <- df %>% arrange(ISO_DATE)
max_year <- max(year(df$ISO_DATE))
df_final_year <- df %>% filter(year(ISO_DATE) == max_year)
df_remaining <- df %>% filter(year(ISO_DATE) != max_year)

# Shuffle the remaining rows
set.seed(42) # For reproducibility
df_shuffled <- df_remaining[sample(1:nrow(df_remaining)), ]

# Remove NA or NaN values and save CSV files for specific columns
common_columns <- c('Cattle_per_sqkm', 'Sheep_per_sqkm', 'Pigs_per_sqkm', 'Poultry_per_sqkm',
                    'Season_Autumn', 'Season_Spring', 'Season_Summer', 'Season_Winter')

specific_columns <- c('ALK_MGL', 'BOD_MGL', 'COND_USCM', 'CUSOL1_MGL', 'DO_MGL', 'FESOL1_UGL',
                      'NO3_N_MGL', 'NO2_N_MGL', 'NH4_N_MGL', 'PH', 'P_SOL_MGL', 'SS_MGL',
                      'ZN_SOL_UGL')

for (col in specific_columns) {
  df_specific <- df_shuffled %>%
    select(c(col, common_columns)) %>%
    drop_na()
  write_csv(df_specific, paste0("../../datasets-for-ml/", col, "_data.csv"))
}

# Save the final year's data to a CSV file
write_csv(df_final_year, "../../datasets-for-ml/final_year_data.csv")
