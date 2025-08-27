corrFOVsUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(
      ns("corFOVs"),
      label = "How correlated are FOVs from the same well?",
      min = 0, max = 60, value = 30, step = 1
    ),
    plotOutput(ns("scatterPlot"), height = 300)
  )
}

corrFOVsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$scatterPlot <- renderPlot({
      r <- input$corFOVs / 100
      r <- max(min(r, 0.99), -0.99)
      Sigma <- matrix(c(1, r, r, 1), nrow = 2)
      pts <- MASS::mvrnorm(n = 40, mu = c(0, 0), Sigma = Sigma)
      par(mar=c(0,0,3,0))
      plot(pts[,1], pts[,2],
           xlab = "", ylab = "", axes = FALSE, ann = FALSE,
           pch = 16, pty='s')
      # box(bty = "s")
      title(main = sprintf("Corr'n of FOVs from same well (r ≈ %.2f)", r), cex.main = 0.9)
    })
  })
}
