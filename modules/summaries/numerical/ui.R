numerical_ui <- tabPanel("Numerical",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("tblvars", label = "Select Variables", choices = names(mpg), multiple = TRUE),
                                                             selectizeInput("grouping", label = "Select Grouping Variable", choices = names(mpg)),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "store_numerical", type = "button", class = "btn action-button", list(icon("save"), "Store Numerical Result"), onclick = "$('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         textOutput("summary_warning"),
                                                         hr(),
                                                         verbatimTextOutput("summary")
                                                  )
                                         )
