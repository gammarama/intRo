
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Data Module"),
    
    # Sidebar with a slider input for number of observations
    sidebarPanel(
        radioButtons("data_flag", "Select Data", c("Built In", "Your Own"), selected = NULL),
        
        conditionalPanel(
            condition = "input.data_flag == 'Built In'",
            radioButtons("data_built", "Pick a Dataset", c("Cars" = "cars", "Air Quality" = "airquality"), selected = NULL)
        ),
        
        conditionalPanel(
            condition = "input.data_flag == 'Your Own'",
            fileInput('data_own', 'Choose CSV File',
                      accept=c('text/csv', 
                               'text/comma-separated-values,text/plain', 
                               '.csv'))
        )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        tableOutput("data")
    )
))
