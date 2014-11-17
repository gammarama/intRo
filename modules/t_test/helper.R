ttesttable <- function (intro.data, x, y = NULL, twovar = FALSE, conflevel, althyp, hypval) {
    if (is.null(y) | y == "" | !twovar) {
        cat_and_eval(paste0("t.test(x=intro.data[,'", x, "'], conf.level=", conflevel, ", alternative='", althyp, "', mu=", hypval, ")"), env = environment(), file = "code_t_test.R")
    } else {
        cat_and_eval(paste0("t.test(x=intro.data[,'", x, "'], y=intro.data[,'", y, "'], conf.level=", conflevel, ", alternative='", althyp, "', mu=", hypval, ")"), env = environment(), file = "code_t_test.R")
    }
}
