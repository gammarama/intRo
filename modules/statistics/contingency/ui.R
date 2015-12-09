contingency_ui <- tabPanel("Contingency",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("xcont", label = "X Variable (x)", choices = categoricNames(mpg), selected = categoricNames(mpg)[5]),
                                                             selectizeInput("ycont", label = "Y Variable (y)", choices = categoricNames(mpg), selected = categoricNames(mpg)[6]),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("conttype", label = "Type", choices = c("Counts" = "counts", "Row Proportions" = "rowpercs", "Column Proportions" = "columnpercs", "Total Proportions" = "totalpercs")),
                                                             conditionalPanel(condition = "input.conttype != 'counts'",
                                                                numericInput("contdigits", label = "Digits", value = 2, min = 1, step = 1)
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "store_contingency", type = "button", class = "btn action-button", list(icon("save"), "Store Contingency Result"), onclick = "$('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tableOutput("conttable")
                                                  )
                                         )
