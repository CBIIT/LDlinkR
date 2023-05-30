context("test-ldpair")

test_that("ldpair throws an error", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDpair("rs456", "YRI", token = Sys.getenv("LDLINK_TOKEN")))
  expect_error(LDpair(var1 = "rs3",
                      var2 = "rs4",
                      pop = "YRI",
                      token = Sys.getenv("LDLINK_TOKEN"),
                      genome_build = "grch40"
                      )
               )
  expect_error(LDpair(var1 = "rs3",
                      var2 = "rs4",
                      pop = "YRI",
                      token = Sys.getenv("LDLINK_TOKEN"),
                      genome_build = c("grch37", "grch38")
                      )
               )
})

test_that("ldpair works", {
  skip_on_cran()
  skip_on_ci()
  expect_named(LDpair(var1 = "rs3", var2 = "rs4", pop = "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})
