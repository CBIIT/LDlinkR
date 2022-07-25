## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
# library("LDlinkR")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("LDlinkR")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("remotes")
#  remotes::install_github("CBIIT/LDlinkR")

## ----eval=FALSE---------------------------------------------------------------
#  library(LDlinkR)

## ---- eval=FALSE--------------------------------------------------------------
#  LDhap(snps = c("rs3", "rs4", "rs148890987"),
#        pop = "YRI",
#        token = "YourTokenHere123")

## ----eval=FALSE---------------------------------------------------------------
#  usethis::edit_r_environ()

## ----eval=FALSE---------------------------------------------------------------
#  LDLINK_TOKEN=YourTokenHere123

## ----eval = FALSE-------------------------------------------------------------
#  Sys.getenv("LDLINK_TOKEN")

## ----eval=FALSE---------------------------------------------------------------
#  Sys.getenv("LDLINK_TOKEN")

## ----eval=FALSE---------------------------------------------------------------
#  LDexpress(snps,
#            pop = "CEU",
#            tissue = "ALL",
#            r2d = "r2",
#            r2d_threshold = 0.1,
#            p_threshold = 0.1,
#            win_size = 500000,
#            genome_build = "grch37",
#            token = NULL,
#            file = FALSE
#           )

## ----eval=FALSE---------------------------------------------------------------
#  my_output <- LDexpress(snps = "rs4",
#                         pop = c("YRI", "CEU"),
#                         tissue =  c("ADI_SUB", "ADI_VIS_OME"),
#                         win_size = "500000",
#                         token = Sys.getenv("LDLINK_TOKEN")
#                        )

## ----eval=FALSE---------------------------------------------------------------
#  head(my_output)

## ----eval=FALSE---------------------------------------------------------------
#  my_output <- LDexpress(snps = c("rs345", "rs456"),
#                         pop = "YRI",
#                         tissue =  "Adipose_Visceral_Omentum",
#                         genome_build = "grch38",
#                         token = Sys.getenv("LDLINK_TOKEN")
#                        )

