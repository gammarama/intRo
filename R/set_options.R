#' Set the options for the given intRo instance
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' @param google_analytics The google analytics tracking ID to use
#' @importFrom utils installed.packages
#' @examples
#' \dontrun{
#'     deploy_intRo()
#' }
set_options <- function(path, enabled_modules, theme, google_analytics) {
    if (!file.exists(file.path(path, "data", "configuration.rda"))) stop("Could not find intRo.")
    if (is.null(enabled_modules)) enabled_modules <- c("data/transform", 
                                                       "summaries/graphical",
                                                       "summaries/numerical",
                                                       "inference/contingency",
                                                       "inference/regression",
                                                       "inference/t_test")
    if (is.null(theme)) theme <- "united"
    if (is.null(google_analytics)) google_analytics <- "intRo_tracking_code"
    
    ## Routine to set google analytics
    script.path <- file.path(path, "scripts", "google-analytics.js")
    js.lines <- readLines(script.path)
    js.lines <- gsub("intRo_tracking_code", google_analytics, js.lines)
    writeLines(js.lines, script.path)
    
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
