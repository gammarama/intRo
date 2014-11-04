    output$ttesttable <- renderText({
        if (!(input$group1 %in% intro.numericnames())) return(NULL)
        
        return(ttesttable(intro.data(), input$group1, input$group2, input$varts == "twovart", input$conflevel, input$althyp, input$hypval))
    })