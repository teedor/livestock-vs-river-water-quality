library(ggplot2)
library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv("../../working-csv-data/19-river-livestock-density.csv")
output_file_path <- "../../visualisations/correlation/animal-v-chemicals-bannside-ward.png"

# Ensure the output directory exists, create it if it doesn't
output_dir <- dirname(output_file_path)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Specify the ward, chemicals, and animals of interest
target_ward <- "BANNSIDE"
chemicals <- c("NO3_N_MGL", "NO2_N_MGL")
animals <- c("Cattle", "Sheep", "Poultry") # Add your animal columns here

# Filter data for the specified ward
data_filtered <- data %>%
  filter(ward == target_ward) %>%
  select(c("ISO_DATE", animals, chemicals)) %>%
  gather(key = "Variable", value = "Value", -ISO_DATE) %>%
  mutate(ISO_DATE = as.Date(ISO_DATE, format = "%Y-%m-%d"))

# Calculate mean and standard deviation for each variable
standardized_data <- data_filtered %>%
  group_by(Variable) %>%
  mutate(
    Mean = mean(Value, na.rm = TRUE),
    SD = sd(Value, na.rm = TRUE),
    Z_Value = (Value - Mean) / SD
  ) %>%
  ungroup() %>%
  select(ISO_DATE, Variable, Z_Value) # Keep only the necessary columns

# Plot using the standardized values
ggplot(standardized_data, aes(x = ISO_DATE, y = Z_Value, color = Variable)) +
  geom_line() +
  labs(title = "Animal Counts and Chemical Levels Over Time in BANNSIDE",
       x = "Date",
       y = "Standardized Value (Z-Score)",
       color = "Variable") +
  theme_minimal() +
  theme(legend.title = element_blank())

# Execute the plotting
print(ggplot(standardized_data, aes(x = ISO_DATE, y = Z_Value, color = Variable)) +
        geom_line() +
        labs(title = "Animal Counts and Chemical Levels Over Time in BANNSIDE",
             x = "Date",
             y = "Standardized Value (Z-Score)",
             color = "Variable") +
        theme_minimal() +
        theme(legend.title = element_blank()))

ggsave(output_file_path, width = 10, height = 8, dpi = 300)