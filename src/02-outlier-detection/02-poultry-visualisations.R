# The script's primary intent is to visually analyze and present the distribution of poultry counts across different wards, 
# with a particular focus on wards that have been previously identified as containing outlier data points. 
# By using boxplots, the script provides a clear and concise graphical representation that highlights the central tendency, 
# dispersion, and potential outliers within each ward's poultry count data. 
# This visualization aids in understanding the data's distribution at a glance and facilitates the identification of 
# wards with unusual data patterns, possibly indicating data entry errors, exceptional events, or other anomalies worth investigating further. 
# The use of ggplot2 ensures that the resulting plots are both informative and aesthetically pleasing, 
# making the data more accessible and understandable to a broad audience.

# Load the required libraries for data manipulation and visualization.
library(ggplot2)
library(dplyr)

# Specify the path to the input CSV file which contains the poultry data along with an outlier flag for each record.
input_file_path <- "../../working-csv-data/outliers/01-poultry-outliers.csv"
output_file_path <- "../../visualisations/outliers/ward_poultry_boxplots.png"

# Read the data from the specified CSV file into a dataframe.
data_with_outliers <- read.csv(input_file_path)

# Ensure the output directory exists, create it if it doesn't
output_dir <- dirname(output_file_path)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Identify and extract a list of unique wards that have at least one record flagged as an outlier.
# This is achieved by filtering the data to only include rows where the OutlierFlag is TRUE,
# then selecting the distinct wards and pulling them into a vector.
wards_with_outliers <- data_with_outliers %>%
  distinct(ward) %>%
  pull(ward)

# Filter the original dataset to include only those records from wards identified as containing outliers.
# This step ensures that the boxplot visualization will focus solely on wards of interest,
# i.e., those with at least one outlier.
data_for_boxplot <- data_with_outliers %>%
  filter(ward %in% wards_with_outliers)

# Generate a boxplot visualization using ggplot2.
# The aes function defines the aesthetic mappings, using 'ward' as the x-axis and 'Poultry' counts as the y-axis.
# The fill aesthetic is also mapped to 'ward' to color code the boxplots by ward, enhancing visual distinction.
# geom_boxplot() draws the actual boxplots.
# The theme() function is used to rotate the x-axis labels (ward names) for better readability.
# labs() specifies the plot title and axis labels, providing context to the visualization.
# scale_fill_discrete() names the legend, clarifying that the colors correspond to different wards.
ggplot(data_for_boxplot, aes(x = ward, y = Poultry, fill = ward)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Boxplot of Poultry Counts by Ward",
       x = "Ward",
       y = "Poultry Count") +
  scale_fill_discrete(name = "Ward")

# Save the generated plot to a file, specifying its dimensions.
# This function creates a PNG image file named 'ward_poultry_boxplots.png',
# which contains the boxplot visualization. The specified width and height control the size of the output image.
ggsave(output_file_path, width = 10, height = 6)
