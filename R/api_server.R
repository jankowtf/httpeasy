#' Title \lifecycle{experimental}
#'
#' @param path
#' @param host
#' @param port
#'
#' @return
#' @export
start_api_server <- function(
  path = confx::conf_get("api_server/script", "config.yml"),
  host = confx::conf_get("api_server/host", "config.yml"),
  port = confx::conf_get("api_server/port", "config.yml")
) {
  # callr::r_bg(plumber_start__inner,
  #   args = list(path = path, host = host, port = port))

  # server_config <- confx::conf_get("servers", "openapi.yml")[[1]]
  # server_config$url %>%
  #   stringr::str_extract("http\\://.*/")

  host <- host %>% as.character()
  port <- port %>% as.character()

  callr_obj <- callr::r_session$new()
  callr_obj$call(start_api_server__inner,
    args = list(path = path, host = host, port = port))

  callr_obj
}

start_api_server__inner <- function(
  path = confx::conf_get("api_server/script", "config.yml"),
  host = confx::conf_get("api_server/host", "config.yml"),
  port = confx::conf_get("api_server/port", "config.yml")
) {
  devtools::load_all()
  plumber_cmd <- stringr::str_glue(
    "plumber::plumb(\"{path}\")$run(host = \"{host}\", port = {port})\n")

  plumber_cmd %>%
    rlang::parse_expr() %>%
    rlang::eval_tidy()
}

#' Title \lifecycle{experimental}
#'
#' @param callr_obj
#'
#' @return
#' @export
stop_api_server <- function(callr_obj) {
  callr_obj$kill()
}
