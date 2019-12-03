#' Title \lifecycle{experimental}
#'
#' @param call_endpoint
#' @param call_meta
#' @param call_args
#'
#' @return
#' @export
compose_get_call <- function(
  call_endpoint,
  call_meta,
  call_args
) {
  # Identify direct args to be parsed into endpoint string:
  args_to_remove <- call_endpoint %>%
    stringr::str_extract_all("\\{.*?\\}") %>%
    unlist() %>%
    stringr::str_remove_all("\\{|\\}")

  # Parse direct args into endpoint string:
  call_endpoint <- call_args %>%
    stringr::str_glue_data(call_endpoint)

  # Remove args that are already parsed into string:
  call_args <- call_args[!(names(call_args) %in% args_to_remove)]

  # Process call args:
  call_args_proc <- call_args %>%
    httpeasy::process_get_call_args()

  # Compose entire call data object:
  call_data <- c(
    call_meta,
    list(endpoint = call_endpoint),
    call_args_proc
  )

  # Compose call args string:
  call_args_string <- call_args %>%
    names() %>%
    purrr::map_chr(~stringr::str_c("{", ., "}")) %>%
    stringr::str_c(collapse = "&")

  # Compose left/main part of call string:
  api_call_main <- call_data %>%
    stringr::str_glue_data(
      "{http}{host}:{port}{endpoint}"
    )

  # Compose arg part of call string:
  api_call_args <- call_data %>%
    stringr::str_glue_data(
      call_args_string
    )

  # Compose entire call string:
  if (api_call_args %>% length()) {
    stringr::str_glue("{api_call_main}?{api_call_args}")
  } else {
    stringr::str_glue("{api_call_main}")
  }
}

#' Title \lifecycle{experimental}
#'
#' @param args
#'
#' @return
#' @export
process_get_call_args <- function(args) {
  purrr::map2(
    names(args), args,
    function(.x, .y) {
      stringr::str_c(.x, "=", .y)
    }) %>%
    purrr::set_names(names(args))
}
