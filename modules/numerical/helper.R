    generateSummary <- function(intro.data, tblvars, grouping, categoric_names) {
        if (!is.null(tblvars)) {
            if (grouping == "none") {
                if (all(tblvars %in% categoric_names)) {
                    cat_and_eval(paste0("describe(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")])"), mydir = userdir, env = environment(), file = "code_numerical.R")
                } else {
                    cat_and_eval(paste0("my.summary(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")])"), mydir = userdir, env = environment(), file = "code_numerical.R")
                }
            } else {
                cat_and_eval(paste0("dat <- intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")]; dat$intro_grouping <- intro.data[,'", grouping, "']; dat.dplyr <- dat[,names(dat) %in% c(\"intro_grouping\", numericNames(dat))] %>% group_by(intro_grouping) %>% summarise_each(funs(min, q1, median, q3, max, mean, sd)); dat.dplyr.df <- as.data.frame(dat.dplyr); names(dat.dplyr.df)[1] <- '", grouping, "'; dat.dplyr.df"), mydir = userdir, env = environment(), file = "code_numerical.R")
            }
        }
    }
