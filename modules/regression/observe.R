## Regression Observers
observe({
    xselect <- ifelse(checkVariable(intro.data(), input$xreg), input$xreg, intro.numericnames()[1])
    yselect <- ifelse(checkVariable(intro.data(), input$yreg), input$yreg, intro.numericnames()[2])
    
    updateSelectizeInput(session, "xreg", choices = setdiff(intro.numericnames(), yselect), selected = xselect)
    updateSelectizeInput(session, "yreg", choices = setdiff(intro.numericnames(), xselect), selected = yselect)
})

observeEvent(input$store_regression, {
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression_reactives.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression_ggvis.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
})

observeEvent(input$saveresid, {
    values$data <- savefit(intro.data(), intro.regression())
})
