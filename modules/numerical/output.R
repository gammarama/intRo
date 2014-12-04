    output$summary <- renderPrint({
        return(generateSummary(intro.data(), input$tblvars, input$grouping, input$store_numerical > values$store_value))
    })