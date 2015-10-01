    output$ttesttable <- renderText({
        return(paste(capture.output(ttesttable(intro.data(), input$group1, input$group2, input$varts == "twovart", input$conflevel, input$althyp, input$hypval)), collapse = "\n"))
    })
