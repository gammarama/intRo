intro.regression <- reactive({
  if (is.null(intro.data())) return(NULL)
  if (input$xreg == input$yreg || length(numericNames(intro.data())) < 2) return(NULL)

  lm.fit <- my.lm(intro.data(), input$xreg, input$yreg)
  
  return(lm.fit)
})

reg.data <- reactive({
  if (is.null(intro.regression())) return(NULL)
  
  return(my_regdata(intro.data(), input$xreg, input$yreg))
})

reg.resid1 <- reactive({
  if (is.null(intro.regression())) return(NULL)
    
  return(my_regresid1(intro.data(), intro.regression(), input$xreg))
})

reg.resid2 <- reactive({
  if (is.null(intro.regression())) return(NULL)
  
  return(my_regresid2(intro.data(), intro.regression()))
})
