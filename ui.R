library(shiny)
library(toastui)
library(tibble)
library(grDevices)
library(bslib)
library(shinydashboard)

custom_theme <- bs_theme(
  version = 5,
  bg = "white",
  fg = "#000000",
  primary = "orange",
  secondary = "gray",
  base_font = font_google("Sora"),
) |> bs_add_rules("nav { background-image: linear-gradient(to right, orange, #FFE5B4); }")


link_github <- tags$a(
  shiny::icon("github"), "strava-quick-view",
  href = "https://github.com/DanielHauersperger/strava-quick-view/tree/main",
  target = "_blank"
)

ui <- page_navbar(
  theme = custom_theme,
  title = "Strava Quick View",
  bg = "orange",
  nav_panel(title = "Calendar", fluidRow(
    column(width = 1),
    column(width = 7, calendarOutput("activity_calendar")),
    column(width = 3, uiOutput("selected_activity")),
    column(width = 1)
  )),
  nav_panel(title = "Additional Insights", fluidRow(
    column(width = 1),
    column(width = 7,
      p("Longer activities tend to get more Kudos."),
      plotOutput("kudos_vs_time")
    ),
    column(width = 4)
  )),
  nav_spacer(),
  nav_item(link_github)
)
