#' @get /hello-world
function(arg_1, arg_2){
  stringr::str_glue("hello world {arg_1} {arg_2}")
}
