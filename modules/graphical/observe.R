observe({
    input$plottype
    updateSelectizeInput(session, "x", choices = x_choices(), selected = x_selected())
    updateSelectizeInput(session, "y", choices = y_choices(), selected = y_selected())
})