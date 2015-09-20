    output$summary_warning <- renderText({
        return("Note: Categorical variables are not included grouped results")
    })

    output$summary <- renderPrint({
        return(generateSummary(intro.data(), input$tblvars, input$grouping, intro.categoricnames()))
    })
