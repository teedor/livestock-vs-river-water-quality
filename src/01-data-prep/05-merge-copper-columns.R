# Read the CSV file
data <- read.csv("../../working-csv-data/04-river-data-with-ward.csv")

# Find values in CUSOL2_UGL with no matching value in CUSOL1_MGL
missing_values <- data$CUSOL2_UGL[is.na(match(data$CUSOL2_UGL, data$CUSOL1_MGL))]

# Divide the CUSOL2_UGL values by 1000 and assign them to CUSOL1_MGL
data$CUSOL1_MGL[is.na(match(data$CUSOL2_UGL, data$CUSOL1_MGL))] <- missing_values / 1000

# Remove the CUSOL2_UGL column from the dataframe
data <- data[, -which(names(data) == "CUSOL2_UGL")]

# Write the updated data back to the CSV file
write.csv(data, "../../working-csv-data/05-river-data-merged-copper-columns.csv", row.names = FALSE)

