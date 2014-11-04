ttesttable <- function (data, x, y = NULL, twovar = FALSE, conflevel, althyp, hypval) {
    if (is.null(y) | y == "" | !twovar) {
        ttest <- t.test(data[,x], conf.level=conflevel, alternative=althyp, mu=hypval)
    } else {
        ttest <- t.test(data[,x], data[,y], conf.level=conflevel, alternative=althyp, mu=hypval)
    }
    
    return(paste(capture.output(ttest), collapse = "\n"))
}
