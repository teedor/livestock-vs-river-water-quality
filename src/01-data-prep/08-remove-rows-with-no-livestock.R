input_file_path <- "../../working-csv-data/07-river-data-with-livestock.csv"
output_file_path <- "../../working-csv-data/08-cleaned-river-data-with-livestock.csv"

library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv(input_file_path)

# Remove rows where Cattle, Sheep, Pigs, and Poultry are all NA
cleaned_data <- data %>%
  filter(!(is.na(Cattle) & is.na(Sheep) & is.na(Pigs) & is.na(Poultry)))

# Write the cleaned data to a new CSV file
write_csv(cleaned_data, output_file_path)

# Print a message to indicate completion
print(paste("Cleaned data has been written to", output_file_path))
