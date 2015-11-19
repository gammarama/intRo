diamonds <- read.csv("data/diamonds_sub.csv")
super_bowl_salaries <- read.csv("data/superbowl-salaries.csv")

process_logical <- function(data, x) {
    if (is.null(x) || all(lapply(x, nchar) == 0)) return(data)
    
    relevant_cols <- names(data)[nchar(x) > 0]
    if (length(relevant_cols) == 0) return(data)
    
    my_strs <- strsplit(gsub(",", " , ", x), split = ",")
    new_strs <- my_strs[unlist(lapply(my_strs, length)) > 0]
    
    new_data <- data
    if (length(new_strs) > 0) {
        for (i in 1:length(new_strs)) {
            test <- new_strs[[i]]
            col <- relevant_cols[i]
            
            subset_str <- paste0("subset(new_data, ", paste(col, ifelse(length(grep("[<>]", test)) > 0, "", "=="), test), ")")
            
            result <- try(eval(parse(text = subset_str)), silent = TRUE)
            if (inherits(result, "try-error")) result <- eval(parse(text = gsub(test, paste0("'", test, "'"), subset_str)))
            
            new_data <- result
        }
    }
    
    return(new_data)
}

read.csv <- function (path) {
    return(utils::read.csv(input$data_own[,"datapath"]))
}

data.module <- function (inFile, dataset, own) {   
    cat("\n", file = file.path(userdir, "code_All.R"), append = TRUE)
    if (is.null(inFile) | !own) {
        interpolate(~(intro.data <- get(dat)), dat = dataset, file = "code_sources.R", mydir = userdir, append = FALSE, save_result = TRUE)
    } else {
        interpolate(~(intro.data <- read.csv(data)), data = input$data_own[,"name"], file = "code_sources.R", mydir = userdir, append = FALSE, save_result = TRUE)
    }
    return(intro.data)
}
