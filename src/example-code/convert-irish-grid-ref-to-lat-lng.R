if (!requireNamespace("sf", quietly = TRUE)) {
  install.packages("sf")
}

library(sf)

convertIrishGridToLatLong_sf <- function(x, y) {
  # Create an sf object with the given X and Y coordinates in the Irish Grid system
  points <- st_sfc(st_point(c(x, y)), crs = 29902)
  
  # Transform the coordinates to the WGS84 system
  pointsWGS84 <- st_transform(points, crs = 4326)
  
  # Extract the latitude and longitude from the transformed points
  coords <- st_coordinates(pointsWGS84)
  
  # Return the latitude and longitude as a list
  list(latitude = coords[2], longitude = coords[1])
}

# Example usage
# Replace 200000, 300000 with your actual X and Y values
example_X <- 239951
example_Y <- 398424

result <- convertIrishGridToLatLong_sf(example_X, example_Y)
print(result)