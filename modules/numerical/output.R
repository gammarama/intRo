    output$summary <- renderPrint({
        return(generateSummary(intro.data(), input$tblvars, input$grouping, input$store_Numerical > values$store_value))
    })