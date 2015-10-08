#' Deploy an instance of intRo to ShinyApps.io
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' @param ... Additional arguments passed to the shinyapps deployApp function
#' 
#' @export
#' 
#' @importFrom shinyapps deployApp
#' 
#' @examples
#' \dontrun{
#'     deploy_intRo()
#      deploy_intRo(enabled_modules = c("data/transform", "summaries/graphical"),
#'                  theme = "cerulean")
#' }
deploy_intRo <- function(path = getwd(), enabled_modules = NULL, theme = NULL, ...) {
    path <- file.path(path, "intRo")
    
    set_options(path, enabled_modules, theme)
    
    deployApp(appDir = path, ...)
}
