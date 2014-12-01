###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    ## Maximum file upload size = 10MB
    options(shiny.maxRequestSize=10*1024^2)
    
    ## Reactive values
    values <- reactiveValues(mydat = NULL, mydat_rand = NULL)    
    
    #cat(paste(readLines("global.R"), collapse = "\n"), file = "code_global.R")
    cat("library(RCurl)\n\n", file = file.path(tempdir(), "code_All.R"), append = TRUE)
    cat("eval(parse(text = getURL('https://raw.githubusercontent.com/gammarama/intRo/master/global.R')))", file = file.path(tempdir(), "code_All.R"), append = TRUE)
    cat("\n\n", file = file.path(tempdir(), "code_All.R"), append = TRUE)
    
    ## Modules
    types <- c("helper.R", "static.R", "observe.R", "reactive.R", "output.R")
    modules_tosource <- file.path("modules", apply(expand.grid(module_info$module, types), 1, paste, collapse = "/"))

    ## Source the modules
    for (mod in modules_tosource) {
        source(mod, local = TRUE)
    }
    
    cat(getwd())
    
    ## Printing
    observe({ 
      if(is.null(input)) return
      if(length(input$print_clicked) > 0) {
        file <- NULL
        if(input$print_clicked) {
          file <- render(file.path(tempdir(), "code_All.R"), output_dir = "www")    
          session$sendCustomMessage(type = "renderFinished", file)
        }
      }
    })
})
