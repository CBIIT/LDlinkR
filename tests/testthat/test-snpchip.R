context("test-snpchip")

test_that("snpchip throws an error w/ bad query SNP format", {
  skip_on_cran()
  expect_error(SNPchip(c("r3", "rs4", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip throws an error w/ invalid chr coord", {
  skip_on_cran()
  expect_error(snpchip(c("ch13:32446842", "chr13:32447222", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip works", {
  skip_on_cran()
  expect_named(SNPchip(c("rs3", "rs4", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip works with ALL_Illumina", {
  skip_on_cran()
  expect_named(SNPchip(c("rs3", "rs4", "rs148890987"), "ALL_Illumina", token = Sys.getenv("LDLINK_TOKEN")))
})
