context("get calls")

# Start API server:
callr_obj <- httpeasy::start_api_server(path = test_path("api.R"))
Sys.sleep(8)

call_meta <- list(
  http = "http://",
  host = confx::conf_get("api_server/host", "config.yml"),
  port = confx::conf_get("api_server/port", "config.yml")
)

test_that("/hello-world", {
  get_call <- httpeasy::compose_get_call(
    call_endpoint = "/hello-world",
    call_meta = call_meta,
    call_args = list(
      arg_1 = "some",
      arg_2 = "thing"
    )
  )
  res <- httr::GET(get_call)
  expect_equal(res$status_code, 200)
  expect_equal(res %>% httr::content(), list("hello world some thing"))
})

test_that("dynamic route: /tests/<id>", {
  get_call <- httpeasy::compose_get_call(
    call_endpoint = "/tests/{id}",
    call_meta = list(
      http = "http://",
      host = confx::conf_get("api_server/host", "config.yml"),
      port = confx::conf_get("api_server/port", "config.yml")
    ),
    call_args = list(
      id = "abcd"
    )
  )
  # get_call

  res <- httr::GET(get_call)
  expect_equal(res$status_code, 200)

  target <- list(
    id = list("abcd"),
    type = list("character")
  )
  expect_equal(res %>% httr::content(), target)
})

test_that("dynamic route: /tests/test/<id>", {
  get_call <- httpeasy::compose_get_call(
    call_endpoint = "/tests/test/{id}",
    call_meta = list(
      http = "http://",
      host = confx::conf_get("api_server/host", "config.yml"),
      port = confx::conf_get("api_server/port", "config.yml")
    ),
    call_args = list(
      id = "abcd"
    )
  )
  # get_call

  res <- httr::GET(get_call)
  expect_equal(res$status_code, 200)

  target <- list(
    id = list("abcd"),
    type = list("character")
  )
  expect_equal(res %>% httr::content(), target)
})

test_that("dynamic route: /tests/test_2/<id>", {
  get_call <- httpeasy::compose_get_call(
    call_endpoint = "/tests/test_2/{id}",
    call_meta = list(
      http = "http://",
      host = confx::conf_get("api_server/host", "config.yml"),
      port = confx::conf_get("api_server/port", "config.yml")
    ),
    call_args = list(
      id = "abcd",
      x = 10
    )
  )
  # get_call

  res <- httr::GET(get_call)
  expect_equal(res$status_code, 200)

  target <- list(
    id = list("abcd"),
    type = list("character"),
    x = list("10")
  )
  expect_equal(res %>% httr::content(), target)
})

test_that("dynamic route: /tests/test_3/<id:int>", {
  get_call <- httpeasy::compose_get_call(
    call_endpoint = "/tests/test_3/{id}",
    call_meta = list(
      http = "http://",
      host = confx::conf_get("api_server/host", "config.yml"),
      port = confx::conf_get("api_server/port", "config.yml")
    ),
    call_args = list(
      id = 1,
      x = 10
    )
  )
  # get_call

  res <- httr::GET(get_call)
  expect_equal(res$status_code, 200)

  target <- list(
    id = list(1),
    type = list("integer"),
    x = list(10)
  )
  expect_equal(res %>% httr::content(), target)
})

# Stop API server:
httpeasy::stop_api_server(callr_obj)
