## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library("LDlinkR")

## ----eval=FALSE----------------------------------------------------------
#  install.packages("LDlinkR")

## ----eval=FALSE----------------------------------------------------------
#  devtools::install_github("CBIIT/LDlinkR")

## ----eval=FALSE----------------------------------------------------------
#  usethis::edit_r_environ()

## ----eval=FALSE----------------------------------------------------------
#  LDLINKR_TOKEN=yourtokenhere123

## ------------------------------------------------------------------------
Sys.getenv("LDLINKR_TOKEN")

## ----eval=FALSE----------------------------------------------------------
#  Sys.getenv("LDLINKR_TOKEN")

## ------------------------------------------------------------------------
LDhap(snps = c("rs3", "rs4", "rs148890987"), 
      pop = "CEU", 
      token = Sys.getenv("LDLINK_TOKEN")
     )

## ------------------------------------------------------------------------
LDhap(snps = c("rs3", "rs4", "rs148890987"),
      pop = c("YRI", "CEU"),
      token = Sys.getenv("LDLINK_TOKEN")
     )

## ------------------------------------------------------------------------
LDmatrix(snps = c("rs496202", "rs11147477", "rs201578600"), 
         pop = "YRI", r2d = "r2", 
         token = Sys.getenv("LDLINK_TOKEN")
        )

## ------------------------------------------------------------------------
LDmatrix(snps = c("chr13:32444611", "rs11147477", "rs201578600"), 
         pop = c("YRI", "CEU"), r2d = "d", 
         token = Sys.getenv("LDLINK_TOKEN")
        )

## ------------------------------------------------------------------------
LDpair(var1 = "rs496202", 
       var2 = "rs11147477", 
       pop = "YRI", 
       token = Sys.getenv("LDLINK_TOKEN"), 
       output = "text"
      )

## ------------------------------------------------------------------------
LDpair(var1 = "rs496202", 
       var2 = "rs11147477", 
       pop = "YRI", 
       token = Sys.getenv("LDLINK_TOKEN")
      )

## ------------------------------------------------------------------------
LDpop(var1 = "rs496202", 
      var2 = "rs11147477", 
      pop = "YRI", 
      r2d = "r2", 
      token = Sys.getenv("LDLINK_TOKEN")
     )

## ------------------------------------------------------------------------
my_proxies <- LDproxy(snp = "rs456", 
                      pop = "YRI", 
                      r2d = "r2", 
                      token = Sys.getenv("LDLINK_TOKEN")
                     )

## ------------------------------------------------------------------------
head(my_proxies)

## ----eval=FALSE----------------------------------------------------------
#  LDproxy_batch(snp = c("rs456", "rs114", "rs127"),
#                token = Sys.getenv("LDLINK_TOKEN")
#               )

## ------------------------------------------------------------------------
my_variants <- read.table("variant_list.txt")
my_variants

## ----eval=FALSE----------------------------------------------------------
#  LDproxy_batch(snp = my_variants,
#                token = Sys.getenv("LDLINK_TOKEN")
#               )

## ------------------------------------------------------------------------
SNPchip(snps = c("rs3", "rs4", "rs148890987"), 
        chip = "ALL", 
        token = Sys.getenv("LDLINK_TOKEN")
       )

## ------------------------------------------------------------------------
SNPchip(snps = c("rs3", "rs4", "rs148890987"), 
        chip = c("A_SNP5.0", "A_CHB2"), 
        token = Sys.getenv("LDLINK_TOKEN")
       )

## ------------------------------------------------------------------------
SNPchip(snps = c("rs3", "rs4", "rs148890987"), 
        chip = "ALL_Affy", 
        token = Sys.getenv("LDLINK_TOKEN")
       )

## ------------------------------------------------------------------------
SNPclip(snps =  c("rs3", "rs4", "rs148890987", "rs115955931"), 
        pop = "YRI", 
        r2_threshold =  "0.1", 
        maf_threshold = "0.01", 
        token = Sys.getenv("LDLINK_TOKEN")
       )

## ------------------------------------------------------------------------
list_chips()

## ------------------------------------------------------------------------
list_pop()

## ------------------------------------------------------------------------
sessionInfo()

