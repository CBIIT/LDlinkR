context("test-snpclip")

test_that("snpclip throws an error w/ bad rsID", {
  skip_on_cran()
  skip_on_ci()
  expect_error(SNPclip(c("rs3", "rs4", "148890987"), "YRI", 0.1, "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip throws an error w/ invalid genome_build args", {
  skip_on_cran()
  skip_on_ci()
  expect_error(snpclip(snps = c("rs3", "rs4"),
                       pop = "YRI",
                       r2_threshold = "0.1",
                       maf_threshold = "0.01",
                       token = "28da99809470",
                       genome_build = "grch999"))
  expect_error(snpclip(snps = c("rs3", "rs4"),
                       pop = "YRI",
                       r2_threshold = "0.1",
                       maf_threshold = "0.01",
                       token = "28da99809470",
                       genome_build = c("grch38", "grch38_high_coverage")))
})

test_that("snpclip throws an error", {
  skip_on_cran()
  skip_on_ci()
  expect_named(SNPclip(c("rs3", "rs4", "rs148890987"), "YRI", 0.1, "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip works", {
  skip_on_cran()
  skip_on_ci()
  expect_named(SNPclip(c("rs3", "rs4", "rs148890987"), "YRI", "0.1", "0.01", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("snpclip works w/ gen coord & no threshold", {
  skip_on_cran()
  skip_on_ci()
  expect_named(SNPclip(c("chr13:32446842", "Rs4", "rs148890987"), "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})
