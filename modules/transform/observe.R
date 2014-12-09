    ## Transform Observers
    observe({
        updateSelectizeInput(session, "var_trans", choices = (if (input$trans %in% c("power", "categorical")) intro.numericnames() else intro.categoricnames()))
    })
    
    observe({
        updateSelectizeInput(session, "trans", choices = (if (numericNames(intro.data())[1] == "") c("Numeric" = "numeric") else if (categoricNames(intro.data())[1] == "") c("Power" = "power", "Categorical" = "categorical") else c("Power" = "power", "Categorical" = "categorical", "Numeric" = "numeric")))
    })
