###
### Libraries
###
library(shiny)
library(shinyAce)

###
### Configuration
###
load("data/configuration.rda")
intRo_enabled_modules <- intRo_configuration[["intRo_enabled_modules"]]
intRo_theme <- intRo_configuration[["intRo_theme"]]

## Get directory ready for code printing
userdir <- tempfile()
dir.create(userdir, recursive = TRUE)
sapply(file.path(userdir, dir(userdir)[grep("code_", dir(userdir))]), file.remove)

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
    
    if (save_result) cat(paste0(paste(readLines(file.path(mydir, file)), collapse = "\n"), "\n"), file = file.path(mydir, "code_All.R"), append = TRUE)
    if (eval) eval(expr, `_env`)
}

###
### Modules
###
pkgs <- c(".GlobalEnv", "tools:rstudio", "package:stats", "package:graphics", "package:grDevices", "package:utils", 
          "package:datasets", "package:methods", "Autoloads", "package:base", "package:shiny", "package:shinyAce",
          "package:git2r", "package:intRo")
otherpkgs <- search()[!(search() %in% pkgs)]
lapply(otherpkgs, detach, character.only = TRUE, unload = TRUE)

categories <- unique(c("data", sapply(intRo_enabled_modules, function(x){strsplit(x, "/")[[1]][1]})))
modules <- unique(c("data/sources", intRo_enabled_modules))
sapply(file.path("modules", modules, "libraries.R"), source)

###
### Helper Functions
###

checkVariable <- function(data, var) {
    return(nchar(var) > 0 & var %in% names(data))
}

numericNames <- function(data) {
    vec <- as.character(subset(YaleToolkit::whatis(data), type == "numeric")$variable.name)

    real_columns <- unlist(lapply(data[,vec, drop = FALSE], function(col) { sum(!is.na(col)) > 0 }))
    if (is.null(real_columns)) return("")
    
    return(names(real_columns)[real_columns])
}

categoricNames <- function(data) {
    vec <- as.character(subset(YaleToolkit::whatis(data), type != "numeric")$variable.name)

    real_columns <- unlist(lapply(data[,vec, drop = FALSE], function(col) { sum(!is.na(col)) > 0 }))
    if (is.null(real_columns)) return("")
    
    return(names(real_columns)[real_columns])
}
