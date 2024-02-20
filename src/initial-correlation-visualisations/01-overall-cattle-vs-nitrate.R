if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the data
data <- read.csv("../../working-csv-data/river-water-samples-with-livestock-data_final.csv")

# Filter out rows where Cattle Density is more than 500
data <- data %>% 
filter(Cattle_per_sqkm <= 500)

# Scatter plot for Cattle Density vs. NO3_N_MGL with filtered data
ggplot(data, aes(x = Cattle_per_sqkm, y = NO3_N_MGL)) +
  geom_point(alpha = 0.5) +
  theme_minimal() +
  labs(title = "Cattle Density vs. Nitrate Nitrogen Levels",
       x = "Cattle per sqkm",
       y = "NO3_N_MGL")
