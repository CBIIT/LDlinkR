context("test-ldmatrix")

test_that("ldmatrix throws an error", {
  skip_on_cran()
  skip_on_ci()
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
  skip_on_ci()
  expect_named(LDmatrix(c("rs3", "rs4", "rs148890987"), "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})


test_that("ldmatrix throws an error when list of variants is greater than 2500", {
  skip_on_cran()
  skip_on_ci()
  # generate list of variants that exceeds 2500
  rs_variants <- paste0("rs", 1:2501)
  expect_error(LDmatrix(snps = rs_variants,
                        pop = "YRI",
                        r2d = "r2",
                        token = Sys.getenv("LDLINK_TOKEN")
                       )
               )
})

test_that("ldmatrix throws an error when list of variants is less than 2", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDmatrix(snps = "rs3",
                        pop = "YRI",
                        r2d = "r2",
                        token = Sys.getenv("LDLINK_TOKEN")
                       )
              )
})
