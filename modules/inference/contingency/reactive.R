intro.contingency <- reactive({
    if (is.null(intro.data())) return(NULL)
    if (input$xcont == input$ycont || length(categoricNames(intro.data())) < 2) return(NULL)
    
    my.conttable <- cont.table(intro.data(), input$xcont, input$ycont, input$conttype, input$contdigits)
    
    return(my.conttable)
})
