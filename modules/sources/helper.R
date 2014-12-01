process_logical <- function(data, x) {
    if (is.null(x) || x == "c('')") {
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

data.module <- function (inFile, dataset, own) {        
    if (is.null(inFile) | !own) {
        cat_and_eval(paste0("intro.data <- get('", dataset, "')"), file = "code_sources.R", mydir = userdir, append = FALSE, save_result = TRUE)
    } else {
        cat_and_eval(paste0("intro.data <- read.csv(", inFile[,"datapath"], ")"), file = "code_sources.R", append = FALSE, save_result = TRUE)
    }
    return(intro.data)
}