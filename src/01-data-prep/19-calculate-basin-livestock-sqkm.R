# Set the file path for the input dataset
input_filepath <- "../../working-csv-data/18-river-livestock-with-basin-counts.csv"

# Set the file path for the output dataset
output_filepath <- "../../working-csv-data/19-river-livestock-density.csv"

# Load necessary library
library(dplyr)
library(readr)

# Read the dataset
data <- read_csv(input_filepath)

# Calculate livestock per square kilometer for each livestock type
data <- data %>%
  mutate(
    Basin_Cattle_sqkm = Basin_Cattle / Basin_sqkm,
    Basin_Sheep_sqkm = Basin_Sheep / Basin_sqkm,
    Basin_Pigs_sqkm = Basin_Pigs / Basin_sqkm,
    Basin_Poultry_sqkm = Basin_Poultry / Basin_sqkm
  )

# Write the updated data to a new CSV file
write_csv(data, output_filepath)

# Output the path of the new CSV file
print(paste("A new CSV file named '", output_filepath, "' has been created."))
