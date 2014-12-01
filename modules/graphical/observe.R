observe({
    input$plottype
    updateSelectizeInput(session, "x", choices = x_choices(), selected = x_selected())
    updateSelectizeInput(session, "y", choices = y_choices(), selected = y_selected())
})

observeEvent(input$store_graphical, {
    cat(paste0("\n", paste(readLines(file.path(tempdir(), "code_graphical_reactive.R")), collapse = "\n")), file = file.path(tempdir(), "code_All.R"), append = TRUE)
    cat(paste0("p.", input$plottype), file = file.path(tempdir(), paste0("code_", input$plottype, ".R")), append = TRUE)
    cat("\n", file = file.path(tempdir(), paste0("code_", input$plottype, ".R")), append = TRUE)
    cat(paste0("\n", paste(readLines(file.path(tempdir(), paste0("code_", input$plottype, ".R"))), collapse = "\n")), file = file.path(tempdir(), "code_All.R"), append = TRUE)
})
