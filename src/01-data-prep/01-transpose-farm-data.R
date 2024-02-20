input_file <- "../../initial-csv-data/Animals_1999-2014.csv"
output_file <- "../../working-csv-data/01-livestock-data.csv"

# Ensure the output directory exists, create it if it doesn't
output_dir <- dirname(output_file)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Check if the dplyr package is installed, installing it if not found
# dplyr is used for data manipulation tasks such as filtering and renaming
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

# Check if the tidyr package is installed, installing it if not found
# tidyr is used for transforming the shape of dataframes, particularly pivoting
if (!requireNamespace("tidyr", quietly = TRUE)) {
  install.packages("tidyr")
}

# Load the tidyr and dplyr libraries for use in the script
library(tidyr)
library(dplyr)

# Read the original CSV file into an R dataframe
# The read.csv function is part of base R and is used to load CSV files into R dataframes
df <- read.csv(input_file)

# Reshape and filter the dataframe using a dplyr and tidyr pipeline
new_df <- df %>%
  # Select columns: WARDS, War_Code, and any columns starting with "Cattle_", "Sheep_", "Pigs_", "Poultry_"
  select(WARDS, War_Code, starts_with("Cattle_"), starts_with("Sheep_"),
         starts_with("Pigs_"), starts_with("Poultry_")) %>%
  # Pivot the selected columns to a longer format, separating year from animal type
  # This creates two new columns: one for the animal type and one for the year
  pivot_longer(cols = -c(WARDS, War_Code), names_to = c(".value", "Year"), names_sep = "_") %>%
  # Rename the WARDS and War_Code columns to 'ward' and 'ward_code' for clarity and consistency
  rename(ward = WARDS, ward_code = War_Code)

# Write the transformed dataframe to a new CSV file
# row.names = FALSE ensures that the row names (indices) are not written to the file, only the data
write.csv(new_df, output_file, row.names = FALSE)
