    output$summary <- renderPrint({
        return(generateSummary(intro.data(), input$tblvars, input$grouping))
    })