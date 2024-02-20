input_file_path <- "../../initial-csv-data/River_Water_Quality_Monitoring_1990_to_2018.csv"
output_file_path <- "../../working-csv-data/02-river-data-removed-unnecessary-columns.csv"

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
if (!requireNamespace("lubridate", quietly = TRUE)) {
  install.packages("lubridate")
}

# Load necessary libraries
library(dplyr)
library(lubridate)

# Step 1: Read the CSV file into a dataframe
df <- read.csv(input_file_path)

# Step 2: Select the required columns
df_selected <- select(df, Site_Code, Station_Name, Primary_Basin, X, Y, Date,
                      ALK_MGL, BOD_MGL, COND_USCM, CUSOL1_MGL, CUSOL2_UGL, DO_MGL,
                      FESOL1_UGL, NO3_N_MGL, NO2_N_MGL, NH4_N_MGL, PH, P_SOL_MGL, SS_MGL,
                      ZN_SOL_UGL)

# Step 3: Convert the 'Date' column to the desired date format and add as 'ISO_DATE'
# Assuming the original 'Date' format is 'yyyy/mm/dd hh:mm:ss+zz', as per the example
df_selected$ISO_DATE <- as.Date(df_selected$Date, format = "%Y/%m/%d")

# Step 4: Write the modified dataframe to a new CSV file
write.csv(df_selected, output_file_path, row.names = FALSE)
