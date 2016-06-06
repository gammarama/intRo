interpolate(
    ~(reg.data %>%
        ggvis(x = ~xreg, y = ~yreg) %>%
        layer_points(key := ~id) %>%
        layer_model_predictions(model = 'lm') %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')),
    mydir = userdir,
    `_env` = environment(),
    file = "code_regression_ggvis.R"
) %>% bind_shiny("regplot")

interpolate(
    ~(reg.resid1 %>%
        ggvis(x = ~myx, y = ~residuals, key := ~id) %>%
        layer_points() %>%
        set_options(width = 200, height = 200) %>%
        add_axis('x', title = 'x') %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')),
    mydir = userdir,
    `_env` = environment(),
    file = "code_regression_ggvis.R",
    append = TRUE
) %>% bind_shiny("resplot1")

interpolate(
    ~(reg.resid2 %>%
        ggvis(x = ~yy, y = ~residuals, key := ~id) %>%
        layer_points() %>%
        set_options(width = 200, height = 200) %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')),
    mydir = userdir,
    `_env` = environment(),
    file = "code_regression_ggvis.R",
    append = TRUE
) %>% bind_shiny("resplot2")

interpolate(
    ~(reg.resid1 %>%
        ggvis(x = ~residuals) %>%
        layer_histograms() %>%
        set_options(width = 200, height = 200)),
    mydir = userdir,
    `_env` = environment(),
    file = "code_regression_ggvis.R",
    append = TRUE
) %>% bind_shiny("resplot3")

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
