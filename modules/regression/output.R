cat_and_eval("p.regplot <- reg.data %>%
  ggvis(x = ~xreg, y = ~yreg) %>%
  layer_points() %>%
  layer_model_predictions(model = 'lm')", env = environment(), file = "code_regression.R")

p.regplot %>% bind_shiny("regplot")

cat_and_eval("p.resplot1 <- reg.resid1 %>%
  ggvis(x = ~x, y = ~residuals) %>%
  layer_points() %>%
  set_options(width = 200, height = 200)", env = environment(), file = "code_regression.R", append = TRUE)

p.resplot1 %>% bind_shiny("resplot1")

cat_and_eval("p.resplot2 <- reg.resid2 %>%
  ggvis(x = ~yy, y = ~residuals) %>%
  layer_points() %>%
  set_options(width = 200, height = 200)", env = environment(), file = "code_regression.R", append = TRUE)

p.resplot2 %>% bind_shiny("resplot2")

cat_and_eval("p.resplot3 <- reg.resid1 %>%
  ggvis(x = ~residuals) %>%
  layer_histograms() %>%
  set_options(width = 200, height = 200)", env = environment(), file = "code_regression.R", append = TRUE)

p.resplot3 %>% bind_shiny("resplot3")

output$regtable <- renderTable({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(tablereg(intro.regression(), input$xreg))
})

output$r <- renderText({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(r(intro.data(), input$xreg, input$yreg))
})

output$r2 <- renderText({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(r2(intro.regression()))
})