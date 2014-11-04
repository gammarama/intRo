    my.digits <- reactive({
        if (input$conttype %in% c("totalpercs", "rowpercs", "columnpercs")) return(3)
        else return(0)
    })