## ----eval=FALSE---------------------------------------------------------------
#  head(my_output)

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs3", "rs4", "rs148890987"),
#        pop = "CEU",
#        token = Sys.getenv("LDLINK_TOKEN"),
#        genome_build = "grch38_high_coverage"
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs3", "rs4", "rs148890987"),
#        pop = c("YRI", "CEU"),
#        token = Sys.getenv("LDLINK_TOKEN")
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs660670", "rs556780", "rs355", "rs356", "rs542746"),
#        pop = "CEU",
#        token = Sys.getenv("LDLINK_TOKEN"),
#        table_type = "merged",
#        genome_build = "grch38"
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs660670", "rs556780", "rs355", "rs356", "rs542746"),
#        pop = "CEU",
#        token = Sys.getenv("LDLINK_TOKEN"),
#        table_type = "both"
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDmatrix(snps = c("rs496202", "rs11147477", "rs201578600"),
#           pop = "YRI",
#           r2d = "r2",
#           token = Sys.getenv("LDLINK_TOKEN"),
#           genome_build = "grch38"
#          )

## ----eval=FALSE---------------------------------------------------------------
#  LDmatrix(snps = c("chr13:32444611", "rs11147477", "rs201578600"),
#           pop = c("YRI", "CEU"),
#           r2d = "d",
#           token = Sys.getenv("LDLINK_TOKEN")
#          )

## -----------------------------------------------------------------------------
my_variants <- read.table("variant_list.txt")
my_variants

## ----eval=FALSE---------------------------------------------------------------
#  LDmatrix(snps = my_variants[,1],
#           pop = c("YRI", "CEU"), r2d = "d",
#           token = Sys.getenv("LDLINK_TOKEN")
#          )

## ----eval=FALSE---------------------------------------------------------------
#  LDpair(var1 = "rs496202",
#         var2 = "rs11147477",
#         pop = "YRI",
#         token = Sys.getenv("LDLINK_TOKEN"),
#         output = "text",
#         genome_build = "grch38"
#        )

## ----eval=FALSE---------------------------------------------------------------
#  LDpair(var1 = "rs496202",
#         var2 = "rs11147477",
#         pop = "YRI",
#         token = Sys.getenv("LDLINK_TOKEN"),
#         genome_build = "grch38"
#        )

## ----eval=FALSE---------------------------------------------------------------
#  LDpop(var1 = "rs496202",
#        var2 = "rs11147477",
#        pop = "YRI",
#        r2d = "r2",
#        token = Sys.getenv("LDLINK_TOKEN"),
#        genome_build = "grch38_high_coverage"
#       )

## ----eval=FALSE---------------------------------------------------------------
#  my_proxies <- LDproxy(snp = "rs456",
#                        pop = "YRI",
#                        r2d = "r2",
#                        token = Sys.getenv("LDLINK_TOKEN")
#                       )

## ----eval=FALSE---------------------------------------------------------------
#  head(my_proxies)

## ----eval=FALSE---------------------------------------------------------------
#  LDproxy_batch(snp = c("rs456", "rs114", "rs127"),
#                token = Sys.getenv("LDLINK_TOKEN")
#               )

## -----------------------------------------------------------------------------
my_variants <- read.table("variant_list.txt")
my_variants

## ----eval=FALSE---------------------------------------------------------------
#  LDproxy_batch(snp = my_variants,
#                token = Sys.getenv("LDLINK_TOKEN")
#               )

## ----eval=FALSE---------------------------------------------------------------
#  LDtrait(snps,
#          pop = "CEU",
#          r2d = "r2",
#          r2d_threshold = 0.1,
#          win_size = 500000,
#          token = NULL,
#          file = FALSE,
#          genome_build = "grch37"
#         )

## ----eval=FALSE---------------------------------------------------------------
#  LDtrait(snps = "rs456",
#          pop = c("YRI", "CEU"),
#          token = Sys.getenv("LDLINK_TOKEN"),
#          genome_build = "grch38"
#         )

## ----eval=FALSE---------------------------------------------------------------
#  LDtrait(snps = c("rs114", "rs496202", "rs345"),
#          pop = c("YRI", "CHB", "CEU"),
#          win_size = "750000",
#          token = Sys.getenv("LDLINK_TOKEN")
#         )

## ----eval=FALSE---------------------------------------------------------------
#  SNPchip(snps = c("rs3", "rs4", "rs148890987"),
#          chip = "ALL",
#          token = Sys.getenv("LDLINK_TOKEN")
#         )

## ----eval=FALSE---------------------------------------------------------------
#  SNPchip(snps = c("rs3", "rs4", "rs148890987"),
#          chip = c("A_SNP5.0", "A_CHB2"),
#          token = Sys.getenv("LDLINK_TOKEN"),
#          genome_build = "grch38"
#         )

## ----eval=FALSE---------------------------------------------------------------
#  SNPchip(snps = c("rs3", "rs4", "rs148890987"),
#          chip = "ALL_Affy",
#          token = Sys.getenv("LDLINK_TOKEN")
#         )

## ----eval=FALSE---------------------------------------------------------------
#  SNPclip(snps =  c("rs3", "rs4", "rs148890987", "rs115955931"),
#          pop = "YRI",
#          r2_threshold =  "0.1",
#          maf_threshold = "0.01",
#          token = Sys.getenv("LDLINK_TOKEN"),
#          genome_build = "grch37"
#         )

## ----eval=FALSE---------------------------------------------------------------
#  list_chips()

## ----eval=FALSE---------------------------------------------------------------
#  list_pop()

## ---- echo=FALSE----------------------------------------------------------------------------------
options(width = 100)

## ----eval=FALSE-----------------------------------------------------------------------------------
#  list_gtex_tissues()

## ----eval = FALSE---------------------------------------------------------------------------------
#  df <- LDproxy(snp = "rs456", pop = "YRI", token = "123abc456789")

## ----eval=FALSE-----------------------------------------------------------------------------------
#  df <- LDproxy("rs12027135", pop = "CEU",r2d = "r2", token = "YourTokenHere123")
#  new_df <- subset(df, R2 >= 0.8)

## ----eval=FALSE-----------------------------------------------------------------------------------
#  test <- read.table("variant_list.txt", header = FALSE)
#  LDmatrix(snps = test, pop = "CEU", r2d = "r2", token = "YourTokenHere123")

## ----eval=FALSE-----------------------------------------------------------------------------------
#  test <- read.table("variant_list.txt", header = FALSE)
#  LDmatrix(snps = test[,1], pop = "CEU", r2d = "r2", token = "YourTokenHere123")

## -------------------------------------------------------------------------------------------------
sessionInfo()

