###
### Libraries
###
library(R.utils)
library(rmarkdown)
library(formatR)
library(knitr)
library(shinyjs)

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
    
    ## Hide Download Button
    hide("mydownload")
    
    ## Update directory
    newuserdir <- tempfile()
    dir.create(newuserdir, recursive = TRUE)
    sapply(file.path(newuserdir, dir(newuserdir)[grep("code_", dir(newuserdir))]), file.remove)
    file.copy(file.path(userdir, "code_All.R"), newuserdir)
    userdir <- newuserdir
    dir.create(file.path(userdir, "data"))
    
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
    
    observe({
        file.copy(input$data_own$datapath, file.path(userdir, "data", input$data_own$name), overwrite = TRUE)
    })
    
    output$mydownload <- downloadHandler(
        filename = function() { "intRo-report.zip" },
        content = function(file) { 
            spin(file.path(userdir, "code_All.R"), format = "Rmd", knit = FALSE)
            
            file.copy(file.path(userdir, "code_All.Rmd"), file.path(userdir, "intRo-report.Rmd"), overwrite = TRUE)
            if (!is.null(input$data_own$datapath)) file.copy(input$data_own$datapath, file.path(userdir, input$data_own$name), overwrite = TRUE)
            
            filelist <- file.path(userdir, "intRo-report.Rmd")
            if (!is.null(input$data_own$datapath)) filelist <- c(filelist, file.path(userdir, "data", dir(file.path(userdir, "data"))))
            
            #if (file.exists(file)) file.remove(file)
            zip(file, files = filelist, flags = "-r9Xj")
        }
    )

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
