addResourcePath(prefix="images", directoryPath="images/")

library(shiny)
library(shinyAce)
library(ggvis)

shinyUI(
navbarPage("intRo", id="top-nav",  theme = "bootstrap.min.css",
    tabPanel(title="", icon=icon("home"),
       fluidRow(
         div(class='intRoPrint', h3('Results from intRo session:')),
         navlistPanel(id = "side-nav", widths = c(2, 10),
                      "Data",
                      tabPanel("Sources",
                               column(4,
                                      wellPanel(
                                        conditionalPanel(
                                          condition = "input.own == false",
                                          selectInput("data", "Choose Dataset", c("MPG" = "mpg", "Air Quality" = "airquality", "Diamonds" = "diamonds"), selected = "mpg")
                                        ),
                                        conditionalPanel(
                                          condition = "input.own == true",
                                          fileInput('data_own', 'Choose CSV File',
                                                    accept=c('text/csv', 
                                                             'text/comma-separated-values,text/plain', 
                                                             '.csv'))
                                        ),
                                        checkboxInput("own", "Upload Dataset"),
                                        
                                        hr(),
                                        fluidRow(
                                            column(6, checkboxInput("randomsub", "Random Subset")),
                                            conditionalPanel(condition = "input.randomsub == true", 
                                                column(6, numericInput("randomsubrows", "Rows", value = 10))
                                            )
                                        ),
                                        tags$button("", id = "savesubset", type = "button", class = "btn action-button", onclick="var vals = []; var subsets = $('input[type = \"text\"][placeholder]'); for(i = 0; i < subsets.length; i++) {vals.push(subsets[i].value);}; Shiny.onInputChange(\"subs\", vals);", list(icon("save"), "Save Subset")),
                                        br(), br(),
                                        tags$button("", id = "clearsubset", type = "button", class = "btn action-button", onclick="Shiny.onInputChange(\"subs\", null);", list(icon("eraser"), "Reset Data")),
                                        br(), br(),
                                        downloadButton("downloaddata", "Download Data")
                                      )
                               ),
                               
                               column(8,
                                      dataTableOutput("data")
                               )
                      ),
                      
                      tabPanel("Transform",
                               column(4,
                                      wellPanel(
                                          selectInput("var_trans", "Select Variable", choices = NULL),
                                          
                                           radioButtons("trans", "Choose Transformation", choices = c("None" = "I", "Type" = "type", "Power" = "power")),
                                           conditionalPanel(condition = "input.trans == 'power'",
                                                            numericInput("power", "Power", value = 1, min = -5, max = 5, step = 0.1)
                                           ),
                                           conditionalPanel(condition = "input.trans == 'type'",
                                                           selectInput("var_type", "Type", choices = c("Numeric" = "numeric", "Categorical" = "categorical"))
                                           ),

                                          hr(),
                                          
                                          tags$button("", id = "savetrans", type = "button", class = "btn action-button", list(icon("save"), "Save Transformation"))
                                      )
                               ),
                               
                               column(8,
                                      ggvisOutput("var_plot"),
                                      ggvisOutput("trans_plot")
                               )
                      ),
                      "-----",
                      "Summaries",
                      tabPanel("Graphical",
                               column(4,
                                      wellPanel(
                                        selectInput("plottype", "Plot Type", choices = c("Histogram" = "histogram", "Normal Quantile Plot" = "quantileplot", "Scatterplot" = "scatterplot", "Line Chart" = "linechart", "Boxplot" = "boxplot", "Bar Chart" = "barchart", "Pareto Chart" = "paretochart", "Mosaic Plot" = "mosaicplot")),
                                        
                                        hr(),
                                        
                                        selectInput("x", "X Variable (x)", choices = NULL),
                                        conditionalPanel(
                                            condition = "input.plottype == 'barchart' || input.plottype == 'paretochart'",
                                            checkboxInput("addy", "Y Variable")
                                        ),
                                        conditionalPanel(
                                          condition = "(input.plottype != 'histogram' && input.plottype != 'quantileplot' && input.plottype != 'barchart' && input.plottype != 'paretochart') || input.addy == true",
                                          selectInput("y", "Y Variable (y)", choices = NULL)
                                        ),
                                        
                                        hr(),
                                        
                                        fluidRow(
                                            column(5,
                                                   numericInput("xmin", "X Min", value = NA, step = 0.1)
                                            ),
                                            column(2),
                                            column(5,
                                                   numericInput("xmax", "X Max", value = NA, step = 0.1)
                                            )
                                        ),
                                        fluidRow(
                                            column(5,
                                                   numericInput("ymin", "Y Min", value = NA, step = 0.1)
                                            ),
                                            column(2),
                                            column(5,
                                                   numericInput("ymax", "Y Max", value = NA, step = 0.1)
                                            )
                                        ),
                                        conditionalPanel(
                                            condition = "input.plottype == 'histogram'",
                                            numericInput("binwidth", "Bin Width", value = NA, min = 0.1, step = 0.1)
                                        ),
                                        conditionalPanel(
                                            condition = "(input.plottype == 'barchart' || input.plottype == 'paretochart') && input.addy == true",
                                            radioButtons("bartype", "Y Variable Type", choices = c("Count" = "length", "Sum" = "sum", "Mean" = "mean", "Median" = "median"))
                                        )
                                      )
                               ),
                               
                               column(8,
                                      conditionalPanel(condition = "input.plottype != 'mosaicplot'",
                                            ggvisOutput("plot")
                                      ),
                                      conditionalPanel(condition = "input.plottype == 'mosaicplot'",
                                            plotOutput("mosaicplot")
                                      )
                               )
                      ),
                      tabPanel("Numerical",
                               column(4,
                                      wellPanel(
                                        checkboxGroupInput("tblvars", "Select Variables", choices = list("")),
                                        selectInput("grouping", "Select Grouping Variable", choices = NULL)
                                      )
                               ),
                               
                               column(8,
                                      #tableOutput("summary")
                                      verbatimTextOutput("new_summary")
                               )
                      ),
                      "-----",
                      "Statistics",
                      tabPanel("Contingency",
                               column(4,
                                      wellPanel(
                                          selectInput("xcont", "X Variable (x)", choices = NULL),
                                          selectInput("ycont", "Y Variable (y)", choices = NULL)
                                      )
                               ),
                               
                               column(8,
                                      tableOutput("conttable")
                               )
                      ),
                      tabPanel("Regression",
                               column(4,
                                      wellPanel(
                                          selectInput("xreg", "Independent Variable (x)", choices = NULL),
                                          selectInput("yreg", "Dependent Variable (y)", choices = NULL),
                                          
                                          hr(),
                                          tags$button("", id = "saveresid", type = "button", class = "btn action-button", list(icon("save"), "Save Residuals/Fitted"))
                                          #actionButton("saveresid", "Save Residuals/Fitted", icon = icon("save"))
                                      )
                               ),
                               
                               column(8,
                                      tags$b("Parameter Estimates"),
                                      tableOutput("regtable"),
                                      hr(),
                                      tags$b("Correlation"),
                                      textOutput("r"),
                                      textOutput("r2"),
                                      hr(),
                                      tags$b("Plot of Fit"),
                                      ggvisOutput("regplot"),
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
                      ),
                      tabPanel("T test",
                               column(4,
                                      wellPanel(
                                          radioButtons("varts", "Type", choices=c("One Variable" = "onevart", "Two Variables" = "twovart")),

                                          hr(),
                                          
                                          selectInput("group1", "Group 1 (x)", choices = NULL),
                                          conditionalPanel(
                                              condition = "input.varts == 'twovart'",
                                              selectInput("group2", "Group 2 (y)", choices = NULL)
                                          ),
                                          
                                          hr(),
                                          
                                          selectInput("althyp", "Alternative Hypothesis", c("Two-Sided" = "two.sided", "Greater" = "greater", "Less" = "less")),
                                          numericInput("hypval", "Hypothesized Value", value = 0),
                                          sliderInput("conflevel", "Confidence Level", min=0.01, max=0.99, step=0.01, value=0.95)
                                      )
                               ),
                               
                               column(8,
                                      tags$b("T test Results"),
                                      verbatimTextOutput("ttesttable")
                               )
                      )
         )
       ),
              
       hr(),
       
       fluidRow(
         column(12,
                aceEditor("myEditor", "", mode="r", readOnly=TRUE, theme="chrome"),
                div(class='codePrint',div(id='codePrint'))
         )
       )     
             ),
    tabPanel(title="", value="http://harekaplan.github.io/intRo", icon=icon('question-circle')),
    tabPanel(title="", value="http://github.com/harekaplan/intRo", icon=icon("github")),
    navbarMenu("", icon=icon("envelope"),
               tabPanel("Eric Hare"),
               tabPanel("Andee Kaplan")),
    tabPanel(title="hide_me"),
	  tabPanel(title="", icon=icon('code'), value = "javascript:$('#myEditor').slideToggle(); $('.fa-code').parent().parent().toggleClass('active'); $('div.codePrint').toggle()"),
    tabPanel(title="", icon=icon("print"), value = "javascript:print_intRo();"),
    footer=tagList(includeScript("scripts/top-nav-links.js"),
                   includeScript("scripts/print.js")
                  # includeScript("scripts/ggvis-helpers.js")
                   ),
    tags$head(tags$link(rel="shortcut icon", href="images/icon.png"))
))
