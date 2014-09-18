require(YaleToolkit)

summarytable <- function (data, tblvars) {
    if (is.null(tblvars)){
        return(NULL)    
    }
    else if (length(tblvars) == 1) {
        val <- summary(data[,tblvars])
        df <- data.frame(paste(names(val), " : ", as.numeric(val)))
        df[,1] <- as.character(df[,1])
        
        if (is.numeric(data[,tblvars])) df[7,] <- paste0("SD.    :", round(sd(data[,tblvars]), digits = 3))
        
        colnames(df) <- tblvars
        
        return(df)
    } else {
        newdata <- data[,tblvars]
        numeric_cols <- which(whatis(newdata)$type == "numeric")
        
        val <- summary(newdata, digits = 3)
        if (length(numeric_cols) > 0) {
            if (nrow(val) >= 7) {
                val[7,numeric_cols] <- paste0("SD.    :", round(apply(data.frame(newdata[,numeric_cols]), 2, sd), 3))
            } else {
                vec <- rep(NA, ncol(val))
                vec[numeric_cols] <- paste0("SD.    :", round(apply(newdata[,numeric_cols], 2, sd), 3))
                val <- rbind(val, vec)
            }
        }
        
        return(val)
    }
}
