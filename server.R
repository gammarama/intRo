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
    valid.datasets <- list(mpg = mpg, airquality = airquality, diamonds = read.csv("data/diamonds_sub.csv"))
    
    ## Source Helper Functions
    source("modules/sources.helper", local=TRUE)
    source("modules/regression.helper", local=TRUE)
    
    ## Source Observes
    source("modules/sources.observe", local=TRUE)
    source("modules/regression.observe", local=TRUE)
    
    ## Source Statics
    source("modules/sources.static", local=TRUE)
    source("modules/regression.static", local=TRUE)
    
    ## Source Reactives
    source("modules/sources.reactive", local=TRUE)
    source("modules/regression.reactive", local=TRUE)
    
    ## Source Outputs
    source("modules/sources.output", local=TRUE)
    source("modules/regression.output", local=TRUE)

})
