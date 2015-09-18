intro.start <- reactive({
    input$clearsubset
    
    data.initial <- data.module(input$data_own, input$data, input$own)
    values$data <- data.initial
                
    return(data.initial)
})

intro.data <- reactive({
    if (is.null(intro.start())) return(NULL)
        
    intro.data <- values$data
    data.subset <- process_logical(intro.data, input$subs)
    intro.random <- data.subset
        
    values$data <- data.subset
    values$data_rand <- values$data
    
    if (input$randomsub & is.numeric(input$randomsubrows) & input$randomsubrows >= 1 & input$randomsubrows <= nrow(values$data)) {
        interpolate(~(intro.data <- sample_n(df, rows)), df = quote(intro.data), rows = input$randomsubrows, mydir = userdir, file = "code_sources.R")
        cat(paste(c("\n", readLines(file.path(userdir, "code_sources.R"))), collapse = "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    }
    
    return(intro.data)
})

intro.numericnames <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    return(numericNames(intro.data()))
})

intro.categoricnames <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    return(categoricNames(intro.data()))
}) 

dt.options <- reactive({list(pageLength = 10,
                             searching=0,
                             destroy=1,
                             headerCallback =  I(paste0("function(thead, data, start, end, display) {
                                                        //color code the header items
                                                        var col_types = [", 
                                                        paste(paste0("'", ifelse(grepl("factor", whatis(intro.data())$type), "categorical", ifelse(grepl("character", whatis(intro.data())$type), "categorical", "numeric")),"'"),
                                                              collapse=", "),
                                                        "]
                                                        var headers = $(thead).find('th');
                                                        
                                                        for(i = 0; i < col_types.length; i++) {
                                                        if(col_types[i] == 'categorical') headers[i].style.color = '#95a5a6';
                                                        else headers[i].style.color = '#3498db';
                                                        }
                                                        
                                                        if($('.dataTables_length').parent().next().find('span').length == 0) $('.dataTables_length').parent().next().append('<div, style=\"float:right\"><span style=\"color:#95a5a6\">Categorical Variable</span><span style=\"color:#3498db\">     Numeric Variable</span></div>')
}")))})
