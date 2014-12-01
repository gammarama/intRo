## Regression Observers
observe({
  updateSelectizeInput(session, "xreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$xreg), input$xreg, intro.numericnames()[1]))
  updateSelectizeInput(session, "yreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$yreg), input$yreg, intro.numericnames()[2]))
})

observeEvent(input$store_regression, {
    cat(paste(readLines(file.path(tempdir(), "code_regression.R")), collapse = "\n"), file = file.path(tempdir(), "code_All.R"), append = TRUE)
    cat(paste(readLines(file.path(tempdir(), "code_regression_ggvis.R")), collapse = "\n"), file = file.path(tempdir(), "code_All.R"), append = TRUE)
})
