context("test-ldproxy")

test_that("ldproxy throws an error for bad query variant", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDproxy("rr456", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
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

test_that("ldproxy throws an error for bad token", {
  skip_on_cran()
  skip_on_ci()
  expect_condition(LDproxy("chr7:24966446", "YRI", token = "faketoken"))
})

test_that("ldproxy works", {
  skip_on_cran()
  skip_on_ci()
  expect_named(LDproxy("rs456", "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldproxy works using chr coord w/ upper case", {
  skip_on_cran()
  skip_on_ci()
  expect_named(LDproxy("Chr7:24966446", "YRI", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldproxy throws an error if `win_size` is outside acceptable range", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDproxy(snp = "rs456",
                       pop = "YRI",
                       token = Sys.getenv("LDLINK_TOKEN"),
                       win_size = "1000001"
                      )
               )
})
