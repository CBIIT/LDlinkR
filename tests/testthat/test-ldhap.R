context("test-ldhap")

test_that("ldhap throws an error", {
  expect_error(LDhap(c("r3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldhap works", {
  expect_named(LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})
