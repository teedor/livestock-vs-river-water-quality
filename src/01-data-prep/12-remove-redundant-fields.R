input_file_path <- "../../working-csv-data/11-river-data-with-livestock-densities.csv"
output_file_path <- "../../working-csv-data/12-river-water-samples-with-livestock-data_final.csv"

library(readr)
library(dplyr)

# Read the CSV file
data <- read_csv(input_file_path)

# Remove the specified columns
data_cleaned <- select(data, -Site_Code, -Station_Name, -X, -Y, -Date)

# Write the cleaned data to a new CSV file
write_csv(data_cleaned, output_file_path)

# Print a message to indicate completion
print(paste("Data without specified columns has been written to", output_file_path))
