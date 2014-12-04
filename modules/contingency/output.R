    output$conttable <- renderTable({
        return(cont.table(intro.data(), input$xcont, input$ycont, input$conttype, input$contdigits))
    })
