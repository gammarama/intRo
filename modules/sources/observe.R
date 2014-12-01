observe({
    updateNumericInput(session, "randomsubrows", max = nrow(intro.data()))
})

observeEvent(input$clearsubset, {
    updateCheckboxInput(session, "randomsub", value = FALSE)
})
