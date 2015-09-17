library(shiny)
library(shinyAce)
library(shinythemes)
library(YaleToolkit)
library(ggplot2)
library(ggvis)
library(dplyr)
library(lubridate)
library(gridExtra)
library(R.utils)
library(RCurl)
library(rmarkdown)
library(formatR)
library(Hmisc)

###
### Global Helper Functions
###
numericNames <- function(data) {
  vec <- as.character(subset(whatis(data), type == "numeric")$variable.name)
  if (length(vec) == 0) vec <- ""
  
  return(vec)
}

q1 <- function(x) { return(quantile(x, .25, na.rm = TRUE)) }
q3 <- function(x) { return(quantile(x, .75, na.rm = TRUE)) }

categoricNames <- function(data) {
  vec <- as.character(subset(whatis(data), type != "numeric")$variable.name)
  if (length(vec) == 0) vec <- ""
  
  return(vec)
}

sourceDir <- function(path, type, local = FALSE, ...) { 
  for (nm in list.files(path, pattern = paste0("\\.", type, "$"))) { 
    source(file.path(path, nm), local=local) 
  } 
}

my.summary <- function(data) {
    mean.val <-suppressWarnings(sapply(as.data.frame(data), mean, na.rm=TRUE))
    sd.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(sd(col, na.rm = TRUE)) else NA
    })
    min.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(min(col, na.rm = TRUE)) else NA
    })
    q1.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(q1(col)) else NA
    })
    median.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(median(col, na.rm = TRUE)) else NA
    })
    q3.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(q3(col)) else NA
    })
    max.val <- sapply(as.data.frame(data), function(col) {
        if (is.numeric(type.convert(as.character(col)))) as.numeric(max(col, na.rm = TRUE)) else NA
    })
    
    return(data.frame(mean = mean.val, sd = sd.val, min = min.val, q1 = q1.val, median = median.val, q3 = q3.val, max = max.val))
}

checkVariable <- function(data, var) {
    return(nchar(var) > 0 & var %in% names(data))
}

process_input <- function(inp) {
    if (is.character(inp)) {
        if (length(inp) == 1)  {
            if (length(grep("intro.", inp)) > 0) return(inp)
            else if (inp == "NULL") return(inp)
            else return(paste0("\"", inp, "\""))
        } else {
            return(paste0("c(", paste(paste0("\"", inp, "\""), collapse = ", "), ")"))
        }
    } else {
        return(inp)
    }
}

clean_readlines <- function(file) {
    return(tidy_source(file, output = FALSE)$text.tidy)
}

cat_and_eval <- function(mystr, mydir, env = parent.frame(), file = "code_All.R", append = FALSE, save_result = FALSE, eval = TRUE) {
    cat(paste0(gsub("; ", "\n", mystr), "\n"), file = file.path(mydir, file), append = append)
    
    if (save_result) cat(paste0(paste(readLines(file.path(mydir, file)), collapse = "\n"), "\n"), file = file.path(mydir, "code_All.R"), append = TRUE)
    if (eval) eval(parse(text = mystr), envir = env)
}

as_call <- function(x) {
    if (inherits(x, "formula")) {
        stopifnot(length(x) == 2)
        x[[2]]
    } else if (is.atomic(x) || is.name(x) || is.call(x)) {
        x
    } else {
        stop("Unknown input")
    }
}

interpolate <- function(code, ..., mydir, `_env` = parent.frame(), file = "code_All.R", append = FALSE, save_result = FALSE, eval = TRUE) {
    stopifnot(inherits(code, "formula"), length(code) == 2)
    
    args <- lapply(list(...), as_call)
    expr <- methods::substituteDirect(as_call(code), args)
    
    cat(paste0(as.character(expr)[2], "\n"), file = file.path(mydir, file), append = append)
    
    if (save_result) cat(paste0(paste(readLines(file.path(mydir, file)), collapse = "\n"), "\n\n"), file = file.path(mydir, "code_All.R"), append = TRUE)
    if (eval) eval(expr, `_env`)
}
