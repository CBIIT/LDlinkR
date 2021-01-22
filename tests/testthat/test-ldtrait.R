context("test-ldtrait")

test_that("ldtrait throws an error for invalid input arguments", {
  skip_on_cran()
  expect_error(ldtrait(snps = "rs0", pop = "CEU",
                         token = Sys.getenv("LDLINK_TOKEN")
                        )
               )
  expect_error(ldtrait(snps = "rs4", pop = "CE",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
              )
  expect_error(ldtrait(snps = "rs0", r2d = "r",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
               )

})

test_that("ldtrait throws an error when thresholds are outside acceptable range", {
  skip_on_cran()
  expect_error(ldtrait(snps = "rs4", r2d_threshold = "99",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
  expect_error(ldtrait(snps = "rs4", win_size = "9999999",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
})

