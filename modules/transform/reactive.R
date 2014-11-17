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
                        
        curdata <- intro.data()
        curtrans <- input$var_trans
                
        if (input$trans == "power" & curtrans %in% intro.numericnames()) {
            trans_x <- if (!is.numeric(input$power) | is.null(input$power)) curdata[,curtrans] else if (input$power == 0) log(curdata[,curtrans]) else (curdata[,curtrans])^(input$power)
            if (all(!is.infinite(trans_x))) {
                curdata[, intro.transform.colname()] <- trans_x
            }
        } else if (input$trans %in% c("categorical", "numeric")) {
            trans_x <- if (input$trans == "numeric") as.numeric(curdata[,curtrans]) else factor(curdata[,curtrans])
            curdata[, intro.transform.colname()] <- trans_x
        } else {
            curdata[, intro.transform.colname()] <- curtrans
        }
                
        if (input$savetrans > oldsavetrans) {
            values$mydat <<- curdata
            oldsavetrans <<- input$savetrans
        }
        
        if (is.numeric(curdata[,curtrans])) curdata$var <- curdata[,curtrans] else curdata$var <- 0
        if (is.numeric(curdata[,intro.transform.colname()])) curdata$trans_var <- curdata[,intro.transform.colname()] else curdata$trans_var <- 0
        
        return(curdata)
    })

