context("test-ldproxy")

test_that("ldproxy throws an error for bad query variant", {
  skip_on_cran()
  expect_error(LDproxy("rr456", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldproxy throws an error for bad token", {
  skip_on_cran()
  expect_condition(LDproxy("chr7:24966446", "YRI", token = "faketoken"))
})

test_that("ldproxy works", {
  skip_on_cran()
  expect_named(LDproxy("rs456", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldproxy works using chr coord w/ upper case", {
  skip_on_cran()
  expect_named(LDproxy("Chr7:24966446", "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})
