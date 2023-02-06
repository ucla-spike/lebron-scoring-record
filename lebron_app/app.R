library(bs4Dash)
library(shiny)
library(tidyverse)
library(EnvStats)
library(ggimage)
library(ggtext)
library(ggdark)

ui <- dashboardPage(
  dashboardHeader(title = "LeBron v. Scoring Title",
                  skin = "dark"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      h1("When will LeBron secure the scoring title?")
    ),
    fluidRow(
      p("Select 0 hypothetical points if you want to assume nothing about next game."),
      p("You are able to select hypothetical points for the next game up to one less than the scoring record.")
    ),
    fluidRow(
      box(
        title = "Parameters",
        sliderInput("slider", "Number of simulations:", 1, 10000, 100),
        checkboxGroupInput("year", "Seasons of data to include:",
                           c("2021" = "2021",
                             "2022" = "2022",
                             "2023" = "2023"),
                           selected = c('2021', '2022', '2023'),
                           inline = T),
        # slider input for points next game; range: 0 to 1 less than necessary to break record
        sliderInput('points_next_game', "Hypothetical points next game:", 
                    min = 0, max = 38387 - career_pts - 1, value = 0),
        actionButton(
          "submit_btn", "Run Simulation", 
          status = "primary", 
          outline = TRUE, 
          flat = TRUE, 
          size = "lg",
        ),
        width = 12,
        background = "warning"
      ),
    ),
    fluidRow(
      box(plotOutput("plot1", height = "600px"),
          title = "Simulation Plot",
          width = 12,
          maximizable = TRUE,
          background = "purple")
    )
  ),
  dark = TRUE
)

server <- function(input, output) {
  source('./helpers/get_br.R')
  source('./helpers/data_read.R')
  source('./helpers/plot.R')
  source('./helpers/run_sim.R')
  source('./helpers/he_plays.R')
  source('./helpers/mc_lebron.R')
  data <- eventReactive(input$submit_btn, {
    n <- input$slider
    year <- input$year
    points_next_game <- input$points_next_game
    # results <- replicate(n, run_sim(year, career_pts))
    # results_df <- data.frame(game_number = as.integer(names(table(results))),
    #                          prob = as.integer(table(results))/n)
    # fin <- left_join(game_log, results_df, by = 'game_number')
    fin <- mc_lebron(n, year = year, pts_next_game = points_next_game)
    fin[is.na(fin$prob), 'prob'] <- 0
    fin
  })
  output$plot1 <- renderPlot({
    
    get_plot(data(), input$slider)
  })
}

shinyApp(ui, server)