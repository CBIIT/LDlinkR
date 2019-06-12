context("test-ldpop")

test_that("ldpop throws an error", {
  expect_error(LDpop(var1 = "s3", var2 = "Rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop throws an error w/ invalid var2 coord", {
  expect_error(LDpop(var1 = "chr13:32446842", var2 = "cr13:32446842", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop works", {
  expect_named(LDpop(var1 = "rs3", var2 = "rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop works with upper case var1", {
  expect_named(LDpop(var1 = "rs3", var2 = "rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})
