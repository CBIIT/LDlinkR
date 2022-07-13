context("test-ldhap")

test_that("ldhap throws an error", {
  skip_on_cran()
  expect_error(LDhap(c("r3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
  # invalid genome_build
  expect_error(LDhap(snps <- c("rs3", "rs4"),
                     pop <- "CEU",
                     token <- Sys.getenv("LDLINK_TOKEN"),
                     table_type <- "both",
                     genome_build <-  "grch40"
                     )
               )
  # more than one genome_build
  expect_error(LDhap(snps <- c("rs3", "rs4"),
                     pop <- "CEU",
                     token <- Sys.getenv("LDLINK_TOKEN"),
                     table_type <- "both",
                     genome_build <-  c("grch37", "grch38")
                    )
               )
      })

test_that("ldhap throws an error when `snps` option is NULL", {
 skip_on_cran()
 expect_error(LDhap(snps = NULL, "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldhap throws an error when `table_type` is not a valid option", {
  skip_on_cran()
  expect_error(LDhap(snps = NULL, "CEU", token = Sys.getenv("LDLINK_TOKEN"), table_type = "hap"))
})

test_that("ldhap throws an error, includes a total of 31 snps, exceeds maximum allowed", {
  skip_on_cran()
  snps <- c("rs3", "rs4", "rs346", "rs496202", "rs495325", "rs150920736", "rs639064", "rs35134009",
            "rs349", "rs635759", "rs622702", "rs623441", "rs623009", "rs10586862", "rs7335517", "rs353",
            "rs354", "rs9594490", "rs660670", "rs556780", "rs355", "rs356", "rs542746", "rs358", "rs2314396",
            "rs361", "rs203408", "rs372", "rs375", "rs116799125", "rs201578600"
            )
  expect_error(LDhap(snps = snps, "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldhap works", {
  skip_on_cran()
  expect_named(LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN")))
})

test_that("ldhap works, with one snp, minimum allowed, and `table_type set` to 'variant'", {
  skip_on_cran()
  expect_named(LDhap(snps = "rs3", "YRI", token = Sys.getenv("LDLINK_TOKEN"), table_type = "variant"))
})

test_that("ldhap works, with `table_type` set to 'both', which returns a
            list (a recursive vector) instead of data.frame", {
              skip_on_cran()
              # with `table_type` set to 'both', which returns a list (a recursive vector) instead of data.frame
              expect_vector(LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN"), table_type = "both"))
            })

test_that("ldhap works, with `table_type` set to 'merged'", {
  skip_on_cran()
  expect_named(LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN"), table_type = "merged"))
})
