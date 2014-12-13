cat_and_eval("p.regplot <- reg.data %>%
  ggvis(x = ~xreg, y = ~yreg, key := ~test) %>%
  layer_points() %>%
  add_tooltip(function(df) {df$test}, 'hover')",  mydir = userdir, env = environment(), file = "code_regression_ggvis.R")

p.regplot %>% bind_shiny("regplot")
cat("p.regplot\n\n", file = file.path(userdir, "code_regression_ggvis.R"), append = TRUE)

cat_and_eval("p.resplot1 <- reg.resid1 %>%
  ggvis(x = ~x, y = ~residuals, key := ~id) %>%
  layer_points() %>%
  set_options(width = 200, height = 200) %>%
  add_tooltip(function(df) {df$id}, 'hover')",  mydir = userdir, env = environment(), file = "code_regression_ggvis.R", append = TRUE)

p.resplot1 %>% bind_shiny("resplot1")
cat("p.resplot1\n\n", file = file.path(userdir, "code_regression_ggvis.R"), append = TRUE)

cat_and_eval("p.resplot2 <- reg.resid2 %>%
  ggvis(x = ~yy, y = ~residuals, key := ~id) %>%
  layer_points() %>%
  set_options(width = 200, height = 200) %>%
  add_tooltip(function(df) {df$id}, 'hover')",  mydir = userdir, env = environment(), file = "code_regression_ggvis.R", append = TRUE)

p.resplot2 %>% bind_shiny("resplot2")
cat("p.resplot2\n\n", file = file.path(userdir, "code_regression_ggvis.R"), append = TRUE)

cat_and_eval("p.resplot3 <- reg.resid1 %>%
  ggvis(x = ~residuals) %>%
  layer_histograms() %>%
  set_options(width = 200, height = 200)",  mydir = userdir, env = environment(), file = "code_regression_ggvis.R", append = TRUE)

p.resplot3 %>% bind_shiny("resplot3")
cat("p.resplot3\n\n", file = file.path(userdir, "code_regression_ggvis.R"), append = TRUE)

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