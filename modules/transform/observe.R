    ## Transform Observers
    observe({
        updateSelectInput(session, "var_trans", choices = (if (input$trans %in% c("power", "categorical")) intro.numericnames() else intro.categoricnames()))
    })
