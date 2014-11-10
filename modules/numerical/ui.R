numerical_ui <- tabPanel("Numerical",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("tblvars", label = "Select Variables", choices = names(mpg), multiple = TRUE),
                                                             selectizeInput("grouping", label = "Select Grouping Variable", choices = names(mpg))
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         verbatimTextOutput("summary")
                                                  )
                                         )