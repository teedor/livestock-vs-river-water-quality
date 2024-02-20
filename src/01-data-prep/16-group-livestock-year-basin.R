input_file_path <- "../../working-csv-data/15-livestock-data-with-basin-area.csv"
output_file_path <- "../../working-csv-data/16-distinct_basin_livestock_year.csv"

library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv(input_file_path)

# Create a distinct list of Primary_Basin, year, and animal counts
distinct_data <- data %>%
  select(Primary_Basin, Year, Cattle, Sheep, Pigs, Poultry) %>%
  distinct()

# Write the new data to a CSV file
write_csv(distinct_data, output_file_path)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_file_path, "' has been created in the current working directory."))
