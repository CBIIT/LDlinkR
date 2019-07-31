context("test-snpclip")

test_that("snpclip throws an error w/ bad rsID", {
  skip_on_cran()
  expect_error(SNPclip(c("rs3", "rs4", "148890987"), "YRI", 0.1, "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip throws an error", {
  skip_on_cran()
  expect_named(SNPclip(c("rs3", "rs4", "rs148890987"), "YRI", 0.1, "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip works", {
  skip_on_cran()
  expect_named(SNPclip(c("rs3", "rs4", "rs148890987"), "YRI", "0.1", "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip works w/ gen coord & no threshold", {
  skip_on_cran()
  expect_named(SNPclip(c("chr13:32446842", "Rs4", "rs148890987"), "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})
