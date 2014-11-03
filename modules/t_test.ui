t_test_ui <- tabPanel("T test",
                                                  column(4,
                                                         wellPanel(
                                                             radioButtons("varts", "Type", choices=c("One Variable" = "onevart", "Two Variables" = "twovart")),
                                                             
                                                             hr(),
                                                             
                                                             selectInput("group1", "Group 1 (x)", choices = numericNames(mpg)),
                                                             conditionalPanel(
                                                                 condition = "input.varts == 'twovart'",
                                                                 selectInput("group2", "Group 2 (y)", choices = numericNames(mpg))
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             selectInput("althyp", "Alternative Hypothesis", c("Two-Sided" = "two.sided", "Greater" = "greater", "Less" = "less")),
                                                             numericInput("hypval", "Hypothesized Value", value = 0),
                                                             sliderInput("conflevel", "Confidence Level", min=0.01, max=0.99, step=0.01, value=0.95)
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tags$b("T test Results"),
                                                         verbatimTextOutput("ttesttable")
                                                  )
                                         )