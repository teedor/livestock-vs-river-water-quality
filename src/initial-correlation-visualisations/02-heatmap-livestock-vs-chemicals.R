if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

if (!requireNamespace("reshape2", quietly = TRUE)) {
  install.packages("reshape2")
}

# Load the data
data <- read.csv("../../working-csv-data/river-water-samples-with-livestock-data_final.csv")

# Load necessary libraries
library(ggplot2)
library(reshape2)

# Calculate correlation matrix for the selected columns
# Adjust this to include the columns you're interested in
cor_matrix <- cor(data[,c('Cattle_per_sqkm', 'Sheep_per_sqkm', 'Pigs_per_sqkm', 'Poultry_per_sqkm', 'NO3_N_MGL', 'NO2_N_MGL', 'PH', 'BOD_MGL')], use = "complete.obs")

# Melt the correlation matrix for visualization
melted_cor_matrix <- melt(cor_matrix)

# Heatmap for the correlation matrix
ggplot(melted_cor_matrix, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = '', y = '')
