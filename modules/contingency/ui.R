contingency_ui <- tabPanel("Contingency",
                                                  column(4,
                                                         wellPanel(
                                                             selectInput("xcont", "X Variable (x)", choices = categoricNames(mpg), selected = categoricNames(mpg)[5]),
                                                             selectInput("ycont", "Y Variable (y)", choices = categoricNames(mpg), selected = categoricNames(mpg)[6]),
                                                             
                                                             hr(),
                                                             
                                                             radioButtons("conttype", "Type", choices = c("Counts" = "counts", "Row Percentages" = "rowpercs", "Column Percentages" = "columnpercs", "Total Percentages" = "totalpercs"))
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         tableOutput("conttable")
                                                  )
                                         )