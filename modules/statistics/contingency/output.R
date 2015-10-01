    output$conttable <- renderTable({
        return(intro.contingency())
    })
