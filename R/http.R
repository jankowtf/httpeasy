compose_get_call <- function(
  call_endpoint,
  call_meta,
  call_args
) {
  call_args_proc <- call_args %>%
    process_get_call_args()

  call_data <- c(
    call_meta,
    list(endpoint = call_endpoint),
    call_args_proc
  )

  call_args_string <- call_args %>%
    names() %>%
    purrr::map_chr(~stringr::str_c("{", ., "}")) %>%
    stringr::str_c(collapse = "&")

  api_call_main <- call_data %>%
    stringr::str_glue_data(
      "{http}{host}:{port}{endpoint}"
    )

  api_call_args <- call_data %>%
    stringr::str_glue_data(
      call_args_string
    )

  stringr::str_glue("{api_call_main}?{api_call_args}")
}

process_get_call_args <- function(args) {
  purrr::map2(
    names(args), args,
    function(.x, .y) {
      stringr::str_c(.x, "=", .y)
    }) %>%
    purrr::set_names(names(args))
}
