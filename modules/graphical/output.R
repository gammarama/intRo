    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_histograms(width = input_binwidth) %>%
        add_axis('x', title = 'x') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)), 
        mydir = userdir, `_env` = environment(), file = "code_histogram.R") %>%
    bind_shiny("histogram")

    interpolate(~(intro.quant %>%
        ggvis(x = ~intro_quant, y = ~intro_x_num, key := ~id) %>%
        layer_points() %>%
        add_axis('x', title = 'x') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')),  mydir = userdir, `_env` = environment(), file = "code_quantileplot.R") %>%
        bind_shiny("quantileplot")
    
    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num, key := ~id) %>%
        layer_points() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')),  mydir = userdir, `_env` = environment(), file = "code_scatterplot.R") %>% 
        bind_shiny("scatterplot")
    
    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_lines() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)),  mydir = userdir, `_env` = environment(), file = "code_linechart.R") %>% 
        bind_shiny("linechart")
    
    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_boxplots() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)),  mydir = userdir, `_env` = environment(), file = "code_boxplot.R") %>% 
        bind_shiny("boxplot")
    
    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)),  mydir = userdir, `_env` = environment(), file = "code_barchart.R") %>%
    bind_shiny("barchart")
    
    interpolate(~(intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)),  mydir = userdir, `_env` = environment(), file = "code_paretochart.R") %>%
    bind_shiny("paretochart")

    output$mosaicplot <- renderPlot({
        return(print(mosaicplot(intro.data(), input$x, input$y, intro.numericnames(), intro.categoricnames())))
    })
    
    output$plotted_vars <- renderText({
        return(helper_text(input$x, input$y, input$plottype))
    })
    
