varRatioUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(
      ns("ratVarsNullToNegCont"),
      label = "How big is the variance of the diffCoeff of the H0 smallMols relative to that of the negConts?",
      min = 1, max = 4, value = 2, step = 0.1
    ),
    plotOutput(ns("varRatioPlot"), height = 300)
  )
}

varRatioServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$varRatioPlot <- renderPlot({
      ratio <- input$ratVarsNullToNegCont
      n_red  <- 20
      n_grey <- 30 * n_red
      
      x_grey <- runif(n_grey)
      y_grey <- rnorm(n_grey, mean = 0, sd = sqrt(ratio))
      
      x_red  <- runif(n_red)
      y_red  <- rnorm(n_red,  mean = 0, sd = 1)
      
      y_all <- c(y_grey, y_red)
      
      plot(x_grey, y_grey, xaxt='n',
           xlab = "", ylab = "log2(FC)", axes = FALSE, # ann = FALSE,
           pch = 16, col = "grey50", cex = 1, cex.lab=1.5, # cex.axis=1.5,
           ylim = range(y_all), xlim = c(0, 1))
      abline(h=0, lwd=2)
      points(x_red, y_red, pch = 16, col = "red", cex = 3)
      box(bty = "l")
      axis(2, 0, 0, cex.axis=1.5)
      # Two-word colored title (stacked for clarity)
      mtext(c("negCont", "smallMols"), side = 3, line = 0.6, col = c("red", "grey40"),   cex = 1.5, adj=c(0.1, 0.9))
      # mtext("smallMols", side = 3, line = -0.1, col = "grey40", cex = 0.95)
    })
  })
}
