shinyUI(fluidPage(
    
    titlePanel("intRo"),
    
    fluidRow(
        
        column(2,
               wellPanel(
                   sliderInput("obs", "Number of observations:",  
                               min = 1, max = 1000, value = 500)
               )       
        ),            
        
        column(4,
               wellPanel(
                   conditionalPanel(
                       condition = "input.own == false",
                       selectInput("data", "Dataset", c("Air Quality" = "airquality", "Cars" = "cars", "Iris" = "iris"), selected = NULL)
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
        
        column(6,
               dataTableOutput("data")
        )
    ),
    
    fluidRow(
        column(12,
            aceEditor("myEditor", "Initial text for editor here", mode="r", theme="ambiance")
        )
    )
))