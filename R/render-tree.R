#' Render a ShinyTree
#' 
#' Should return a list from the given expression which will be converted into a
#' \code{\link{shinyTree}}.
#' 
#' @param expr The expression to be evaluated which should produce a list.
#' @param env The environment in which \code{expr} should be evaluated.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#' is useful if you want to save an expression in a variable.
#' @seealso \code{\link{shinyTree}}
#' @export
renderTree <- function(expr, env = parent.frame(), quoted = FALSE){
  func <- shiny::exprToFunction(expr, env, quoted)
  return(function(shinysession, name, ...) {
    tree <- func()
    if(inherits(expr, "Node")){
      shiny::HTML(as.character(datatreeToTags(tree)))  
    } else {
      shiny::HTML(as.character(listToTags(tree)))  
    }
  })
}