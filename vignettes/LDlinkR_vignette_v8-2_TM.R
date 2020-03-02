## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library("LDlinkR")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("LDlinkR")

## ----eval=FALSE---------------------------------------------------------------
#  devtools::install_github("CBIIT/LDlinkR")

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

## -----------------------------------------------------------------------------
Sys.getenv("LDLINK_TOKEN")

## ----eval=FALSE---------------------------------------------------------------
#  Sys.getenv("LDLINK_TOKEN")

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs3", "rs4", "rs148890987"),
#        pop = "CEU",
#        token = Sys.getenv("LDLINK_TOKEN")
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDhap(snps = c("rs3", "rs4", "rs148890987"),
#        pop = c("YRI", "CEU"),
#        token = Sys.getenv("LDLINK_TOKEN")
#       )

## ----eval=FALSE---------------------------------------------------------------
#  LDmatrix(snps = c("rs496202", "rs11147477", "rs201578600"),
#           pop = "YRI", r2d = "r2",
#           token = Sys.getenv("LDLINK_TOKEN")
#          )

## ----eval=FALSE---------------------------------------------------------------
#  LDmatrix(snps = c("chr13:32444611", "rs11147477", "rs201578600"),
#           pop = c("YRI", "CEU"), r2d = "d",
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
#         output = "text"
#        )

## ----eval=FALSE---------------------------------------------------------------
#  LDpair(var1 = "rs496202",
#         var2 = "rs11147477",
#         pop = "YRI",
#         token = Sys.getenv("LDLINK_TOKEN")
#        )

## ----eval=FALSE---------------------------------------------------------------
#  LDpop(var1 = "rs496202",
#        var2 = "rs11147477",
#        pop = "YRI",
#        r2d = "r2",
#        token = Sys.getenv("LDLINK_TOKEN")
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
#  SNPchip(snps = c("rs3", "rs4", "rs148890987"),
#          chip = "ALL",
#          token = Sys.getenv("LDLINK_TOKEN")
#         )

## ----eval=FALSE---------------------------------------------------------------
#  SNPchip(snps = c("rs3", "rs4", "rs148890987"),
#          chip = c("A_SNP5.0", "A_CHB2"),
#          token = Sys.getenv("LDLINK_TOKEN")
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
#          token = Sys.getenv("LDLINK_TOKEN")
#         )

## -----------------------------------------------------------------------------
list_chips()

## -----------------------------------------------------------------------------
list_pop()

## ----eval = FALSE-------------------------------------------------------------
#  df <- LDproxy(snp = "rs456", pop = "YRI", token = "123abc456789")

## ----eval=FALSE---------------------------------------------------------------
#  df <- LDproxy("rs12027135", pop = "CEU",r2d = "r2", token = "YourTokenHere123")
#  new_df <- subset(df, R2 >= 0.8)

## ----eval=FALSE---------------------------------------------------------------
#  test <- read.table("variant_list.txt", header = FALSE)
#  LDmatrix(snps = test, pop = "CEU", r2d = "r2", token = "YourTokenHere123")

## ----eval=FALSE---------------------------------------------------------------
#  test <- read.table("variant_list.txt", header = FALSE)
#  LDmatrix(snps = test[,1], pop = "CEU", r2d = "r2", token = "YourTokenHere123")

## ----eval=TRUE, echo=FALSE----------------------------------------------------
test <- read.table("variant_list.txt", header = FALSE)
LDmatrix(snps = test[,1], pop = "CEU", r2d = "r2", token = Sys.getenv("LDLINKR_TOKEN"))

## -----------------------------------------------------------------------------
sessionInfo()

