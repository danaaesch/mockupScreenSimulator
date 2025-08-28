headerInfoUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    column(
      width = 12,
      wellPanel(
        div(class = "top-block",
            h3("Screen simulator"),
            fluidRow(
              column(
                width = 6,
                div(class = "bullet-col",
                    tags$ul(
                      tags$li("308 wells per plate"),
                      tags$li("Each well contains the protein under study and a particular small molecule (smallMol)"),
                      tags$li("Four measurements of the protein's diffusion coefficient (diffCoeff) per well"),
                      tags$li("As each measurement is taken through a particular field of view, we term a distinct measurement an FOV"),
                      tags$li("Thus, each FOV records a measurement of the protein's diffCoeff")
                    ),
                    tags$ul(
                      tags$li("In this Shiny app, we assume that all FOVs are on the scale of the log2(FC)")
                    ),
                    tags$ul(
                      tags$li("Positive control (posCont) : smallMol known to affect diffCoeff"),
                      tags$li("Two types of posConts:",
                              tags$ul(
                                tags$li("One increases diffCoeff"),
                                tags$li("The other decreases diffCoeff")
                              )
                      ),
                      tags$li("Each plate contains three wells of each type of posCont")
                    )
                )
              ),
              column(
                width = 6,
                div(class = "bullet-col",
                    tags$ul(
                      tags$li("negCont :",
                              tags$ul(
                                tags$li("Six wells per plate"),
                                tags$li("Known to not change diffCoeff")
                              )
                      ),
                    ),
                    tags$ul(
                      tags$li("Each smallMol may either affect or not affect the diffCoeff",
                        tags$ul(
                          tags$li("'H1 smallMol' : Affects the diffCoeff"),
                          tags$li("'H0 smallMol' : Doesn't affect the diffCoeff")
                        )
                      ),
                      tags$li("An H1 smallMol may either increase the diffCoeff or decrease the diffCoeff")
                    ),
                    tags$ul(
                      tags$li("Currently, we assume the variance of the FOVs for negCont to be that of a ",
                        "t-distribution with df chosen below. Later, we may want to allow user to input an estimated variance ",
                        "for this.")
                    )
                )
              )
            )
        )
      )
    )
  )
}

headerInfoServer <- function(id) {
  moduleServer(id, function(input, output, session) { })
}
