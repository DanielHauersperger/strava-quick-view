library(shiny)
library(toastui)
library(tibble)
library(grDevices)
library(bslib)

custom_theme <- bs_theme(
  version = 5,
  bg = "#FFFFFF",
  fg = "#000000",
  primary = "orange",
  secondary = "gray",
  base_font = "Sora"
)

ui <- fluidPage(
  theme = custom_theme,
  tags$link(rel="stylesheet", href="https://fonts.googleapis.com/css2?family=Sora:wght@100..800&display=swap"),
  tags$h2("Strava Quick View", style="background: linear-gradient(to right, orange, #FFE5B4);
            color: black;
            padding: 20px;
            text-align: center;
            font-weight: bold;
            border-radius: 8px;"),
  fluidRow(
    column(
      width = 1
    ),
    column(
      width = 7,
      calendarOutput("activity_calendar")
    ),
    column(
      width = 3,
      uiOutput("selected_activity")
    ),
    column(
      width = 1
    )
  )
)
