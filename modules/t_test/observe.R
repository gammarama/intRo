    observe({
        updateSelectInput(session, "group1", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group1), input$group1, intro.numericnames()[1]))
        updateSelectInput(session, "group2", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group2), input$group2, intro.numericnames()[2]))
    })
