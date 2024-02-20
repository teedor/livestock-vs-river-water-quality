cleaned_river_data_path <- "../../working-csv-data/08-cleaned-river-data-with-livestock.csv"
filtered_wards_area_path <- "../../working-csv-data/09-filtered-wards-area.csv"
output_file_path <- "../../working-csv-data/10-river-data-with-livestock-and-area.csv"

library(dplyr)
library(readr)

# Read the CSV files
cleaned_river_data <- read_csv(cleaned_river_data_path)
filtered_wards_area <- read_csv(filtered_wards_area_path)

# Merge the area_sqkm values from filtered_wards_area into cleaned_river_data
# based on matching "WARD" in filtered_wards_area to "ward" in cleaned_river_data
merged_data <- left_join(cleaned_river_data, filtered_wards_area, by = c("ward" = "WARDS"))

# Write the merged data to a new CSV file
write_csv(merged_data, output_file_path)

# Print a message to indicate completion
print(paste("Merged data with area_sqkm has been written to", output_file_path))
