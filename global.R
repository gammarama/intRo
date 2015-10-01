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
load("data/configuration.rda")
if (!exists("intRo_enabled_modules") || is.null(intRo_enabled_modules)) intRo_enabled_modules <- intRo_configuration[["intRo_enabled_modules"]]
if (!exists("intRo_theme") || is.null(intRo_theme)) intRo_theme <- intRo_configuration[["intRo_theme"]]

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
