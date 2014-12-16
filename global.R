library(shiny)
library(shinyAce)
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
library(psych)
library(Hmisc)

#cat("```{r, echo=FALSE}\nopts_chunk$set(echo=FALSE)\n```\n\n```{r, child="test.Rmd", message=FALSE, warning=FALSE}\n```", file = "outfile.Rmd")

###
### Global Helper Functions
###
numericNames <- function(data) {
  vec <- as.character(subset(whatis(data), type == "numeric")$variable.name)
  if (length(vec) == 0) vec <- ""
  
  return(vec)
}

q1 <- function(x) { return(quantile(x, .25)) }
q3 <- function(x) { return(quantile(x, .75)) }

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

cat_and_eval <- function(mystr, mydir, env = parent.frame(), file = "code_All.R", append = FALSE, save_result = FALSE) {
    cat(paste0(gsub("; ", "\n", mystr), "\n"), file = file.path(mydir, file), append = append)
    
    if (save_result) cat(paste0(paste(readLines(file.path(mydir, file)), collapse = "\n"), "\n"), file = file.path(mydir, "code_All.R"), append = TRUE)
    
    eval(parse(text = mystr), envir = env)
}
