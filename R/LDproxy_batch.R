# LDlinkR::LDproxy_batch


#' Query LDproxy using a list of query variants, one per line.
#'
#' @param snp a character string or data frame listing rsID's or chromosome coordinates (e.g. "chr7:24966446"), one per line
#' @param pop a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU"
#' @param r2d either "r2" for LD R2 or "d" for LD D', default = "r2"
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param append A logical. If TRUE, output for each query variant is appended to a text file. If FALSE, output of each query variant is saved in its own text file.
#' Default is FALSE.
#' @return text file(s) are saved to the current working directory.
#' @importFrom utils write.table
#' @export
#'
#' @examples
#' \dontrun{snps_to_upload <- c("rs3", "rs4")}
#' \dontrun{LDproxy_batch(snp = snps_to_upload, token = Sys.getenv("LDLINK_TOKEN"), append = FALSE)}
#'
LDproxy_batch <- function(snp, pop="CEU", r2d="r2", token=NULL, append = FALSE) {

  snp <- as.data.frame(snp)

  if(append == FALSE) {
    for (i in 1:nrow(snp)) {
      myfile <- paste(snp[i,], ".txt", sep="")
      df_proxy <- LDproxy(snp=snp[i,], pop, r2d, token)
      if(!(grepl("error", df_proxy[1,1])))
      {
        write.table(df_proxy, file = myfile,
                    append = FALSE,
                    quote = FALSE,
                    row.names = TRUE,
                    sep = "\t")
      }
    }
  } else if (append == TRUE) {
    for (i in 1:nrow(snp)) {
      df_proxy <- LDproxy(snp=snp[i,], pop, r2d, token)
      if(!(grepl("error", df_proxy[1,1])))
      {
        # add new column, query_snp
        df_proxy["query_snp"] <- rep(snp[i,], nrow(df_proxy))
        # rearrange by column index
        df_proxy <- df_proxy[, colnames(df_proxy)[c(11, 1:10)]]
        # suppress warning message by write.table about appending
        # column names to file from write.table when append is TRUE
        # issue #2
        suppressWarnings(
        write.table(df_proxy, file = "combined_query_snp_list.txt",
                    append = TRUE,
                    quote = FALSE,
                    row.names = TRUE,
                    col.names = !file.exists("combined_query_snp_list.txt"),
                    sep = "\t")
              )
      }
    }
  }
}
############################## End Function ##############################
