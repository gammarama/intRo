data.module <- function (inFile, dataset, own) {        
    intro.data <- NULL
    if (is.null(inFile) | !own) {
        intro.data <- dataset
    } else {
        intro.data <- read.csv(inFile$datapath)
    }
    
    intro.data
}