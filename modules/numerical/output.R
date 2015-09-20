    output$summary_warning <- renderText({
        return("Note: Categorical variables are not included in results when numeric variables are selected")
    })

    output$summary <- renderPrint({
        return(generateSummary(intro.data(), input$tblvars, input$grouping, intro.categoricnames()))
    })
