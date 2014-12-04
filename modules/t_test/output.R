    output$ttesttable <- renderText({
        if (!(input$group1 %in% intro.numericnames())) return(NULL)
        
        intro.inputs <- list("intro.data", input$group1, input$group2, input$varts == "twovart", input$conflevel, input$althyp, input$hypval)
        get_code(ttesttable, intro.inputs)
        
        intro.inputs[[grep("intro.", intro.inputs)]] <- get(intro.inputs[[grep("intro.", intro.inputs)]])()        
        ttest.val <- do.call(ttesttable, intro.inputs)
        
        return(paste(capture.output(ttest.val), collapse = "\n"))
    })