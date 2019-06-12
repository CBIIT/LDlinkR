context("test-ldmatrix")

test_that("ldmatrix throws an error", {
  expect_error(LDmatrix("rs3", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldmatrix works", {
  expect_named(LDmatrix(c("rs3", "rs4", "rs148890987"), "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})
