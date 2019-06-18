context("test-ldproxy_batch")

# good query
snps_good_qry <- data.frame(c("rs3", "rs4"))
# bad query
snps_bad_qry <- data.frame("rr456")

test_that("LDproxy_batch throws an error for bad query variant", {
  expect_error(LDproxy_batch(snp = snps_bad_qry, "YRI", "r2", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("LDproxy_batch throws an error for bad token", {
  expect_condition(LDproxy_batch(snps_good_qry, "YRI", token = "faketoken"))
})

test_that("LDproxy_batch works", {
  expect_condition(LDproxy_batch(snps_good_qry,
                                 "YRI",
                                 "r2",
                                 token = Sys.getenv("LDLINK_TOKEN"),
                                 append = TRUE))
})
