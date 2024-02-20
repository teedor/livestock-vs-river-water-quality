input_file_path <- "../../working-csv-data/13-distinct_basin_area.csv"
output_file_path <- "../../working-csv-data/14-primary_basin_total_area.csv"

library(dplyr)
library(readr)

# Read the CSV file
distinct_data <- read_csv(input_file_path)

# Calculate the sum of area_sqkm for each Primary_Basin
basin_total_area <- distinct_data %>%
  group_by(Primary_Basin) %>%
  summarise(Basin_sqkm = sum(area_sqkm, na.rm = TRUE)) 

# Write the new data to a CSV file
write_csv(basin_total_area, output_file_path)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_file_path, "' has been created."))
