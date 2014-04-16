summarytable <- function(data, tblvars) {
    if (is.null(tblvars)){
        return(NULL)    
    }
    else if (length(tblvars) == 1) {
        val <- summary(data[,tblvars])
        df <- data.frame(paste(names(val), " : ", as.numeric(val)))
        colnames(df) <- tblvars
        
        return(df)
    } else {
        val <- summary(data[,tblvars])
        return(val)
    }
}
