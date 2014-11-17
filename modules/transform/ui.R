transform_ui <- tabPanel("Transform",
                                                  column(4,
                                                         wellPanel(                                          
                                                             selectizeInput("trans", label = "Choose Transformation", choices = c("Power" = "power", "Categorical" = "categorical", "Numeric" = "numeric"), multiple = FALSE),
                                                             selectizeInput("var_trans", label = "Select Variable", choices = numericNames(mpg), multiple = FALSE),
                                                             conditionalPanel(condition = "input.trans == 'power'",
                                                                              numericInput("power", "Power", value = 1, min = -100, max = 100, step = 0.01)
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "savetrans", type = "button", class = "btn action-button", list(icon("save"), "Save Transformation"), onclick = "$('#side-nav :contains(\"Sources\")').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         textOutput("var_trans_text"),
                                                         
                                                         hr(),
                                                         
                                                         conditionalPanel(condition = "input.trans == 'power'",
                                                                          tags$b("Original Data"),
                                                                          ggvisOutput("var_plot"),                                        
                                                                          tags$b("Transformed Data"),
                                                                          ggvisOutput("trans_plot")
                                                         )
                                                  )
                                         )