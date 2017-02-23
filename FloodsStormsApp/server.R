
library(shiny)

shinyServer(function(input, output) {
      
      URL <- "https://raw.githubusercontent.com/msuassuna/StormFloodShinyApp/master/Data/TabRes.csv"
      FloodFeatures <- read.csv(URL, row.names = NULL)
      FloodFeatures$Date <- as.Date(FloodFeatures$Date, "%Y-%m-%d")

      output$distPlot1 <- renderPlot({
            x    <- FloodFeatures[, 3] 
            bins <- seq(min(x), max(x), length.out = input$bins + 1)
            hist(x, breaks = bins, col = 'darkgray',
                 main = "Histogram of flows (m3/s)", xlab = "Flow (m3/s)",
                 probability = TRUE)
            if(input$ShowDensity){
                  lines(density(x), col = 2, lwd = 2)
            }
      })
      
      output$distPlot2 <- renderPlot({
            x <- as.Date(FloodFeatures[, 2],"%Y-%m-%d")
            y <- FloodFeatures[, 3] 
            plot(x,y, col = 'darkgray', type = "l",
                 xlab = "", ylab = "Flow (m3/s)",
                 bty = "n")
            points(x,y, pch = 20)
            if(input$ShowTrend){
                  Fit <- lm(y ~ x)
                  abline(Fit, col = 2, lwd = 2)
            }
      })
      
      output$coef1 <- renderPrint({
            if(input$ShowTrend){
                  x <- as.Date(FloodFeatures[, 2],"%Y-%m-%d")
                  y <- FloodFeatures[, 3] 
                  Fit <- lm(y ~ x)
                  round(summary(Fit)$coef,3)
            }
      })
      
      selectedData <- reactive({
            FloodFeatures[, c(input$xcol, input$ycol)]
      })
      
      output$distPlot3 <- renderPlot({
            palette <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                         "#FF7F00")
            clr <- FloodFeatures[, 8]
            plot(selectedData(),
                 col = palette[clr],
                 pch = 20, cex = 3)
            
            if(input$ShowTrend2){
                  Fit <- lm(selectedData()[,2] ~ selectedData()[,1])
                  abline(Fit, col = 2, lwd = 2)
            }
      })
      
      output$coef2 <- renderPrint({
            if(input$ShowTrend2){
                  Fit <- lm(selectedData()[,2] ~ selectedData()[,1])
                  round(summary(Fit)$coef,5)
            }
      })
      
})