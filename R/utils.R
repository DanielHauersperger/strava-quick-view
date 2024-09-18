# utils.R
# Utility functions used throughout the app.
library(lubridate)

display_time <- function(time_in_seconds) {
  period <- seconds_to_period(time_in_seconds)
  
  # if less than one hour, show in mm:ss format
  if(hour(period) < 1) {
    return(sprintf("%d:%02d", minute(period), second(period)))
  }
  # otherwise, display in Xh Ym (e.g. 1h 30m) format
  return(sprintf("%dh %dm", hour(period), minute(period)))
}

display_distance <- function(distance_in_meters) {
  distance_in_meters <- floor(distance_in_meters)
  # if less than 1000 meters, display in meters
  if (distance_in_meters < 1000) {
    return(sprintf("%dm", distance_in_meters))
  }
  # otherwise, display in kilometers
  kilometers <- distance_in_meters / 1000
  return(sprintf("%.2fkm", kilometers))
}
