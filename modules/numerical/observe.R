    observe({
        updateSelectInput(session, "grouping", choices = c("None" = "none", names(intro.data())))
        updateCheckboxGroupInput(session, "tblvars", choices = names(intro.data()))
    })
