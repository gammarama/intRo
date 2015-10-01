    output$var_trans_text <- renderText({
        if (is.null(intro.transform())) return(NULL)
        
        return(paste("Selected Variable:", input$var_trans))
    })

    intro.transform %>%
        ggvis(x = ~intro_var) %>%
        layer_histograms(width = input_original_binwidth) %>%
        set_options(width = 600, height = 250) %>%
        bind_shiny("var_plot")

    intro.transform %>%
        ggvis(x = ~intro_trans_var) %>%
        layer_histograms(width = input_trans_binwidth) %>%
        set_options(width = 600, height = 250) %>%
        bind_shiny("trans_plot")
