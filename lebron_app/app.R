library(bs4Dash)
library(shiny)
library(tidyverse)
library(EnvStats)
library(ggimage)
ui <- dashboardPage(
  dashboardHeader(title = "When will LeBron secure the scoring title?"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
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
        actionButton(
          "submit_btn", "Run Simulation", 
          status = "primary", 
          outline = TRUE, 
          flat = TRUE, 
          size = "lg"
        )
      )),
    fluidRow(
      box(plotOutput("plot1", height = 250))
    )
  )
)

server <- function(input, output) {
  source('./helpers/get_br.R')
  source('./helpers/data_read.R')
  source('./helpers/plot.R')
  source('./helpers/run_sim.R')
  source('./helpers/he_plays.R')
  data <- eventReactive(input$submit_btn, {
    n <- input$slider
    year <- input$year
    results <- replicate(n, run_sim(year, career_pts))
    results_df <- data.frame(game_number = as.integer(names(table(results))),
                             prob = as.integer(table(results))/n)
    fin <- left_join(game_log, results_df, by = 'game_number')
    fin[is.na(fin$prob), 'prob'] <- 0
    fin
  })
  output$plot1 <- renderPlot({
    
    get_plot(data())
  })
}

shinyApp(ui, server)
d