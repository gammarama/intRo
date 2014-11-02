## Regression Observers
observe({
  updateSelectInput(session, "xreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$xreg), input$xreg, intro.numericnames()[1]))
  updateSelectInput(session, "yreg", choices = intro.numericnames(),  selected = ifelse(checkVariable(intro.data(), input$yreg), input$yreg, intro.numericnames()[2]))
})