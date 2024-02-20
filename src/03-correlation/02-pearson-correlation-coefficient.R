# Load necessary libraries
library(readr)
library(dplyr)
library(reshape2)
library(ggplot2)

# Read the CSV file
data <- read_csv("../../working-csv-data/19-river-livestock-density.csv")

output_file_path <- "../../working-csv-data/correlation/correlation_matrix.csv"


# Select only the specified columns
data_selected <- select(data, ALK_MGL, BOD_MGL, COND_USCM, CUSOL1_MGL, DO_MGL, FESOL1_UGL, NO3_N_MGL, NO2_N_MGL, NH4_N_MGL, PH, P_SOL_MGL, SS_MGL, ZN_SOL_UGL, Basin_Cattle_sqkm, Basin_Sheep_sqkm, Basin_Pigs_sqkm, Basin_Poultry_sqkm)

# Ensure the output directory exists, create it if it doesn't
output_dir <- dirname(output_file_path)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Ensure all columns used are numeric
data_numeric <- data_selected[, sapply(data_selected, is.numeric)]

# Remove rows with any NA values in the dataset
data_clean <- na.omit(data_numeric)

# Calculate correlation matrix for the cleaned numeric dataset
corr_matrix <- cor(data_clean)

# Melt the correlation matrix for visualization
melted_corr_matrix <- melt(corr_matrix)

# Create a heatmap with ggplot2
ggplot(melted_corr_matrix, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1,1), space = "Lab", name="Pearson\nCorrelation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "", title = "Correlation Matrix Heatmap") +
  coord_fixed()

# Save the last plot with custom dimensions
ggsave("../../visualisations/correlation/pearson-correlation-coefficient-heatmap.png", width = 10, height = 8, dpi = 300)

# Write the correlation matrix to a CSV file
write.csv(corr_matrix, output_file_path, row.names = TRUE)

