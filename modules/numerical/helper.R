    generateSummary <- function(intro.data, tblvars, grouping, categoric_names) {
        if (is.null(tblvars)) return(NULL)
        
        if (grouping == "none") {
            if (all(tblvars %in% categoric_names)) {
                interpolate(~(describe(df[,vars])), df = quote(intro.data), vars = tblvars,  mydir = userdir, `_env` = environment(), file = "code_numerical.R")
            } else {
                if (length(intersect(tblvars, numericNames(intro.data))) == 1) interpolate(~(df[,intersect(vars, numvars), drop = FALSE] %>%
                                                             summarise_each(funs(min(., na.rm = TRUE), q1 = quantile(., .25, na.rm = TRUE), median(., na.rm = TRUE), q3 = quantile(., .75, na.rm = TRUE), max(., na.rm = TRUE), mean(., na.rm = TRUE), sd(., na.rm = TRUE))) %>%
                                                             as.data.frame), df = quote(intro.data), vars = tblvars, numvars = numericNames(intro.data), mydir = userdir, `_env` = environment(), file = "code_numerical.R")
                else interpolate(~(df[,intersect(vars, numvars)] %>%
                                  summarise_each(funs(min(., na.rm = TRUE), q1 = quantile(., .25, na.rm = TRUE), median(., na.rm = TRUE), q3 = quantile(., .75, na.rm = TRUE), max(., na.rm = TRUE), mean(., na.rm = TRUE), sd(., na.rm = TRUE))) %>%
                                  gather(key = variable, value = value) %>% 
                                  separate(variable, c("var", "stat"), sep = "\\_") %>%
                                  spread(var, value) %>%
                                  as.data.frame), df = quote(intro.data), vars = tblvars, numvars = numericNames(intro.data), mydir = userdir, `_env` = environment(), file = "code_numerical.R")
            }
        } else {
            interpolate(~(df[,c(grpname, intersect(vars, numvars))] %>% 
                              group_by(group) %>% 
                              summarise_each(funs(min(., na.rm = TRUE), q1 = quantile(., .25, na.rm = TRUE), median(., na.rm = TRUE), q3 = quantile(., .75, na.rm = TRUE), max(., na.rm = TRUE), mean(., na.rm = TRUE), sd(., na.rm = TRUE))) %>%
                              gather(key = variable, value = value, -group) %>% 
                              separate(variable, c("var", "stat"), sep = "\\_") %>%
                              spread(var, value) %>%
                              as.data.frame), df = quote(intro.data), grpname = grouping, group = as.name(grouping), vars = tblvars, numvars = numericNames(intro.data), mydir = userdir, `_env` = environment(), file = "code_numerical.R")
        }
    }
