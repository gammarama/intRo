t_test_ui <- tabPanel("T test",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("varts", label = "Type", choices=c("One Variable" = "onevart", "Two Variables" = "twovart")),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("group1", label = "Group 1 (x)", choices = numericNames(mpg)),
                                                             conditionalPanel(
                                                                 condition = "input.varts == 'twovart'",
                                                                 selectizeInput("group2", "Group 2 (y)", choices = numericNames(mpg))
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("althyp", "Alternative Hypothesis", c("Two-Sided" = "two.sided", "Greater" = "greater", "Less" = "less")),
                                                             numericInput("hypval", "Hypothesized Value", value = 0),
                                                             sliderInput("conflevel", "Confidence Level", min=0.01, max=0.99, step=0.01, value=0.95),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "store_t_test", type = "button", class = "btn action-button", list(icon("save"), "Store T test Result"), onclick = "$('#side-nav :contains(\"Sources\")').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tags$b("T test Results"),
                                                         verbatimTextOutput("ttesttable")
                                                  )
                                         )