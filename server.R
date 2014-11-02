###
### Global Helper Functions
###

checkVariable <- function(data, var) {
    return(nchar(var) > 0 & var %in% names(data))
}

my.summary <- function(x) {
    return(c(summary(x), "SD" = sd(x, na.rm = TRUE)))
}

process_logical <- function(data, x) {
    if (is.null(x)) {
        return(data)
    }
    
    relevant_cols <- names(data)[nchar(x) > 0]
    if (length(relevant_cols) == 0) return(data)
    
    my_strs <- strsplit(gsub(",", " , ", x), split = ",")
    new_strs <- my_strs[unlist(lapply(my_strs, length)) > 0]
    
    new_data <- data
    if (length(new_strs) > 0) {
        for (i in 1:length(new_strs)) {
            test <- new_strs[[i]]
            col <- relevant_cols[i]
            
            subset_str <- ""
            if (length(test) == 1) {
                if (is.na(as.numeric(test[1]))) {
                    subset_str <- paste0("'", test[1], "' == ", col)
                } else {
                    subset_str <- paste(test[1], "==", col)
                }
            } else {
                test[1] <- ifelse(test[1] == " ", -Inf, test[1])
                test[2] <- ifelse(test[2] == " ", Inf, test[2])
                if (is.na(test[2])) test[2] <- Inf
                
                subset_str <- paste(test[1], "<=", col, "&", col, "<=", test[2])
            }          
            
            new_data <- eval(parse(text = paste0("subset(new_data, ", subset_str, ")")))
        }
    }
    
    return(new_data)
}

###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    values <- reactiveValues(firstrun = TRUE, mydat = NULL, mydat_rand = NULL)
    
    sourceDir <- function(path, ...) { for (nm in list.files(path, pattern = "\\.[Rr]$")) { source(file.path(path, nm), ...) } }
    #sourceDir("modules")
    
    valid.datasets <- list(mpg = mpg, airquality = airquality, diamonds = read.csv("data/diamonds_sub.csv"))


    ## Source Regression Observes
    source('modules/regression.observe', local=TRUE)
    
    ## Other Input Observers
    observe({
        updateNumericInput(session, "randomsubrows", max = nrow(intro.data()))
        updateCheckboxGroupInput(session, "tblvars", choices = names(intro.data()))
    })
    
    
    ## Static vars for buttons
    oldval <- 0    
    oldsavesub <- 0
    
    ## Source Regression Statics
    source('modules/regression.static', local=TRUE)

    
    ###
    ### Reactive data
    ###
    intro.start <- reactive({
        input$clearsubset

        data.initial <- data.module(input$data_own, valid.datasets[[input$data]], input$own)
        
        if (values$firstrun) {
            values$firstrun <- FALSE
        }
                
        values$mydat <<- data.initial
                
        return(data.initial)
    })
    
    intro.data <- reactive({
        if (is.null(intro.start())) return(NULL)
        
        data.subset <- process_logical(values$mydat, input$subs)
        values$mydat <<- data.subset
        values$mydat_rand <<- values$mydat
        
        if (input$randomsub & is.numeric(input$randomsubrows) & input$randomsubrows >= 1 & input$randomsubrows <= nrow(values$mydat)) {
            values$mydat_rand <<- dplyr::sample_n(values$mydat, input$randomsubrows)
        }
        
        if (input$savesubset > oldsavesub) {
            values$mydat <<- values$mydat_rand
            oldsavesub <<- input$savesubset
        }
        
        return(values$mydat)
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
    
    ## Source Regression reactives
    source('modules/regression.reactive', local=TRUE)
    
    

    ###
    ### Outputs
    ###
    output$data <- renderDataTable({  
      return(intro.data())
    }, options = dt.options)
    
    output$downloaddata <- downloadHandler(
        filename = function() { paste0("intro_data_", today(), ".csv") },
        content = function(file) {
            write.csv(intro.data(), file)
        }
    )
    
    ## Source Regression outputs
    source('modules/regression.output', local=TRUE)
    
    

})
