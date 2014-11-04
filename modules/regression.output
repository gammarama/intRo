reg.data %>%
  ggvis(x = ~xreg, y = ~yreg) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm") %>% 
  bind_shiny("regplot")

reg.resid1 %>%
  ggvis(x = ~x, y = ~residuals) %>%
  layer_points() %>%
  set_options(width = 200, height = 200) %>% 
  bind_shiny("resplot1")

reg.resid2 %>%
  ggvis(x = ~yy, y = ~residuals) %>%
  layer_points() %>%
  set_options(width = 200, height = 200) %>% 
  bind_shiny("resplot2")

reg.resid1 %>%
  ggvis(x = ~residuals) %>%
  layer_histograms() %>%
  set_options(width = 200, height = 200) %>%
  bind_shiny("resplot3")

output$regtable <- renderTable({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(tablereg(intro.data(), input$xreg, input$yreg, intro.regression()))
})

output$r <- renderText({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(r(intro.data(), input$xreg, input$yreg, intro.regression()))
})

output$r2 <- renderText({
  if (!(input$xreg %in% intro.numericnames()) | !(input$yreg %in% intro.numericnames())) return(NULL)
  
  return(r2(intro.data(), input$xreg, input$yreg, intro.regression()))
})