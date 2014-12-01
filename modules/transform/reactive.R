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
        
        cat_and_eval(paste0("curtrans <- '", input$var_trans, "'"), env = environment(), file = "code_transform.R")
                
        if (input$trans == "power" & curtrans %in% intro.numericnames()) {
            if (!is.numeric(input$power) | is.null(input$power)) cat_and_eval(paste0("trans_x <- intro.data[,'", curtrans, "']"), file = "code_transform.R", append = TRUE) else if (input$power == 0) cat_and_eval(paste0("trans_x <- log(intro.data[,'", curtrans, "'])"), file = "code_transform.R", append = TRUE) else cat_and_eval(paste0("trans_x <- (intro.data[,'", curtrans, "'])^", input$power), file = "code_transform.R", append = TRUE)
            if (all(!is.infinite(trans_x))) {
                cat_and_eval(paste0("intro.data[, '", intro.transform.colname(), "'] <- trans_x"), file = "code_transform.R", append = TRUE)
            }
        } else if (input$trans %in% c("categorical", "numeric")) {
            if (input$trans == "numeric") cat_and_eval(paste0("trans_x <- as.numeric(intro.data[,'", curtrans, "'])"), file = "code_transform.R", append = TRUE) else cat_and_eval(paste0("trans_x <- factor(intro.data[,'", curtrans, "'])"), file = "code_transform.R", append = TRUE)
            cat_and_eval(paste0("intro.data[, '", intro.transform.colname(), "'] <- trans_x"), file = "code_transform.R", append = TRUE)
        } else {
            cat_and_eval(paste0("intro.data[, '", intro.transform.colname(), "'] <- curtrans"), file = "code_transform.R", append = TRUE)
        }
                
        if (input$savetrans > oldsavetrans) {
            values$mydat <<- intro.data
            cat(paste0("\n\n", paste(readLines(file.path(tempdir(), "code_transform.R")), collapse = "\n")), file = file.path(tempdir(), "code_All.R"), append = TRUE)
            
            oldsavetrans <<- input$savetrans
        }
        
        if (is.numeric(intro.data[,curtrans])) intro.data$var <- intro.data[,curtrans] else intro.data$var <- 0
        if (is.numeric(intro.data[,intro.transform.colname()])) intro.data$trans_var <- intro.data[,intro.transform.colname()] else intro.data$trans_var <- 0
        
        return(intro.data)
    })

