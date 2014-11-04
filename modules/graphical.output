intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_histograms(width = input_binwidth) %>% 
        scale_numeric("x", domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("histogram")

    intro.quant %>%
        ggvis(x = ~intro_quant, y = ~intro_x_num) %>%
        layer_points() %>% 
        scale_numeric("x", domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("quantileplot")
    
    intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_points() %>% 
        scale_numeric("x", domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("scatterplot")
    
    intro.plot %>%
        ggvis(x = ~intro_x_num, y = ~intro_y_num) %>%
        layer_lines() %>% 
        scale_numeric("x", domain = input_xdomain, clamp = TRUE, nice = TRUE) %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("linechart")
    
    intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_boxplots() %>% 
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("boxplot")
    
    intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("barchart")
    
    intro.plot %>%
        ggvis(x = ~intro_x_cat, y = ~intro_y_num) %>%
        layer_bars() %>%
        scale_numeric("y", domain = input_ydomain, clamp = TRUE, nice = TRUE) %>%
        bind_shiny("paretochart")

    output$mosaicplot <- renderPlot({
        return(print(mosaicplot(intro.data(), input$x, input$y, intro.numericnames(), intro.categoricnames())))
    })