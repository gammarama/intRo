transform_ui <- tabPanel("Transform",
                                                  column(4,
                                                         wellPanel(                                          
                                                             selectizeInput("trans", label = "Choose Transformation", choices = c("Power" = "power", "To Categorical" = "categorical", "To Numeric" = "numeric"), multiple = FALSE),
                                                             selectizeInput("var_trans", label = "Select Variable", choices = numericNames(mpg), multiple = FALSE),
                                                             conditionalPanel(condition = "input.trans == 'power'",
                                                                              hr(),
                                                                              numericInput("power", "Power", value = 1, min = -100, max = 100, step = 0.01),
                                                                              conditionalPanel(condition = "input.power == 0",
                                                                                  selectizeInput("log_base", "Log Base", choices = c("e" = exp(1), "2" = 2, "10" = 10))
                                                                              ),
                                                                              numericInput("original_binwidth", "Original Bin Width", value = NA, min = 0.1, step = 0.1),
                                                                              numericInput("trans_binwidth", "Transformed Bin Width", value = NA, min = 0.1, step = 0.1)
                                                             ),
                                                             conditionalPanel(condition = "input.trans == 'categorical'",
                                                                  hr(),
                                                                  selectizeInput("categorical_method", "Method", choices = c("Direct" = "direct", "Binning" = "binning")),
                                                                  conditionalPanel(condition = "input.categorical_method == 'binning'",
                                                                      numericInput("categorical_intervals", "Number of Intervals", value = 4, min = 2)                 
                                                                  )
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "savetrans", type = "button", class = "btn action-button", list(icon("save"), "Save Transformation"), onclick = "$('#side-nav :contains(\"Sources\")').highlight(); $('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
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
