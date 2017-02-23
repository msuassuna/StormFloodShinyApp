library(shiny)

shinyUI(
      fluidPage(

            titlePanel("Explore different flood records and Storm Tracks"),
            navlistPanel(
                  "Plot type",
                  tabPanel("Histogram",
                           h3("Histogram"),
                           sliderInput("bins",
                                       "Number of bins:",
                                       min = 1,max = 20,value = 10),
                           checkboxInput("ShowDensity",
                                         "Show / Hide Density",
                                         value = TRUE),
                           plotOutput("distPlot1")
                  ),
                  tabPanel("Time Series",
                           h3("Time Series"),
                           checkboxInput("ShowTrend",
                                         "Show / Hide Linear Trend",
                                         value = TRUE),
                           verbatimTextOutput("coef1"),
                           plotOutput("distPlot2")
                  ),
                  tabPanel("Scatter Plots",
                           h3("Scatter Plots"),
                           selectInput('xcol', 'X Variable',
                                       names(FloodFeatures)[c(2,3,7,9:13)],
                                       selected = names(FloodFeatures)[2]),
                           selectInput('ycol', 'Y Variable',
                                       names(FloodFeatures)[c(2,3,7,9:13)],
                                       selected = names(FloodFeatures)[3]),
                           checkboxInput("ShowTrend2",
                                         "Show / Hide Linear Trend",
                                         value = TRUE),
                           verbatimTextOutput("coef2"),
                           plotOutput("distPlot3")
                  )
            )
      )
)