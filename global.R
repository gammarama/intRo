library(shiny)
library(shinyAce)
library(YaleToolkit)
library(ggplot2)
library(ggvis)
library(dplyr)
library(lubridate)
library(gridExtra)
library(R.utils)


###
### Global Helper Functions
###
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

sourceDir <- function(path, type, local = FALSE, ...) { 
  for (nm in list.files(path, pattern = paste0("\\.", type, "$"))) { 
    source(file.path(path, nm), local=local) 
  } 
}

module_info <- read.table("modules/modules.txt", header = TRUE, sep=",")