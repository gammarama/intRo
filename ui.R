addResourcePath(prefix="images", directoryPath="images/")

## Source Regression ui
source('modules/regression.ui', local=TRUE)

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
                                                                 selectInput("data", "Choose Dataset", c("MPG" = "mpg", "Air Quality" = "airquality", "Diamonds" = "diamonds"))
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
                                                                                  column(6, numericInput("randomsubrows", "Rows", value = 1, min = 1))
                                                                 )
                                                             ),
                                                             tags$button("", id = "savesubset", type = "button", class = "btn action-button", onclick="var vals = []; var subsets = $('input[type = \"text\"][placeholder]'); for(i = 0; i < subsets.length; i++) {vals.push(subsets[i].value);}; Shiny.onInputChange(\"subs\", vals); $('#side-nav :contains(\"Sources\")').highlight();", list(icon("save"), "Save Subset")),
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
                                         
                                         "-----",
                                         "Statistics",
                                         reg_ui
                            )
                        )     
               ),
               tabPanel(title="", value="http://harekaplan.github.io/intRo", icon=icon('question-circle')),
               tabPanel(title="", value="http://github.com/harekaplan/intRo", icon=icon("github")),
               navbarMenu("", icon=icon("envelope"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title="hide_me"),
               tabPanel(title="", icon=icon("print"), value = "javascript:print_intRo();"),
               footer=tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("http://code.jquery.com/color/jquery.color-2.1.2.min.js"),
                              includeScript("scripts/other-helpers.js")
               ),
               tags$head(tags$link(rel="shortcut icon", href="images/icon.png"))
    ))
