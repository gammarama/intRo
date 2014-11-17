observe({
    input$plottype
    updateSelectizeInput(session, "x", choices = x_choices(), selected = x_selected())
    updateSelectizeInput(session, "y", choices = y_choices(), selected = y_selected())
})

observeEvent(input$store_Graphical, {
    cat(paste0("p.", input$plottype), file = paste0("code_", input$plottype, ".R"), append = TRUE)
    cat("\n\n", file = paste0("code_", input$plottype, ".R"), append = TRUE)
    cat(paste(readLines(paste0("code_", input$plottype, ".R")), collapse = "\n"), file = "code_All.R", append = TRUE)
})
