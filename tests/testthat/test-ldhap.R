context("test-ldhap")

test_that("ldhap throws an error", {
  skip_on_cran()
  expect_error(LDhap(c("r3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldhap works", {
  skip_on_cran()
  expect_named(LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})
