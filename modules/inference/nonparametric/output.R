    output$nonparametrictest <- renderPrint({
        return(nonparametrictest(intro.data(), input$group1_non, input$group2_non, input$conflevel_non, input$althyp_non, input$hypval_non))
    })

