context("test-ldproxy_batch")

# good query
snps_good_qry <- data.frame(c("rs3", "rs4"))
# bad query
snps_bad_qry <- "rr456"

test_that("LDproxy_batch throws an error for bad query variant", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDproxy_batch(snp = snps_bad_qry, "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("LDproxy_batch throws an error for bad genome_build", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDproxy_batch(snp = snps_good_qry,
                             pop = "YRI",
                             r2d = "r2",
                             token = Sys.getenv("LDLINK_TOKEN"),
                             genome_build = "grch999"
                             )
               )
  expect_error(LDproxy_batch(snp = snps_good_qry,
                             pop = "YRI",
                             r2d = "r2",
                             token = Sys.getenv("LDLINK_TOKEN"),
                             genome_build = c("grch37", "grch38")
                            )
              )
})

test_that("LDproxy_batch throws an error for bad token", {
  skip_on_cran()
  skip_on_ci()
  expect_condition(LDproxy_batch(snps_good_qry, "YRI", token = "faketoken"))
})

test_that("ldproxy_batch throws an error if `win_size` is outside acceptable range", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDproxy_batch(snp = snps_good_qry,
                             pop = "YRI",
                             token = Sys.getenv("LDLINK_TOKEN"),
                             win_size = "1000001"
                            )
              )
})
