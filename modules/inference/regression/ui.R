regression_ui <- tabPanel("Regression",
         column(4,
                wellPanel(
                  selectizeInput("xreg", label = "Independent Variable (x)", choices = numericNames(mpg), selected = numericNames(mpg)[4]),
                  selectizeInput("yreg", label = "Dependent Variable (y)", choices = numericNames(mpg), selected = numericNames(mpg)[5]),
                  
                  hr(),
                  
                  tags$button("", id = "saveresid", type = "button", class = "btn action-button", list(icon("save"), "Save Residuals/Fitted"), onclick = "$('#side-nav :contains(\"Sources\")').highlight();"),

                  hr(),
                  
                  tags$button("", id = "store_regression", type = "button", class = "btn action-button", list(icon("save"), "Store Regression Result"), onclick = "$('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
                )
         ),
         
         column(8,
                conditionalPanel(condition = "input.yreg != ''", 
                                 tags$b("Parameter Estimates"),
                                 tableOutput("regtable"),
                                 
                                 hr(),
                                 
                                 tags$b("Correlation"),
                                 textOutput("r"),
                                 textOutput("r2"),
                                 
                                 hr(),
                                 
                                 tags$b("Plot of Fit"),
                                 ggvisOutput("regplot"),
                                 
                                 hr(),
                                 
                                 tags$b("Residual Plots"),
                                 fluidRow(
                                     column(4, 
                                            ggvisOutput("resplot1")
                                     ),
                                     column(4,
                                            ggvisOutput("resplot2")
                                     ),
                                     column(4,
                                            ggvisOutput("resplot3")
                                     )
                                 )           
                )
         )
)
