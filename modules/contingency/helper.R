cont.table <- function(data, x, y, type, digits) {  
    if (x %in% names(data) & y %in% names(data)) {
        my.tbl <- table(data[,y], data[,x])
        
        totalsum <- sum(my.tbl)
        
        my.tbl <- rbind(my.tbl, Total = colSums(my.tbl, na.rm = TRUE))
        my.tbl <- cbind(my.tbl, Total = c(rowSums(my.tbl[-(nrow(my.tbl)), ], na.rm = TRUE), totalsum))
        
        if (type == "totalpercs") my.tbl <- my.tbl / totalsum
        if (type == "rowpercs") {
            my.tbl <- t(apply(my.tbl[-nrow(my.tbl),], 1, function(row){row / row[ncol(my.tbl)]}))
            #my.tbl <- rbind(my.tbl, Total = colSums(my.tbl, na.rm = TRUE))
        }
        if (type == "columnpercs") {
            my.tbl <- apply(my.tbl[,-ncol(my.tbl)], 2, function(col){col / col[nrow(my.tbl)]})
            #my.tbl <- cbind(my.tbl, Total = rowSums(my.tbl, na.rm = TRUE))
        }
        
        new.digits <- if (type %in% c("totalpercs", "rowpercs", "columnpercs")) digits else 0
        return.tbl <- round(my.tbl, digits = new.digits)
        
        return(format(return.tbl))
    } else {
        return(NULL)
    }
}
