input_file_path <- "../../working-csv-data/12-river-water-samples-with-livestock-data_final.csv"
output_file_path <- "../../working-csv-data/13-distinct_basin_area.csv"

library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv(input_file_path)

# Create a distinct list of Primary_Basin, and area_sqkm
distinct_data <- data %>%
  select(Primary_Basin, area_sqkm) %>%
  distinct()

# Write the new data to a CSV file
write_csv(distinct_data, output_file_path)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_file_path, "' has been created in the current working directory."))
