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
