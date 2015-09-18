observe({
    updateNumericInput(session, "randomsubrows", max = nrow(intro.data()))
})

observeEvent(input$clearsubset, {
    updateCheckboxInput(session, "randomsub", value = FALSE)
})

observeEvent(input$savesubset, {
    cat(paste(c("\n", readLines(file.path(userdir, "code_sources.R"))), collapse = "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat("", file = file.path(userdir, "code_sources.R"))
    
    values$data <- values$data_rand
})
