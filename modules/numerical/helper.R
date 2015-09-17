    generateSummary <- function(intro.data, tblvars, grouping, categoric_names) {
        if (is.null(tblvars)) return(NULL)
        
        if (grouping == "none") {
            if (all(tblvars %in% categoric_names)) {
                interpolate(~(describe(df[,vars])), df = quote(intro.data), vars = tblvars,  mydir = userdir, `_env` = environment(), file = "code_numerical.R")
            } else {
                interpolate(~(my.summary(df[,vars])), df = quote(intro.data), vars = tblvars, mydir = userdir, `_env` = environment(), file = "code_numerical.R")
            }
        } else {
            interpolate(~(my.summary <- cbind(df[,intersect(vars, numvars)], intro.grouping = df[,group])), df = quote(intro.data), vars = tblvars, numvars = numericNames(intro.data), group = grouping, mydir = userdir, `_env` = environment(), file = "code_numerical.R")
            interpolate(~(my.summary %>% 
                              group_by(intro.grouping) %>% 
                              summarise_each(funs(min, q1, median, q3, max, mean, sd)) %>%
                              as.data.frame %>%
                              rename(group = intro.grouping)), group = grouping, mydir = userdir, `_env` = environment(), file = "code_numerical.R", append = TRUE)
        }
    }
