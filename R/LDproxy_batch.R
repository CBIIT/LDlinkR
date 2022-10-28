# LDlinkR::LDproxy_batch


#' Query LDproxy using a list of query variants, one per line.
#'
#' @param snp a character string or data frame listing rsID's or chromosome coordinates (e.g. "chr7:24966446"), one per line
#' @param pop a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU"
#' @param r2d either "r2" for LD R2 or "d" for LD D', default = "r2"
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param append A logical. If TRUE, output for each query variant is appended to a text file. If FALSE, output of each query variant is saved in its own text file.
#' Default is FALSE.
#' @param genome_build Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
#' `grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
#' data sets.  Default is GRCh37 (hg19).
#' @param api_root Optional alternative root url for API.
#'
#' @return text file(s) are saved to the current working directory.
#' @importFrom utils write.table
#' @export
#'
#' @examples
#' \dontrun{snps_to_upload <- c("rs3", "rs4")}
#' \dontrun{LDproxy_batch(snp = snps_to_upload, token = Sys.getenv("LDLINK_TOKEN"), append = FALSE)}
#'
LDproxy_batch <- function(snp,
                          pop="CEU",
                          r2d="r2",
                          token=NULL,
                          append = FALSE,
                          genome_build = "grch37",
                          api_root="https://ldlink.nci.nih.gov/LDlinkRest") {

  snp <- as.data.frame(snp)

  if(append == FALSE) {
    for (i in 1:nrow(snp)) {
      myfile <- paste(snp[i,], "_", genome_build, ".txt", sep="")
      cat("\nSubmitting request for query variant ", snp[i,],".", sep = "")
      cat("\nChecking status of server...")
      df_proxy <- LDproxy(snp = snp[i,],
                          pop = pop,
                          r2d = r2d,
                          token = token,
                          genome_build = genome_build,
                          api_root = api_root)
      if(!(grepl("error", df_proxy[1,1])))
      {
        write.table(df_proxy, file = myfile,
                    append = FALSE,
                    quote = FALSE,
                    row.names = TRUE,
                    sep = "\t")
        file_path <- getwd()
        cat("File for query variant ", snp[i,], " saved to:\n ", file_path, "/", myfile,"\n", sep="")
      }
    }
  } else if (append == TRUE) {
    myfile <- paste("combined_query_snp_list_", genome_build, ".txt", sep="")
    for (i in 1:nrow(snp)) {
      cat("\nSubmitting request for query variant ", snp[i,],".", sep = "")
      cat("\nChecking status of server...")
      df_proxy <- LDproxy(snp = snp[i,],
                          pop = pop,
                          r2d = r2d,
                          token = token,
                          genome_build = genome_build,
                          api_root = api_root)
      if(!(grepl("error", df_proxy[1,1])))
      {
        # add new column, query_snp
        df_proxy["query_snp"] <- rep(snp[i,], nrow(df_proxy))
        # rearrange by column index
        df_proxy <- df_proxy[, colnames(df_proxy)[c(ncol(df_proxy), 1:(ncol(df_proxy)-1))]]
        # suppress warning message by write.table about appending
        # column names to file from write.table when append is TRUE
        # issue #2
        suppressWarnings(
        write.table(df_proxy,
                    file = myfile,
                    append = TRUE,
                    quote = FALSE,
                    row.names = TRUE,
                    col.names = !file.exists(myfile),
                    sep = "\t")
              )
      }
    }
    file_path <- getwd()
    cat("Combined file for all query variants saved to:\n", file_path, "/", myfile,"\n", sep="")
  }
}
############################## End Function ##############################
