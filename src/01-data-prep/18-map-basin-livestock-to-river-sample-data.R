# Set file paths
river_data_filepath <- "../../working-csv-data/15-livestock-data-with-basin-area.csv"
livestock_data_filepath <- "../../working-csv-data/17-primary_basin_year_livestock.csv"
output_filepath <- "../../working-csv-data/18-river-livestock-with-basin-counts.csv"

# Load necessary libraries
library(dplyr)
library(readr)

# Read the river data
river_data <- read_csv(river_data_filepath)

# Read the livestock data
livestock_data <- read_csv(livestock_data_filepath)

# Join the livestock data to the river data using Primary_Basin and Year
combined_data <- river_data %>%
  left_join(livestock_data, by = c("Primary_Basin", "Year")) %>%
  # Rename the columns as specified
  rename(
    Basin_Cattle = Total_Cattle,
    Basin_Sheep = Total_Sheep,
    Basin_Pigs = Total_Pigs,
    Basin_Poultry = Total_Poultry
  )

# Write the combined data with new column names to a new CSV file
write_csv(combined_data, output_filepath)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_filepath, "' has been created."))
