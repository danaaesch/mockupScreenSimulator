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

varRatioServer <- function(id, dfFromFatTail) {
  moduleServer(id, function(input, output, session) {
    
    n_red  <- 20
    n_grey <- 30 * n_red
    
    # Stable x positions (no left/right jumping)
    x_pos <- reactiveVal(NULL)
    observeEvent(TRUE, {
      if (is.null(x_pos())) {
        set.seed(20240828)
        x_pos(list(grey = runif(n_grey), red = runif(n_red)))
      }
    }, once = TRUE)
    
    output$varRatioPlot <- renderPlot({
      ratio <- input$ratVarsNullToNegCont
      df    <- dfFromFatTail()
      xs    <- x_pos()
      
      # Stable RNG streams for y so the cloud doesn't "dance"
      set.seed(1001)                               # greys stream
      y_grey <- sqrt(ratio) * rt(n_grey, df = df)  # same df, scaled variance
      
      set.seed(2002)                               # reds stream
      y_red  <- rt(n_red,  df = df)                # same df => same tail heaviness
      
      y_all <- c(y_grey, y_red)
      
      plot(xs$grey, y_grey, xaxt='n',
           xlab = "", ylab = "log2(FC)", axes = FALSE,
           pch = 16, col = "grey50", cex = 1,
           ylim = range(y_all), xlim = c(0, 1))
      abline(h = 0, lwd = 2)
      points(xs$red, y_red, pch = 16, col = "red", cex = 3)
      box(bty = "l")
      axis(2, 0, 0, cex.axis = 1.5)
      
      # Two-word colored title labels
      mtext(c("negCont", "smallMols"), side = 3, line = 0.6,
            col = c("red", "grey40"), cex = 1.5, adj = c(0.1, 0.9))
      
      # --- Variance legend (df>2 ensures finiteness) ---
      var_red  <- df / (df - 2)                # Var(t_df)
      var_grey <- ratio * var_red              # scaled
      legend_text <- c(
        sprintf("df = %.2f", df),
        sprintf("Var(red)  = df/(df-2) = %.3f", var_red),
        sprintf("Var(grey) = ratio × Var(red) = %.3f", var_grey),
        sprintf("ratio = %.2f", ratio)
      )
      legend("topright", legend = legend_text, bty = "n", cex = 0.95)
    })
  })
}
