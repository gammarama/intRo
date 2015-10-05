###
### Libraries
###
library(R.utils)
library(rmarkdown)
library(formatR)

###
### Helper Functions
###

## For code printing
clean_readlines <- function(file) {
    return(tidy_source(file, output = FALSE)$text.tidy)
}

###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    
    ## Update directory
    newuserdir <- file.path(tempdir(), tempfile())
    dir.create(newuserdir, recursive = TRUE)
    sapply(file.path(newuserdir, dir(newuserdir)[grep("code_", dir(newuserdir))]), file.remove)
    file.copy(file.path(userdir, "code_All.R"), newuserdir)
    userdir <- newuserdir
    
    ## Maximum file upload size = 10MB
    options(shiny.maxRequestSize = 10 * 1024 ^ 2)
    
    ## Reactive values
    values <- reactiveValues(data = NULL, data_rand = NULL)

    ## Modules
    types <- c("helper.R", "observe.R", "reactive.R", "output.R")
    modules_tosource <- file.path("modules", apply(expand.grid(modules, types), 1, paste, collapse = "/"))
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
    observe({
        if (length(input$print_clicked) > 0 && input$print_clicked) {
            file <- render(file.path(userdir, "code_All.R"), 
                           output_format = if (input$code_clicked) NULL else html_document(css = file.path(getwd(), "www/hide_code.css")),
                           output_dir = file.path(getwd(), "www"))
            
            session$sendCustomMessage(type = "renderFinished", paste(readLines(file), collapse = "\n"))
        }
    })
})
