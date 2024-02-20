input_file_path <- "../../working-csv-data/10-river-data-with-livestock-and-area.csv"
output_file_path <- "../../working-csv-data/11-river-data-with-livestock-densities.csv"

library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv(input_file_path)

# Calculate new values and add as new columns
data <- data %>%
  mutate(
    Cattle_per_sqkm = Cattle / area_sqkm,
    Sheep_per_sqkm = Sheep / area_sqkm,
    Pigs_per_sqkm = Pigs / area_sqkm,
    Poultry_per_sqkm = Poultry / area_sqkm
  )

# Write the modified data to a new CSV file
write_csv(data, output_file_path)

# Print a message to indicate completion
print(paste("Data with livestock adjusted for area_sqkm has been written to", output_file_path))
