#' Deploy an instance of intRo to ShinyApps.io
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' @param google_analytics The google analytics tracking ID to use
#' @param ... Additional arguments passed to the rsconnect deployApp function
#' @export
#' @importFrom rsconnect deployApp
#' @examples
#' \dontrun{
#'     deploy_intRo()
#      deploy_intRo(enabled_modules = c("data/transform", "summaries/graphical"),
#'                  theme = "cerulean")
#' }
deploy_intRo <- function(path = getwd(), enabled_modules = NULL, theme = NULL, google_analytics = NULL, ...) {
    path <- file.path(path, "intRo")
    
    set_options(path, enabled_modules, theme, google_analytics)
    
    deployApp(appDir = path, ...)
}
