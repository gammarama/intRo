#' Set the options for the given intRo instance
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' 
#' @examples
#' \dontrun{
#'     deploy_intRo()
#' }
set_options <- function(path, enabled_modules, theme) {
    if (!file.exists(file.path(path, "data", "configuration.rda"))) stop("Could not find intRo.")
    if (is.null(enabled_modules)) enabled_modules <- c("data/transform", 
                                                       "summaries/graphical",
                                                       "summaries/numerical",
                                                       "statistics/contingency",
                                                       "statistics/regression",
                                                       "statistics/t_test")
    if (is.null(theme)) theme <- "united"
    
    ## Routine to check packages
    pkgs.required <- unique(unlist(lapply(enabled_modules, function(mod) {
        lib.path <- file.path(path, "modules", mod, "libraries.R")
        lib.lines <- readLines(lib.path)
        
        gsub(".*library\\((.*?)\\).*", "\\1", lib.lines)
    })))
        
    test <- which(!(pkgs.required %in% installed.packages()[,1]))
    if (length(test) > 0) stop("One or more required packages missing: ", paste(pkgs.required[test], collapse = ", "))

    intRo_configuration <- list(intRo_enabled_modules = enabled_modules,
                                intRo_theme = theme)
    save(intRo_configuration, file = file.path(path, "data", "configuration.rda"))
}
