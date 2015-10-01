observe({
    updateNumericInput(session, "randomsubrows", max = nrow(intro.data()))
})

observeEvent(input$clearsubset, {
    updateCheckboxInput(session, "randomsub", value = FALSE)
})

observe({
    input$clearsubset;
    values$data <- data.module(input$data_own, input$data, input$own)
})

observeEvent(input$savesubset, {
    updateCheckboxInput(session, "randomsub", value = FALSE)
    cat(paste(readLines(file.path(userdir, "code_sources.R")), "\n", collapse = "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    values$data <- values$data_rand
})
