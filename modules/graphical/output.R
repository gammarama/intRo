    cat_and_eval("p.histogram <- intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_histograms(width = input_binwidth) %>%
        add_axis('x', title = 'x') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)",  mydir = userdir, env = environment(), file = "code_histogram.R")
    
    p.histogram %>% bind_shiny("histogram")

    cat_and_eval("p.quantileplot <- intro.quant %>%
        ggvis(x = ~intro_quant, y = ~intro_x_num, key := ~id) %>%
        layer_points() %>%
        add_axis('x', title = 'x') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')",  mydir = userdir, env = environment(), file = "code_quantileplot.R")
    
    p.quantileplot %>% bind_shiny("quantileplot")
    
    cat_and_eval("p.scatterplot <- intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num, key := ~id) %>%
        layer_points() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        add_tooltip(function(df) {paste0('row id: ', df$id)}, 'hover')",  mydir = userdir, env = environment(), file = "code_scatterplot.R")
    
    p.scatterplot %>% bind_shiny("scatterplot")
    
    cat_and_eval("p.linechart <- intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_lines() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('x', domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)",  mydir = userdir, env = environment(), file = "code_linechart.R")
    
    p.linechart %>% bind_shiny("linechart")
    
    cat_and_eval("p.boxplot <- intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_boxplots() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)",  mydir = userdir, env = environment(), file = "code_boxplot.R")
    
    p.boxplot %>% bind_shiny("boxplot")
    
    cat_and_eval("p.barchart <- intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)",  mydir = userdir, env = environment(), file = "code_barchart.R")
    
    p.barchart %>% bind_shiny("barchart")
    
    cat_and_eval("p.paretochart <- intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        add_axis('x', title = 'x') %>%
        add_axis('y', title = 'y') %>%
        scale_numeric('y', domain = input_ydomain, clamp = TRUE, nice = TRUE)",  mydir = userdir, env = environment(), file = "code_paretochart.R")
    
    p.paretochart %>% bind_shiny("paretochart")

    output$mosaicplot <- renderPlot({
        return(print(mosaicplot(intro.data(), input$x, input$y, intro.numericnames(), intro.categoricnames())))
    })
    
    output$plotted_vars <- renderText({
        return(helper_text(input$x, input$y, input$plottype))
    })
    