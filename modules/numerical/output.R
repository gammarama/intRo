    output$summary <- renderPrint({
        intro.inputs <- list("intro.data", input$tblvars, input$grouping)
        get_code(generateSummary, intro.inputs)
        
        intro.inputs[[grep("intro.", intro.inputs)]] <- get(intro.inputs[[grep("intro.", intro.inputs)]])()
        result <- do.call(generateSummary, intro.inputs)
        
        return(result)
    })