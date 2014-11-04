observe({
    updateNumericInput(session, "randomsubrows", max = nrow(intro.data()))
    updateCheckboxGroupInput(session, "tblvars", choices = names(intro.data()))
})