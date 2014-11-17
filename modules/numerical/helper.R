    generateSummary <- function(intro.data, tblvars, grouping, save_result) {
        if (!is.null(tblvars)) {
            if (grouping == "none") {
                cat_and_eval(paste0("summary(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")])"), env = environment(), file = "code_Numerical.R", append = FALSE)
            } else {
                cat_and_eval(paste0("dat <- intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")]; dat$intro_grouping <- intro.data[,'", grouping, "']; dat.dplyr <- dat[,names(dat) %in% c(\"intro_grouping\", numericNames(dat))] %>% group_by(intro_grouping) %>% summarise_each(funs(min, q1, median, q3, max, mean, sd)); dat.dplyr.df <- as.data.frame(dat.dplyr); names(dat.dplyr.df)[1] <- '", grouping, "'; dat.dplyr.df"), env = environment(), file = "code_Numerical.R")
            }
        }
    }
