nonparametric_ui <- tabPanel("Nonparametric",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("group1_non", label = "Group 1 (x)", choices = numericNames(mpg), selected = numericNames(mpg)[1]),
                                                             selectizeInput("group2_non", "Group 2 (y)", choices = numericNames(mpg), selected = numericNames(mpg)[2]),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("althyp_non", "Alternative Hypothesis", c("Two-Sided" = "two.sided", "Greater" = "greater", "Less" = "less")),
                                                             numericInput("hypval_non", "Hypothesized Value", value = 0),
                                                             sliderInput("conflevel_non", "Confidence Level", min=0.01, max=0.99, step=0.01, value=0.95),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "store_nonparametric", type = "button", class = "btn action-button", list(icon("save"), "Store Nonparametric Result"), onclick = "$('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tags$b("Nonparametric Results"),
                                                         verbatimTextOutput("nonparametrictest")
                                                  )
                                         )
