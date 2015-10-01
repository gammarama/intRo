###
### Libraries
###
library(shiny)
library(shinyAce)
library(YaleToolkit)
library(ggplot2)
library(ggvis)
library(Hmisc)

###
### Enabled Modules
###
enabled_modules <- c("data/transform", 
                     "summaries/graphical", "summaries/numerical",
                     "statistics/contingency", "statistics/regression", "statistics/t_test")

###
### Modules
###
categories <- unique(c("data", sapply(enabled_modules, function(x){strsplit(x, "/")[[1]][1]})))
modules <- unique(c("data/sources", enabled_modules))

###
### Helper Functions
###
checkVariable <- function(data, var) {
    return(nchar(var) > 0 & var %in% names(data))
}

numericNames <- function(data) {
    vec <- as.character(subset(whatis(data), type == "numeric")$variable.name)
    if (length(vec) == 0) vec <- ""
    
    return(vec)
}

categoricNames <- function(data) {
    vec <- as.character(subset(whatis(data), type != "numeric")$variable.name)
    if (length(vec) == 0) vec <- ""
    
    return(vec)
}
