input_file_path <- "../../working-csv-data/02-river-data-removed-unnecessary-columns.csv"
output_file_path <- "../../working-csv-data/03-river-data-with-lat-lng.csv"

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
if (!requireNamespace("purrr", quietly = TRUE)) {
  install.packages("purrr")
}
if (!requireNamespace("sf", quietly = TRUE)) {
  install.packages("sf")
}

library(dplyr)
library(purrr)
library(sf)

# Define the function 'convertIrishGridToLatLong_sf'
# x: The easting coordinate in the Irish grid reference system
# y: The northing coordinate in the Irish grid reference system
convertIrishGridToLatLong_sf <- function(x, y) {
  # Create a simple feature geometry (sf) object representing a point from the x and y coordinates.
  # The 'crs' argument specifies the coordinate reference system used by the input coordinates, 
  # in this case, EPSG code 29902 for the Irish National Grid.
  points <- st_sfc(st_point(c(x, y)), crs = 29902)
  
  # Transform the point's coordinate reference system from the Irish National Grid (EPSG:29902)
  # to WGS84 (EPSG:4326), which is the standard for latitude and longitude.
  # This step converts the grid coordinates to geographic coordinates.
  pointsWGS84 <- st_transform(points, crs = 4326)
  
  # Extract the coordinates from the transformed 'sf' object.
  # The 'st_coordinates' function retrieves the longitude (column 1) and latitude (column 2) from the object.
  coords <- st_coordinates(pointsWGS84)
  
  # Return a list containing the latitude and longitude.
  # Note that 'coords[1, 2]' accesses the latitude and 'coords[1, 1]' accesses the longitude from the coordinates matrix.
  list(latitude = coords[1, 2], longitude = coords[1, 1]) 
}

# Read the first 20 rows of the CSV file into a dataframe
df <- read.csv(input_file_path)

# Apply the function to each row and create new columns
df <- df %>%
  mutate(
    # Create a new column 'lat_long' by applying the convertIrishGridToLatLong_sf function to each row.
    # map2 is used here because we're working with two inputs (X and Y columns) for each row.
    # .x and .y correspond to the current values of X and Y for each row, respectively.
    # The result is a list column where each element contains the latitude and longitude for the row.
    lat_long = map2(X, Y, ~convertIrishGridToLatLong_sf(.x, .y)),
    
    # Extract the latitude values from the 'lat_long' list column and create a new 'latitude' column.
    # map_dbl extracts double (numeric) values from the list column. 
    # It looks into each list element for an element named 'latitude' and pulls it out into a numeric vector.
    latitude = map_dbl(lat_long, "latitude"),
    
    # Similarly, extract the longitude values from the 'lat_long' list column and create a new 'longitude' column.
    longitude = map_dbl(lat_long, "longitude")
  ) %>%
  # Finally, remove the intermediate 'lat_long' list column as it's no longer needed after extracting latitude
  # and longitude. This is done to clean up the dataframe and keep only the necessary information.
  select(-lat_long)

# Write the modified dataframe to a new CSV file
write.csv(df, output_file_path, row.names = FALSE)