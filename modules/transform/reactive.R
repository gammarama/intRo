    intro.transform.colname <- reactive({
        if (is.null(intro.data())) return(NULL)
        
        curdata <- intro.data()
        curtrans <- input$var_trans
        colname <- ""
        
        if (input$trans == "power") {
            colname <- paste(curtrans, sub("\\.", "", input$power), sep = "_")
        } else if (input$trans %in% c("categorical", "numeric")) {
            colname <- paste(curtrans, "trans", sep = "_")
        }
        
        return(colname)
    })

    intro.transform <- reactive({
        if (is.null(intro.data())) return(NULL)
        
        intro.data <- intro.data()
                        
        if (input$trans == "power" && input$var_trans %in% intro.numericnames()) {
            mypower <- input$power
            if (!is.numeric(mypower) || is.null(mypower)) mypower <- 1
            if (mypower == 0) interpolate(~(trans_x <- log(df$var)), df = quote(intro.data), var = input$var_trans, mydir = userdir, file = "code_transform.R") else interpolate(~(trans_x <- df$var^power), df = quote(intro.data), var = input$var_trans, power = mypower, mydir = userdir, file = "code_transform.R") 
            
            if (all(!is.infinite(trans_x))) interpolate(~(df$col <- trans_x), df = quote(intro.data), col = intro.transform.colname(), mydir = userdir, file = "code_transform.R", append = TRUE)
        } else if (input$trans %in% c("categorical", "numeric")) {
            if (input$trans == "numeric") interpolate(~(trans_x <- as.numeric(df$var)), df = quote(intro.data), var = input$var_trans, mydir = userdir, file = "code_transform.R") else interpolate(~(trans_x <- factor(df$var)), df = quote(intro.data), var = input$var_trans, mydir = userdir, file = "code_transform.R")
            interpolate(~(df$col <- trans_x), df = quote(intro.data), col = intro.transform.colname(), mydir = userdir, file = "code_transform.R", append = TRUE)
        } else {
            interpolate(~(df$col <- df$var), df = quote(intro.data), col = intro.transform.colname(), var = input$var_trans, mydir = userdir, file = "code_transform.R", append = TRUE)        
        }
                
        if (input$savetrans > oldsavetrans) {
            values$mydat <<- intro.data
            cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_transform.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
            
            oldsavetrans <<- input$savetrans
        }
        
        if (is.numeric(intro.data[,input$var_trans])) intro.data$var <- intro.data[,input$var_trans] else intro.data$var <- 0
        if (is.numeric(intro.data[,intro.transform.colname()])) intro.data$trans_var <- intro.data[,intro.transform.colname()] else intro.data$trans_var <- 0
        
        return(intro.data)
    })

