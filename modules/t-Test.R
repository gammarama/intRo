ttesttable <- function (data, x, y = NULL, twovar = FALSE) {
    if (is.null(y) | y == "" | !twovar) {
        ttest <- t.test(data[,x])
    } else {
        ttest <- t.test(data[,x], data[,y])
    }
    
    return(paste(capture.output(ttest), collapse = "\n"))
}
