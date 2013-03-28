#' Help method: a?"foo"
#' 
#' @export
setMethod("?",  c("cdb", "character"), function(e1, e2) {
    run_help(path = e1@path, search = e2)
})

#' Help method: ?a
#' 
#' @export
setMethod("?",  "cdb", function(e1) {
    run_help(path = e1@path)
})
