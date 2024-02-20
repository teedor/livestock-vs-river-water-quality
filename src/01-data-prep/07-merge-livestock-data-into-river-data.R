river_data_path <- "../../working-csv-data/05-river-data-merged-copper-columns.csv"
livestock_data_path <- "../../working-csv-data/01-livestock-data.csv"

library(dplyr)
library(readr)

river_data <- read_csv(river_data_path)
livestock_data <- read_csv(livestock_data_path)
output_file <- "../../working-csv-data/07-river-data-with-livestock.csv"

# Filter out rows where Cattle, Sheep, Pigs, and Poultry are all 3 or all 0
livestock_data <- livestock_data %>%
  filter(!(Cattle == 3 & Sheep == 3 & Pigs == 3 & Poultry == 3 |
           Cattle == 0 & Sheep == 0 & Pigs == 0 & Poultry == 0))

# Convert ISO_DATE to Year in river_data
river_data <- river_data %>%
  mutate(Year = as.integer(format(as.Date(ISO_DATE), "%Y")))

# Ensure the Ward column names match for a case-insensitive join
# Adjusting the case to match between the two data sets
river_data <- river_data %>%
  rename(ward = Ward)

# Ignore the ward_code column from the livestock data in the join
livestock_data <- select(livestock_data, -ward_code)

# Join the data sets based on ward and Year
merged_data <- left_join(river_data, livestock_data, by = c("ward", "Year"))

# Write the merged data to a new CSV file
write_csv(merged_data, output_file)

# Print a message to indicate completion
print("Merged data has been written to river-data-with-livestock.csv")
