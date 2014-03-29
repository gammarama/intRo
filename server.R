
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
    
    intro.data <-reactive({
        # input$data_own will be NULL initially. After the user selects
        # and uploads a file, it will be a data frame with 'name',
        # 'size', 'type', and 'datapath' columns. The 'datapath'
        # column will contain the local filenames where the data can
        # be found.
        
        inFile <- input$data_own
        
        intro.data <- NULL
        if (is.null(inFile) | input$own == FALSE) {
            intro.data <- eval(parse(text = input$data))
        } else {
            intro.data <- read.csv(inFile$datapath)
        }
        
        intro.data
    })
    
    output$data <- renderTable({
        return(intro.data())
    })
})
