cont.table <- function(data, x, y) {  
    if (x %in% names(data) & y %in% names(data)) {
        my.tbl <- table(data[,y], data[,x])
        
        totalsum <- sum(my.tbl)
        
        my.tbl <- rbind(my.tbl, Total = colSums(my.tbl, na.rm = TRUE))
        my.tbl <- cbind(my.tbl, Total = c(rowSums(my.tbl[-(nrow(my.tbl)), ], na.rm = TRUE), totalsum))
        
        return(my.tbl)
    } else {
        return(NULL)
    }
}
