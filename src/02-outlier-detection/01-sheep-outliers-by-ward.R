# The script's primary goal is to identify outliers in sheep counts across different wards, where outliers are defined as counts more than 
# 8 times the median for their ward and exceeding 10,000. This process involves:

# Filtering irrelevant data: Excludes counts less than 5, as they are not meaningful for outlier analysis.
# Calculating medians: Determines what is typical for each ward, providing a baseline for comparison.
# Identifying outliers: Flags data points that significantly deviate from the norm based on the predefined criteria.
# Outputting results: Saves the processed data, including outlier flags, to a new file, facilitating further analysis or review.

# This methodical approach ensures a focused analysis on significant deviations in sheep counts,
# aiding in the detection of potentially erroneous data entries or extraordinary circumstances warranting further investigation.

# Define the paths for the input and output CSV files.
input_file_path <- "../../working-csv-data/12-river-water-samples-with-livestock-data_final.csv"
output_file_path <- "../../working-csv-data/outliers/01-sheep-outliers.csv"

# Ensure the output directory exists, create it if it doesn't
output_dir <- dirname(output_file_path)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Set the threshold for identifying outliers. In this case, a count is considered
# an outlier if it is more than 8 times the ward's median sheep count.
outlierThreshold <- 8

significantCountThreshold <- 5000

# Load the dplyr package for data manipulation.
library(dplyr)

# Read the input CSV file containing livestock data.
livestock_data <- read.csv(input_file_path)

# Filter the data to exclude rows where the sheep count is less than 5,
# as these are not considered relevant for outlier analysis.
filtered_data <- livestock_data %>% filter(Sheep >= 5)

# Calculate the median sheep count for each ward. This provides a baseline
# for identifying what is considered typical within each ward.
median_counts <- filtered_data %>%
  group_by(ward) %>%
  summarise(MedianSheep = median(Sheep))

# Merge the median counts back with the original dataset. This step is essential
# for comparing individual counts to the ward's median count directly.
joined_data <- filtered_data %>%
  left_join(median_counts, by = "ward")

# Add an OutlierFlag column to the dataset. This flag is TRUE for rows where
# the sheep count is both more than 8 times the ward's median and exceeds the significant threshold count.
# This two-pronged approach ensures outliers are significantly higher than the norm
# and represent substantial counts on their own.
joined_data <- joined_data %>%
  mutate(OutlierFlag = ifelse(Sheep > outlierThreshold * MedianSheep & Sheep > significantCountThreshold, TRUE, FALSE))

# Prepare the final dataset for export by selecting only the relevant columns:
# ward, Year, Sheep, and OutlierFlag.
output_data <- joined_data %>%
  select(ward, Year, Sheep, OutlierFlag)

de_duped <- distinct(output_data)
outlier_wards <- distinct(de_duped %>% filter(OutlierFlag == TRUE), ward)
# Remove all rows from de_duped that do not contain one of the outlier wards
final_data <- de_duped %>% filter(ward %in% outlier_wards$ward)

# Write the final dataset, including the outlier flags, to a new CSV file.
write.csv(final_data, output_file_path, row.names = FALSE)

# Print a completion message to indicate that the process is done and the file
# has been successfully created.
cat("The data with outlier flags has been written to", output_file_path)
