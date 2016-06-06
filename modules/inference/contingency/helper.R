cont.table <- function(intro.data, x, y, type, digits) {  
    interpolate(
        ~ (my.tbl <- cbind(rbind(table(df$y, df$x), 
                      Total = colSums(table(df$y, df$x))), 
                Total = c(rowSums(table(df$y, df$x))[-(length(df$x))], sum(table(df$y, df$x))))),
        df = quote(intro.data),
        x = x,
        y = y,
        mydir = userdir,
        `_env` = environment(),
        file = "code_contingency.R"
    )

    if (type == "totalpercs") interpolate(~(my.tbl <- my.tbl / sum(table(df$y, df$x))), df = quote(intro.data), x = x, y = y,  mydir = userdir, `_env` = environment(), file = "code_contingency.R", append = TRUE)
    if (type == "rowpercs") interpolate(~(my.tbl <- t(apply(my.tbl[-nrow(my.tbl),], 1, function(row){row / row[ncol(my.tbl)]}))),  mydir = userdir,`_env` = environment(), file = "code_contingency.R", append = TRUE)
    if (type == "columnpercs") interpolate(~(my.tbl <- apply(my.tbl[,-ncol(my.tbl)], 2, function(col){col / col[nrow(my.tbl)]})),  mydir = userdir, `_env` = environment(), file = "code_contingency.R", append = TRUE)
    
    if (type %in% c("totalpercs", "rowpercs", "columnpercs")) interpolate(~(new.digits <- digits), digits = digits, mydir = userdir, `_env` = environment(), file = "code_contingency.R", append = TRUE)
    else interpolate(~(new.digits <- 0),  mydir = userdir, `_env` = environment(), file = "code_contingency.R", append = TRUE)
    
    interpolate(~(format(round(my.tbl, digits = new.digits))), mydir = userdir, `_env` = environment(), file = "code_contingency.R", append = TRUE)
}
