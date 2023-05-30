context("test-ldexpress")

test_that("ldexpress throws an error for invalid input arguments", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDexpress(snps = "r345", pop = "CEU", tissue =  c("ADI_SUB", "ADI_VIS_OME"),
                         token = Sys.getenv("LDLINK_TOKEN")
                        )
               )
  expect_error(LDexpress(snps = "r345", pop = "CEU", tissue = "ADI_SUB",
                         token = Sys.getenv("LDLINK_TOKEN"),
                         genome_build = "grch40"
                        )
               )
  expect_error(LDexpress(snps = "r345", pop = "CEU", tissue = "ADI_SUB",
                         token = Sys.getenv("LDLINK_TOKEN"),
                         genome_build = c("grch37", "grch38")
                        )
               )
  expect_error(LDexpress(snps = "rs4", pop = "CE", tissue =  c("ADI_SUB", "ADI_VIS_OME"),
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
              )
  expect_error(LDexpress(snps = "rs3", r2d = "r", tissue =  c("ADI_SUB", "ADI_VIS_OME"),
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
               )
  expect_error(LDexpress(snps = "rs4", tissue = "ADI_xxx",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
              )
  })

test_that("ldexpress throws an error when thresholds are outside acceptable range", {
  skip_on_cran()
  skip_on_ci()
  expect_error(LDexpress(snps = "rs4", tissue =  "Adipose_Subcutaneous", r2d_threshold = "99",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
  expect_error(LDexpress(snps = "rs4", tissue =  "Adipose_Subcutaneous", p_threshold = "99",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
  expect_error(LDexpress(snps = "rs4", tissue =  "Adipose_Subcutaneous", win_size = "9999999",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
})

