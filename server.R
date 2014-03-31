
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(shinyAce)

textStorage <- ""

numericNames <- function(data) {
    str <- unlist(lapply(data, class))
    str <- str[str != "ordered"]
    
    names(data[, which(str %in% c("numeric", "integer"))])
}

shinyServer(function(input, output, session) {
    
    source("modules/data.R")
    source("modules/plot.R")
    
    observe({
        if (input$vars == "onevar") updateSelectInput(session, "plottype", choices = c("Histogram" = "histogram", "Boxplot" = "boxplot1"), selected = "histogram")
    })
    
    observe({
        if (input$vars == "onevar") {
            updateSelectInput(session, "x", choices = numericNames(intro.data()), selected = numericNames(intro.data())[1])
            updateSelectInput(session, "y", choices = numericNames(intro.data()), selected = numericNames(intro.data())[2])
        }
    })
    
    observe({
        if (input$vars == "twovar") updateSelectInput(session, "plottype", choices = c("Scatterplot" = "scatterplot", "Boxplot" = "boxplot2", "Bar Chart" = "barchart", "Pareto Chart" = "paretochart", "Line Chart" = "linechart"), selected = "scatterplot")
    })
    
    observe({
        if (input$vars == "twovar" & input$plottype %in% c("scatterplot")) {
            updateSelectInput(session, "x", choices = numericNames(intro.data()), selected = numericNames(intro.data())[1])
            updateSelectInput(session, "y", choices = numericNames(intro.data()), selected = numericNames(intro.data())[2])
        }
    })
    
    
    intro.data <-reactive({
        data.initial <- data.module(input$data_own, input$data, input$own)
        textStorage <<- paste(textStorage, paste(c(readLines("modules/data.R")), collapse = "\n"), "\n")
        updateAceEditor(session, "myEditor", value=textStorage)
        
        return(data.initial)
    })

    output$data <- renderDataTable({
        return(intro.data())
    }, options = list(iDisplayLength = 10))
    
    output$plot <- renderPlot({
        str.eval <- paste(input$plottype, "(intro.data(), input$x, input$y)", sep = "")
        print(eval(parse(text = str.eval)))
    })
})
