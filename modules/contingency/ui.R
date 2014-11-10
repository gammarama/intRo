contingency_ui <- tabPanel("Contingency",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("xcont", label = "X Variable (x)", choices = categoricNames(mpg), selected = categoricNames(mpg)[5]),
                                                             selectizeInput("ycont", label = "Y Variable (y)", choices = categoricNames(mpg), selected = categoricNames(mpg)[6]),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("conttype", label = "Type", choices = c("Counts" = "counts", "Row Percentages" = "rowpercs", "Column Percentages" = "columnpercs", "Total Percentages" = "totalpercs"))
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tableOutput("conttable")
                                                  )
                                         )