context("start and stop API server")

test_that("start", {
  res <<- httpeasy::start_api_server()
  expect_is(res, c("r_session", "process", "R6"))
  expect_identical(res$get_name(), "Rterm.exe")
})

test_that("stop", {
  expect_true(res <- httpeasy::stop_api_server(res))
})
