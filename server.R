###
### Libraries
###
library(dplyr)
library(tidyr)
library(lubridate)
library(gridExtra)
library(R.utils)
library(RCurl)
library(rmarkdown)
library(formatR)

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

## For code printing
clean_readlines <- function(file) {
    return(tidy_source(file, output = FALSE)$text.tidy)
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

###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    
    ## Module info
    module_info <- read.table("modules/modules.txt", header = TRUE, sep = ",")
    
    ## Get directory ready for code printing
    userdir <- file.path(tempdir(), tempfile())
    dir.create(userdir, recursive = TRUE)
    sapply(file.path(userdir, dir(userdir)[grep("code_", dir(userdir))]), file.remove)
    
    ## Maximum file upload size = 10MB
    options(shiny.maxRequestSize = 10 * 1024 ^ 2)
    
    ## Reactive values
    values <- reactiveValues(data = NULL, data_rand = NULL)
    
    ## User Libraries
    cat(paste(readLines("code/libraries.R"), collapse = "\n"), file = file.path(userdir, "code_All.R"))

    ## Modules
    types <- c("helper.R", "observe.R", "reactive.R", "output.R")
    modules_tosource <- file.path("modules", apply(expand.grid(module_info$module, types), 1, paste, collapse = "/"))
    
    ## Source the modules
    for (mod in modules_tosource) {
        source(mod, local = TRUE)
    }
    
    ## Check for file update every 5 seconds
    code <- reactiveFileReader(500, session, file.path(userdir, "code_All.R"), clean_readlines)
    
    ## Code Viewing
    observe({    
        updateAceEditor(session, "myEditor", value = paste(code(), collapse = "\n"))
    })
    
    ## Printing
    observeEvent(input$print_clicked, {
        file <- render(file.path(userdir, "code_All.R"), 
                       output_format = if (input$code_clicked) NULL else html_document(css = file.path(getwd(), "www/hide_code.css")),
                       output_dir = file.path(getwd(), "www"))
        
        session$sendCustomMessage(type = "renderFinished", paste(readLines(file), collapse = "\n"))
    })
})
