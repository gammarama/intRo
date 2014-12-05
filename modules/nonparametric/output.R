    output$nonparametrictable <- renderText({
        return(paste(capture.output(nonparametrictable(intro.data(), input$group1_non, input$group2_non, input$conflevel_non, input$althyp_non, input$hypval_non)), collapse = "\n"))
    })

