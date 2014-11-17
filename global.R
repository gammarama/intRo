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

module_info <- read.table("modules/modules.txt", header = TRUE, sep=",")

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

get_code <- function(helper_func, intro.inputs) {      
    #cat("\n", file = "test.R", append = TRUE)
    var <- as.list(formals(helper_func))
    
    for (i in 1:length(var)) {
        var[[i]] <- if (is.null(intro.inputs[[i]])) "NULL" else intro.inputs[[i]]
        str <- process_input(var[[i]])
        
        #cat(paste(names(var)[i], "<-", str, "\n"), file = "test.R", append = TRUE)
    }
    
    #test <- capture.output(helper_func)
    #test2 <- test[-c(1, length(test) - 1, length(test))]
    
    #cat(paste(test2, collapse = "\n"), file = "test.R", append = TRUE)
    
    return(NULL)
}

cat_and_eval <- function(mystr, env = parent.frame(), file = "code_All.R", append = FALSE, save_result = FALSE) {
    #dataargs <- list(...)
    #actualdataargs <- dataargs[-grep("_name", names(dataargs))]
    #for (i in 1:length(actualdataargs)) {
    #    assign(names(actualdataargs)[i], actualdataargs[[i]])
    #    cat(paste(names(actualdataargs)[i], "<-", dataargs[[paste(names(actualdataargs)[i], "name", sep = "_")]], "\n"), file = "test.R", append = TRUE)
    #}
    
    #for (i in 1:length(actualdataargs)) {
    #    mystr <- gsub(paste0("intro_replace", i), dataargs[[paste(names(actualdataargs)[i], "name", sep = "_")]], mystr)
    #}
    
    cat(paste0(gsub("; ", "\n", mystr), "\n\n"), file = file, append = append)
    
    if (save_result) cat(paste(readLines(file), collapse = "\n"), file = "code_All.R", append = TRUE)
        
    eval(parse(text = mystr), envir = env)
}

