    observe({
        updateSelectInput(session, "xcont", choices = intro.categoricnames(), selected = ifelse(checkVariable(intro.data(), input$xcont), input$xcont, intro.categoricnames()[1]))
        updateSelectInput(session, "ycont", choices = intro.categoricnames(), selected = ifelse(checkVariable(intro.data(), input$ycont), input$ycont, intro.categoricnames()[2]))
    })
