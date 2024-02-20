input_file_path <- "../../working-csv-data/16-distinct_basin_livestock_year.csv"
output_file_path <- "../../working-csv-data/17-primary_basin_year_livestock.csv"

library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv(input_file_path)

# Group by Primary_Basin and Year, then summarise the other columns
summarised_data <- data %>%
  group_by(Primary_Basin, Year) %>%
  summarise(
    Total_Cattle = sum(Cattle, na.rm = TRUE),
    Total_Sheep = sum(Sheep, na.rm = TRUE),
    Total_Pigs = sum(Pigs, na.rm = TRUE),
    Total_Poultry = sum(Poultry, na.rm = TRUE)
  ) %>%
  ungroup() # Ungroup to remove the grouping structure

# Write the summarised data to a new CSV file
write_csv(summarised_data, output_file_path)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_file_path, "' has been created."))
