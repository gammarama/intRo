    observe({
        updateSelectizeInput(session, "grouping", choices = c("None" = "none", names(intro.data())))
        updateSelectizeInput(session, "tblvars", choices = names(intro.data()))
    })
