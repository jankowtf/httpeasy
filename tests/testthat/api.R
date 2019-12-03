#' @get /hello-world
function(arg_1, arg_2){
  stringr::str_glue("hello world {arg_1} {arg_2}")
}

#' @get /tests/<id>
function(id){
  list(
    id = id,
    type = typeof(id)
  )
}

#' @get /tests/test/<id>
function(id){
  list(
    id = id,
    type = typeof(id)
  )
}

#' @get /tests/test_2/<id>
function(id, x){
  list(
    id = id,
    type = typeof(id),
    x = x
  )
}

#' @get /tests/test_3/<id:int>
function(id, x){
  list(
    id = id,
    type = typeof(id),
    x = as.integer(x)
  )
}
