graphical_ui <- tabPanel("Graphical",
                                                  column(4,
                                                         wellPanel(
                                                             selectizeInput("plottype", label = "Plot Type", choices = c("Histogram" = "histogram", "Normal Quantile Plot" = "quantileplot", "Scatterplot" = "scatterplot", "Line Chart" = "linechart", "Boxplot" = "boxplot", "Bar Chart" = "barchart", "Pareto Chart" = "paretochart", "Mosaic Plot" = "mosaicplot")),
                                                             
                                                             hr(),
                                                             
                                                             selectizeInput("x", label = "X Variable (x)", choices = numericNames(mpg), selected = numericNames(mpg)[1]),
                                                             #conditionalPanel(
                                                             #    condition = "input.plottype == 'barchart' || input.plottype == 'paretochart'",
                                                             #    checkboxInput("addy", "Y Variable")
                                                             #),
                                                             conditionalPanel(
                                                                 condition = "(input.plottype != 'histogram' && input.plottype != 'quantileplot' && input.plottype != 'barchart' && input.plottype != 'paretochart') || input.addy == true",
                                                                 selectizeInput("y", label = "Y Variable (y)", choices = numericNames(mpg), selected = numericNames(mpg)[2])
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             fluidRow(
                                                                 column(5,
                                                                        conditionalPanel(condition = "input.plottype != 'mosaicplot' && input.plottype != 'barchart' && input.plottype != 'paretochart' && input.plottype != 'boxplot'",
                                                                                         numericInput("xmin", "X Min", value = NA, step = 0.1)
                                                                        )
                                                                 ),
                                                                 column(2),
                                                                 column(5,
                                                                        conditionalPanel(condition = "input.plottype != 'mosaicplot' && input.plottype != 'barchart' && input.plottype != 'paretochart' && input.plottype != 'boxplot'",
                                                                                         numericInput("xmax", "X Max", value = NA, step = 0.1)                    
                                                                        )
                                                                 )
                                                             ),
                                                             fluidRow(
                                                                 column(5,
                                                                        conditionalPanel(condition = "input.plottype != 'mosaicplot'",
                                                                                         numericInput("ymin", "Y Min", value = NA, step = 0.1)
                                                                        )
                                                                 ),
                                                                 column(2),
                                                                 column(5,
                                                                        conditionalPanel(condition = "input.plottype != 'mosaicplot'",
                                                                                         numericInput("ymax", "Y Max", value = NA, step = 0.1)
                                                                        )
                                                                 )
                                                             ),
                                                             conditionalPanel(
                                                                 condition = "input.plottype == 'histogram'",
                                                                 numericInput("binwidth", "Bin Width", value = NA, min = 0.1, step = 0.1)
                                                             ),
                                                             
                                                             hr(),
                                                             
                                                             tags$button("", id = "store_graphical", type = "button", class = "btn action-button", list(icon("save"), "Store Graphical Result"), onclick = "$('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').highlight();")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         textOutput("plotted_vars"),
                                                         conditionalPanel(condition = "input.plottype == 'histogram'",
                                                                          ggvisOutput("histogram")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'quantileplot'",
                                                                          ggvisOutput("quantileplot")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'scatterplot'",
                                                                          ggvisOutput("scatterplot")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'linechart'",
                                                                          ggvisOutput("linechart")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'boxplot'",
                                                                          ggvisOutput("boxplot")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'mosaicplot'",
                                                                          plotOutput("mosaicplot")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'barchart'",
                                                                          ggvisOutput("barchart")
                                                         ),
                                                         conditionalPanel(condition = "input.plottype == 'paretochart'",
                                                                          ggvisOutput("paretochart")
                                                         )
                                                  )
                                         )
