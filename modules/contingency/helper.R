cont.table <- function(intro.data, x, y, type, digits) {  
    if (x %in% names(intro.data) & y %in% names(intro.data)) {
        cat_and_eval(paste0("
            my.tbl <- table(intro.data[,'", y, "'], intro.data[,'", x, "'])
        
            totalsum <- sum(my.tbl)
            
            my.tbl <- rbind(my.tbl, Total = colSums(my.tbl, na.rm = TRUE))
            my.tbl <- cbind(my.tbl, Total = c(rowSums(my.tbl[-(nrow(my.tbl)), ], na.rm = TRUE), totalsum))
        "), env = environment(), file = "code_Contingency.R")

        if (type == "totalpercs") cat_and_eval("my.tbl <- my.tbl / totalsum", env = environment(), file = "code_Contingency.R", append = TRUE)
        if (type == "rowpercs") {
            cat_and_eval("my.tbl <- t(apply(my.tbl[-nrow(my.tbl),], 1, function(row){row / row[ncol(my.tbl)]}))", env = environment(), file = "code_Contingency.R", append = TRUE)
        }
        if (type == "columnpercs") {
            cat_and_eval("my.tbl <- apply(my.tbl[,-ncol(my.tbl)], 2, function(col){col / col[nrow(my.tbl)]})", env = environment(), file = "code_Contingency.R", append = TRUE)
        }
        
        cat_and_eval(paste0("
            new.digits <- if ('", type, "' %in% c('totalpercs', 'rowpercs', 'columnpercs')) digits else 0
            return.tbl <- format(round(my.tbl, digits = new.digits))
        
            return.tbl
        "),  env = environment(), file = "code_Contingency.R", append = TRUE)
    } else {
        return(NULL)
    }
}
