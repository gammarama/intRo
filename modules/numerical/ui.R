numerical_ui <- tabPanel("Numerical",
                                                  column(4,
                                                         wellPanel(
                                                             checkboxGroupInput("tblvars", "Select Variables", choices = names(mpg)),
                                                             selectInput("grouping", "Select Grouping Variable", choices = names(mpg))
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         verbatimTextOutput("summary")
                                                  )
                                         )