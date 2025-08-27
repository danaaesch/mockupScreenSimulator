fatTailUI <- function(id) {
  ns <- NS(id)
  tagList(
    # Endpoint labels above the slider (numbers hidden via CSS in app.R)
    div(class = "slider-endcaps",
        span("Skinnier"), span("Fatter")
    ),
    shinyWidgets::sliderTextInput(
      inputId = ns("fatTail"),
      label   = "Given the mean diffCoeff for a particular well, how fat are the tails of the distribution of the FOVs from that well?",
      choices = as.character(seq(0, 10, by = 0.1)),
      selected = "6",
      grid = FALSE #,   # no grid/tick labels
      # ticks = FALSE   # no min/max ticks
    ),
    plotOutput(ns("fatTailGraph"), height = 300)
  )
}

fatTailServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$fatTailGraph <- renderPlot({
      # df = max(1, fatTail - 10)
      val <- suppressWarnings(as.numeric(input$fatTail))
      if (is.na(val)) val <- 6
      df <- 11.1-val
      
      x  <- seq(-5, 5, length.out = 400)
      yt <- dt(x, df = df)
      yn <- dnorm(x)
      
      plot(x, yt, type = "l", lwd = 4, col = "grey40",
           xlab = "", ylab = "Density", xaxt='n',
           ylim = c(0, 0.42), main="Shape of density of pdf generating\nFOVs from a particular well")
           # main = sprintf("t(df = %.1f) vs N(0,1)", df))
      # lines(x, yn, col = "red", lwd = 2)
      # legend("topright", inset = 0.02, bty = "n",
      #        lwd = c(4,2), col = c("grey40","red"),
      #        legend = c(sprintf("t (df=%.1f)", df), "Standard normal"))
    })
  })
}
