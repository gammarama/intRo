## Regression Observers
observe({
  updateSelectizeInput(session, "xreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$xreg), input$xreg, intro.numericnames()[1]))
  updateSelectizeInput(session, "yreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$yreg), input$yreg, intro.numericnames()[1]))
})

observeEvent(input$store_regression, {
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression_reactives.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression_ggvis.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
})

observeEvent(input$saveresid, {
    values$mydat <<- savefit(intro.data(), intro.regression())
})
