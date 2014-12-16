    generateSummary <- function(intro.data, tblvars, grouping) {
        if (!is.null(tblvars)) {
            if (grouping == "none") {
                if (all(tblvars %in% categoricNames(intro.data))) {
                    cat_and_eval(paste0("Hmisc::describe(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")])"),  mydir = userdir, env = environment(), file = "code_numerical.R", append = FALSE)
                } else {
                    cat_and_eval(paste0("my.summary <- as.data.frame(psych::describe(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")], skew = FALSE))[,c('n', 'mean', 'sd', 'min', 'median', 'max', 'range')]"), mydir = userdir, env = environment(), file = "code_numerical.R")
                    cat_and_eval("my.summary[grep('\\\\*', rownames(my.summary)), c('mean', 'sd', 'min', 'median', 'max', 'range')] <- NA",  mydir = userdir, env = environment(), file = "code_numerical.R", append = TRUE)
    
                    cat_and_eval("my.summary",  mydir = userdir, env = environment(), file = "code_numerical.R", append = TRUE)
                }
            } else {
                cat_and_eval(paste0("psych::describeBy(intro.data[,c(", paste(paste0("'", tblvars, "'"), collapse = ", "), ")], group = intro.data[,'", input$grouping, "'], skew = FALSE)"), mydir = userdir, env = environment(), file = "code_numerical.R")
            }
        }
    }
