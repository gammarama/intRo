library(shiny)
library(shinyAce)

shinyUI(
navbarPage("intRo", id="top-nav",  theme = "bootstrap.min.css",
    tabPanel(title="", icon=icon("home"),
       fluidRow(
         
         navlistPanel(id = "side-nav", widths = c(2, 10),
                      "Data",
                      tabPanel("Sources",
                               column(4,
                                      wellPanel(
                                        conditionalPanel(
                                          condition = "input.own == false",
                                          selectInput("data", "Choose Dataset", c("MPG" = "mpg", "Air Quality" = "airquality", "Diamonds" = "diamonds"), selected = "MPG")
                                        ),
                                        conditionalPanel(
                                          condition = "input.own == true",
                                          fileInput('data_own', 'Choose CSV File',
                                                    accept=c('text/csv', 
                                                             'text/comma-separated-values,text/plain', 
                                                             '.csv'))
                                        ),
                                        checkboxInput("own", "Upload Dataset")
                                      )
                               ),
                               
                               column(8,
                                      dataTableOutput("data")
                               )
                      ),
                      "-----",
                      "Summaries",
                      tabPanel("Graphical",
                               column(4,
                                      wellPanel(
                                        radioButtons("vars", "Type", choices=c("One Variable" = "onevar", "Two Variables" = "twovar")),
                                        
                                        hr(),
                                        
                                        selectInput("plottype", "Plot Type", choices = NULL),
                                        
                                        hr(),
                                        
                                        selectInput("x", "Independent Variable (x)", choices = NULL),
                                        conditionalPanel(
                                          condition = "input.vars == 'twovar'",
                                          selectInput("y", "Dependent Variable (y)", choices = NULL)
                                        ),
                                        
                                        conditionalPanel(
                                            condition = "input.plottype == 'barchart' || input.plottype == 'paretochart'",
                                            radioButtons("bartype", "Y Variable Type", choices = c("Count" = "length", "Sum" = "sum", "Mean" = "mean", "Median" = "median"))
                                        )
                                      )
                               ),
                               
                               column(8,
                                     plotOutput("plot"),
                                     fluidRow(
                                         column(8,
                                            h4("Plot Options"),
                                            conditionalPanel(
                                                condition = "input.plottype == 'histogram'",
                                                numericInput("binwidth", "Bin Width", value = 1, step=0.01)
                                            )
                                         )
                                     )
                               )
                      ),
                      tabPanel("Numeric",
                               column(4,
                                      wellPanel(
                                        checkboxGroupInput("tblvars", "Select Variables", choices = list("hi"))
                                      )
                               ),
                               
                               column(8,
                                      tableOutput("summary")
                               )
                      ),
                      "-----",
                      "Statistics",
                      tabPanel("Regression",
                               column(4,
                                      wellPanel(
                                          selectInput("xreg", "Independent Variable (x)", choices = NULL),
                                          selectInput("yreg", "Dependent Variable (y)", choices = NULL)
                                      )
                               ),
                               
                               column(8,
                                      tags$b("Parameter Estimates"),
                                      tableOutput("regtable"),
                                      hr(),
                                      tags$b("Plot of Fit"),
                                      plotOutput("regplot")
                               )
                      ),
                      tabPanel("t-Test",
                               column(4,
                                      wellPanel(
                                          radioButtons("varts", "Type", choices=c("One Variable" = "onevart", "Two Variables" = "twovart")),

                                          hr(),
                                          
                                          selectInput("group1", "Group 1 (x)", choices = NULL),
                                          conditionalPanel(
                                              condition = "input.varts == 'twovart'",
                                              selectInput("group2", "Group 2 (y)", choices = NULL)
                                          )
                                      )
                               ),
                               
                               column(8,
                                      tags$b("t-Test Results"),
                                      verbatimTextOutput("ttesttable")
                               )
                      )
         )
       ),
              
       hr(),
       
       fluidRow(
         column(12,
                aceEditor("myEditor", "Initial text for editor here", mode="r", readOnly=TRUE, theme="chrome")
         )
       )       
             
             
             ),
    tabPanel(title="", value="http://harekaplan.github.io/intRo", icon=icon('question-circle')),
    tabPanel(title="", value="http://github.com/harekaplan/intRo", icon=icon("github")),
    navbarMenu("", icon=icon("envelope"),
               tabPanel("Eric Hare"),
               tabPanel("Andee Kaplan")),
	tabPanel(title="", icon=icon('code'), value = "javascript:$('#myEditor').slideToggle(); $('.fa-code').parent().parent().toggleClass('active');"),
    tabPanel(title="", icon=icon("print"), value = "javascript:window.print()"),
    footer=includeScript("scripts/top-nav-links.js")
))
