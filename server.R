library(shiny)
library(rStrava)
library(tidyverse)
library(bslib)
library(lubridate)

source("R/utils.R")

# app_name <- 'ADD-HERE' # chosen by user
# app_clietidyverseapp_client_id  <- 'ADD-HERE' # an integer, assigned by Strava
# app_secret <- 'ADD-HERE' # an alphanumeric secret, assigned by Strava
# 
# # create the authentication token
# stoken <- httr::config(token = strava_oauth(app_name, app_client_id, app_secret, app_scope="activity:read_all"))
# 
# my_athlete <- get_athlete(stoken)
# my_id <- my_athlete$id
# 
# my_acts <- get_activity_list(stoken, after = as.Date('2024-01-01'))
# df <- my_acts |> compile_activities() |> as_tibble()

server <- function(input, output, session) {
  n <- length(df)
  n_types <- length(unique(df$type))
  orange_colors <- colorRampPalette(c("yellow", "#FF6700"))(n_types) 
  my_df <- as_tibble(df) |> 
    mutate(
      type_factor = as.integer(factor(type)),
      type_color = sapply(type_factor, function(i) orange_colors[i])
    ) |>
    transmute(
      calendarId = id,
      title = name,
      body = name,
      start = as.POSIXct(start_date_local, format="%Y-%m-%dT%H:%M:%SZ"),
      end = as.POSIXct(start_date_local, format="%Y-%m-%dT%H:%M:%SZ"),
      category = "allday", # can also be set to "time"
      location = NA,
      backgroundColor = type_color,
      color = 'black',
      borderColor = type_color
    )
  
  output$activity_calendar <- renderCalendar({
    calendar(
      my_df,
      navigation = TRUE,
      useDetailPopup = FALSE,
      navOpts = navigation_options(
        fmt_date = "MMMM YYYY",
        sep_date = " - "
      )  
    )
  })

  activity_card <- function(name, sport_type, moving_time, elapsed_time, distance, average_heartrate, achievement_count) {
    card(
      class = "card",
      card_header(
        name
      ),
      card_body(
        if(achievement_count > 0) {
          paste(achievement_count, "achievements!")
        },
        p(class = "card-text", paste("Sport Type:", sport_type)),
        if (!is.na(distance)) p(class = "card-text", paste("Distance:", display_distance(distance*1000))),
        if (!is.na(moving_time)) p(class = "card-text", paste("Moving Time:", display_time(moving_time))),
        if (!is.na(average_heartrate)) p(class = "card-text", paste("Average Heart Rate:", average_heartrate, "bpm"))
      )
    )
  }
  
  output$selected_activity <- renderUI({
    req(input$activity_calendar_click)
    # note: calendarId was set to the id used by Strava
    calendarId <- input$activity_calendar_click$calendarId
    with(
      df |> dplyr::filter(id == calendarId) |> dplyr::slice(1) |> as.list(),
      activity_card(name, sport_type, moving_time, elapsed_time, distance, average_heartrate, achievement_count)
    )
  })
  
}
