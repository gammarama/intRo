cont.table <- function(intro.data, x, y, type, digits) {  
    if (x %in% names(intro.data) & y %in% names(intro.data)) {
        interpolate(
            ~ assign("my.tbl", cbind(rbind(table(df$y, df$x), 
                          Total = colSums(table(df$y, df$x))), 
                    Total = c(rowSums(table(df$y, df$x))[-(length(df$x))], sum(table(df$y, df$x))))),
            df = quote(intro.data),
            x = x,
            y = y,
            mydir = userdir,
            `_env` = environment(),
            file = "code_contingency.R"
        )

        if (type == "totalpercs") cat_and_eval("my.tbl <- my.tbl / totalsum",  mydir = userdir, env = environment(), file = "code_contingency.R", append = TRUE)
        if (type == "rowpercs") {
            cat_and_eval("my.tbl <- t(apply(my.tbl[-nrow(my.tbl),], 1, function(row){row / row[ncol(my.tbl)]}))",  mydir = userdir, env = environment(), file = "code_contingency.R", append = TRUE)
        }
        if (type == "columnpercs") {
            cat_and_eval("my.tbl <- apply(my.tbl[,-ncol(my.tbl)], 2, function(col){col / col[nrow(my.tbl)]})",  mydir = userdir, env = environment(), file = "code_contingency.R", append = TRUE)
        }
        
        cat_and_eval(paste0("
            new.digits <- if ('", type, "' %in% c('totalpercs', 'rowpercs', 'columnpercs')) ", digits, " else 0
            format(round(my.tbl, digits = new.digits))
        "),  mydir = userdir, env = environment(), file = "code_contingency.R", append = TRUE)
    } else {
        return(NULL)
    }
}
