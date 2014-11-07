    output$ttesttable <- renderText({
        if (!(input$group1 %in% intro.numericnames())) return(NULL)
        
        intro.inputs <- list(intro.data(), input$group1, input$group2, input$varts == "twovart", input$conflevel, input$althyp, input$hypval)
        save(intro.inputs, file = "lol")
        
        var <- as.list(formals(ttesttable))
        for (i in 1:length(var)) var[[i]] <- intro.inputs[[i]]
        
        return(do.call(ttesttable, intro.inputs))
    })