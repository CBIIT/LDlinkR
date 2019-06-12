context("test-ldpair")

test_that("ldpair throws an error", {
  expect_error(LDpair("rs456", "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpair works", {
  expect_named(LDpair(var1 = "rs3", var2 = "rs4", pop = "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})
