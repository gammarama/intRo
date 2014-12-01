###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    
    ## Module info
    module_info <- read.table("modules/modules.txt", header = TRUE, sep=",")
    
    ## Get directory ready for code printing
    userdir <- file.path(tempdir(), tempfile())
    dir.create(userdir, recursive = TRUE)
    sapply(file.path(userdir, dir(userdir)[grep("code_", dir(userdir))]), file.remove)
    
    ## Maximum file upload size = 10MB
    options(shiny.maxRequestSize=10*1024^2)
    
    ## Reactive values
    values <- reactiveValues(mydat = NULL, mydat_rand = NULL)
    
    #cat(paste(readLines("global.R"), collapse = "\n"), file = "code_global.R")
    cat("library(RCurl)\n", file = file.path(userdir, "code_All.R"))
    cat("eval(parse(text = getURL('https://raw.githubusercontent.com/gammarama/intRo/dev/global.R')))", file = file.path(userdir, "code_All.R"), append = TRUE)
    
    ## Modules
    types <- c("helper.R", "static.R", "observe.R", "reactive.R", "output.R")
    modules_tosource <- file.path("modules", apply(expand.grid(module_info$module, types), 1, paste, collapse = "/"))

    ## Source the modules
    for (mod in modules_tosource) {
        source(mod, local = TRUE)
    }
    
    ## Check for file update every 5 seconds
    code <- reactiveFileReader(500, session, file.path(userdir, "code_All.R"), clean_readlines)
    
    ## Code Viewing
    observe({    
      updateAceEditor(session, "myEditor", value=paste(code(), collapse="\n"))  
    })
    
    
    ## Printing
    observe({ 
      if(is.null(input)) return
      if(length(input$print_clicked) > 0) {
        file <- NULL
        if(input$print_clicked) {
          oldwd <- getwd()
          
          inc <- ifelse(!input$code_clicked, includes(before_body="www/hide_code.html"), includes(before_body=NULL))
          
          file <- render(file.path(userdir, "code_All.R"), 
                         output_format = html_document(includes = inc),
                         output_dir = file.path(oldwd, "www"))
          session$sendCustomMessage(type = "renderFinished", paste(readLines(file), collapse="\n"))
        }
      }
    })
})
