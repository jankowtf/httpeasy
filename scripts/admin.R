

# v0.0.0.9000 -------------------------------------------------------------

# 2019-12-03

renv::install("callr")
usethis::use_package("callr")
renv::snapshot()

usethis::use_test("api_server")
usethis::use_test("compose_get_call")

renv::install("plumber")
usethis::use_package("plumber", type = "suggests")
renv::snapshot()

# v0.0.0.9003 -------------------------------------------------------------

usethis::use_test("misc")
usethis::use_test("get_calls")
