shinyUI(navbarPage("intRo",
   
    tabPanel("Welcome"),

    fluidRow(

        navlistPanel(widths = c(2, 10),
             "Data",
             tabPanel("Sources",
                  column(4,
                         wellPanel(
                             conditionalPanel(
                                 condition = "input.own == false",
                                 selectInput("data", "Choose Dataset", c("Air Quality" = "airquality", "MPG" = "mpg", "Iris" = "iris", "Diamonds" = "diamonds"), selected = NULL)
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
                                 )
                             )
                      ),
                      
                      column(8,
                             plotOutput("plot")
                      )
             ),
             tabPanel("Numeric")
        )
    ),
    
    hr(),
    
    fluidRow(
        column(12,
           # conditionalPanel(condition = "input.own == false",
                aceEditor("myEditor", "Initial text for editor here", mode="r", readOnly=TRUE, theme="github")
           # )
        )
    )
))