input_file_path <- "../../working-csv-data/06-wards-area.csv"
output_file_path <- "../../working-csv-data/09-filtered-wards-area.csv"

library(dplyr)
library(readr)

# Read the CSV file
wards_data <- read_csv(input_file_path)

# Filter for the highest area_sqkm value within each WARDS group
filtered_wards_data <- wards_data %>%
  group_by(WARDS) %>%
  slice(which.max(area_sqkm)) %>%
  ungroup()

# Write the filtered data to a new CSV file
write_csv(filtered_wards_data, output_file_path)

# Print a message to indicate completion
print(paste("Filtered data has been written to", output_file_path))
