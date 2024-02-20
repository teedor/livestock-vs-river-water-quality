# Set file paths
total_area_file_path <- "../../working-csv-data/14-primary_basin_total_area.csv"
livestock_data_file_path <- "../../working-csv-data/12-river-water-samples-with-livestock-data_final.csv"
output_file_path <- "../../working-csv-data/15-livestock-data-with-basin-area.csv"

# Load necessary libraries
library(dplyr)
library(readr)

# Read in the total basin area data
basin_total_area <- read_csv(total_area_file_path)

# Read in the livestock data
livestock_data <- read_csv(livestock_data_file_path)

# Join the basin total area data to the livestock data
combined_data <- livestock_data %>%
  left_join(basin_total_area, by = "Primary_Basin")

# Check the resulting data frame
print(head(combined_data))

# Write the combined data to a new CSV file
write_csv(combined_data, output_file_path)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_file_path, "' has been created."))
