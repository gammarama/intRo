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
### Configuration
###
if (!exists("intRo_enabled_modules")) intRo_enabled_modules <- c("data/transform", 
                                                     "summaries/graphical", "summaries/numerical",
                                                     "statistics/contingency", "statistics/regression", "statistics/t_test")
if (!exists("intRo_theme")) intRo_theme <- "united"

###
### Modules
###
categories <- unique(c("data", sapply(intRo_enabled_modules, function(x){strsplit(x, "/")[[1]][1]})))
modules <- unique(c("data/sources", intRo_enabled_modules))

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
