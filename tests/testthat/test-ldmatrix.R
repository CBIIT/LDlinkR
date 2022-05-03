context("test-ldmatrix")

test_that("ldmatrix throws an error", {
  skip_on_cran()
  expect_error(LDmatrix("rs3", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
  expect_error(LDmatrix(snps = c("rs4853519", "rs7598883", "Rs4853736"),
                        pop = c("YRI","CEU"),
                        r2d = "r2",
                        token = Sys.getenv("LDLINK_TOKEN"),
                        file = FALSE,
                        genome_build = "grch40"))
  expect_error(LDmatrix(snps = c("rs4853519", "rs7598883"),
                        pop = "YRI",
                        r2d = "d",
                        token = Sys.getenv("LDLINK_TOKEN"),
                        file = FALSE,
                        genome_build = c("grch37", "grch38")))
})

test_that("ldmatrix works", {
  skip_on_cran()
  expect_named(LDmatrix(c("rs3", "rs4", "rs148890987"), "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})
