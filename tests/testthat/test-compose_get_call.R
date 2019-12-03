context("compose_get_call")

call_meta <- list(
  http = "http://",
  host = confx::conf_get("api_server/host", "config.yml"),
  port = confx::conf_get("api_server/port", "config.yml")
)

test_that("compose", {
  res <- httpeasy::compose_get_call(
    call_endpoint = "/hello-world",
    call_meta = call_meta,
    call_args = list(
      arg_1 = "some",
      arg_2 = "thing"
    )
  )
  expect_equal(res,
    "http://127.0.0.1:8000/hello-world?arg_1=some&arg_2=thing")
})
