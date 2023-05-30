context("test-ldpop")

test_that("ldpop throws an error", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDpop(var1 = "s3", var2 = "Rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop throws an error w/ invalid var2 coord", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDpop(var1 = "chr13:32446842", var2 = "cr13:32446842", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop throws error w/ genome_build", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDpop(var1 = "rs3",
                     var2 = "rs4",
                     pop = "YRI",
                     r2d = "r2",
                     token = Sys.getenv("LDLINK_TOKEN"),
                     genome_build = "grch40")
                    )
  expect_error(LDpop(var1 = "rs3",
                     var2 = "rs4",
                     pop = "YRI",
                     r2d = "r2",
                     token = Sys.getenv("LDLINK_TOKEN"),
                     genome_build = c("grch37", "grch38")
                    )
               )
    })

test_that("ldpop works", {
  skip_on_cran()
  skip_on_ci()
  expect_named(LDpop(var1 = "rs3", var2 = "rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldpop works with upper case var1", {
  skip_on_cran()
  skip_on_ci()
  expect_named(LDpop(var1 = "rs3", var2 = "rs4", pop = "YRI", r2d = "r2", token = Sys.getenv("LDLINK_TOKEN")))
})
