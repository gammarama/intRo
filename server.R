###
### Shiny Server definition
###
shinyServer(function(input, output, session) {
    ## Remove last session's code
    sapply(dir()[grep("code_", dir())], file.remove)
    
    ## Maximum file upload size = 10MB
    options(shiny.maxRequestSize=10*1024^2)
    
    ## Reactive values
    values <- reactiveValues(mydat = NULL, mydat_rand = NULL)    
    
    #cat(paste(readLines("global.R"), collapse = "\n"), file = "code_global.R")
    cat("library(RCurl)\n\n", file = "code_All.R", append = TRUE)
    cat("eval(parse(text = getURL('https://raw.githubusercontent.com/gammarama/intRo/master/global.R')))", file = "code_All.R", append = TRUE)
    cat("\n\n", file = "code_All.R", append = TRUE)
    
    ## Modules
    types <- c("helper.R", "static.R", "observe.R", "reactive.R", "output.R")
    modules_tosource <- file.path("modules", apply(expand.grid(module_info$module, types), 1, paste, collapse = "/"))

    ## Source the modules
    for (mod in modules_tosource) {
        source(mod, local = TRUE)
    }
    
    ## Printing
    output$print_output <- reactive({ 
      input[[paste0("store_", module_info$module)]]
      loc <- render("code_All.R", output_dir = "www")
      return(loc)      
    })
})
