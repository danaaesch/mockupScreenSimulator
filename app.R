library(shiny)
library(shinyWidgets)
library(MASS)

source("modules/headerInfo.R")
source("modules/fatTail.R")
source("modules/corrFOVs.R")
source("modules/varRatio.R")

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      /* Global tweaks */
      .top-block h3 { margin-top: 0; font-weight: 700; }
      .bullet-col ul { margin-top: 0.4rem; }

      /* Hide ALL numeric slider labels and value bubble for sliderTextInput */
      .irs-grid, .irs-min, .irs-max, .irs-from, .irs-to, .irs-single { display: none !important; }

      /* A precise, above-the-track label bar for endpoint words */
      .slider-endcaps {
        display: flex; justify-content: space-between;
        font-size: 12px; color: #555; margin-top: -6px; margin-bottom: 6px;
      }
    "))
  ),
  
  # Row 1: title + two bullet columns
  headerInfoUI("hdr"),
  
  # Row 2: three columns
  fluidRow(
    column(4, fatTailUI("fat")),
    column(4, corrFOVsUI("cor")),
    column(4, varRatioUI("varr"))
  ) #,
  # hr(),
  # fluidRow(
  #   column(4, fatTailUI("fat")),
  #   column(4, corrFOVsUI("cor")),
  #   column(4, varRatioUI("varr"))
  # )
)

server <- function(input, output, session) {
  headerInfoServer("hdr")
  fatTailServer("fat")
  corrFOVsServer("cor")
  varRatioServer("varr")
}

shinyApp(ui, server)
