context("test-snpchip")

test_that("snpchip throws an error w/ bad query SNP format", {
  skip_on_cran()
  skip_on_ci()
  expect_error(SNPchip(c("r3", "rs4", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip throws an error w/ invalid chr coord", {
  skip_on_cran()
  skip_on_ci()
  expect_error(snpchip(c("ch13:32446842", "chr13:32447222", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip throws an error w/ invalid genome_build", {
  skip_on_cran()
  skip_on_ci()
  expect_error(SNPchip(snps = c("rs3", "rs148890987"),
                       chip = "ALL",
                       token = Sys.getenv("LDLINK_TOKEN"),
                       genome_build = "grch999"))
  expect_error(SNPchip(snps = c("rs3", "rs148890987"),
                       chip = "ALL",
                       token = Sys.getenv("LDLINK_TOKEN"),
                       genome_build = c("grch37", "grch38")))
})

test_that("snpchip works", {
  skip_on_cran()
  skip_on_ci()
  expect_named(SNPchip(c("rs3", "rs4", "rs148890987"), "ALL", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpchip works with ALL_Illumina", {
  skip_on_cran()
  skip_on_ci()
  expect_named(SNPchip("rs12082302", "ALL_Illumina", token = Sys.getenv("LDLINK_TOKEN")))
})
