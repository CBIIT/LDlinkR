# LDlinkR::LDproxy

#' Query LDproxy API
#'
#' @param snp  an rsID or chromosome coordinate (e.g. "chr7:24966446"), one per query
#' @param pop a particular population, (e.g. YRI or CEU), multiple allowed, default=CEU
#' @param r2d r2d, either "r2" for LD R-squared or "d" for LD D-prime, default="r2"
#' @param token token, LDlink provided user token, default = NULL, register for token at: https://ldlink.nci.nih.gov/?tab=apiaccess
#' @param file optional character string naming a path and file
#'
#' @return a data frame
#' @export
#'
#' @examples
#' df_proxy <- LDproxy("rs456", "YRI", "r2", "28da99809470")
#'
LDproxy <- function(snp, pop="CEU", r2d="r2", token=NULL, file = FALSE) {


LD_config <- list(ldproxy.url="https://ldlink.nci.nih.gov/LDlinkRest/ldproxy",
                    avail_pop=c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                                "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                                "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                                "GIH","PJL","BEB","STU","ITU",
                                "ALL", "AFR", "AMR", "EAS", "EUR", "SAS"),
                    avail_ld=c("r2", "d"))


  url <- LD_config[["ldproxy.url"]]
  avail_pop <- LD_config[["avail_pop"]]
  avail_ld <- LD_config[["avail_ld"]]

# ensure file option is a character string
file <- as.character(file)

# Define regular expressions used to check arguments for valid input below
    rsid_pattern <- "^rs\\d{1,}"
     # Syntax               Description
     # ^rs                  rsid starts with 'rs'
     # \\d{1,}              followed by 1 or more digits

    chr_coord_pattern <- "(^chr)(\\d{1,2}|X|x|Y|y):(\\d{8,8})$"
     # Syntax               Description
     # (^chr)               chromosome coordinate starts with 'chr'
     # (\\d{1,2}|X|x|Y|y)   followed by one or two digits, 'X', 'x', 'Y', 'y', to designate chromosome
     # :                    followed by a colon
     # (\\d{8,8})$          followed by 8 digits only to the end of string

# Checking arguments for valid input
  if(!(length(snp) == 1)) {
    stop("Input is one variant only.")
  }

  if(!((grepl(rsid_pattern, snp, ignore.case = TRUE)) | (grepl(chr_coord_pattern, snp, ignore.case = TRUE)))) {
    stop("Invalid query format for variant: ", snp, ".", sep="")
  }

  if(!(all(pop %in% avail_pop))) {
    stop("Not a valid population code.")
  }

  if(length(pop) > 1) {
  	pop=paste(unlist(pop), collapse = "%2B")
  }

  if(!(r2d %in% avail_ld)) {
    stop("Not a valid r2d.  Enter 'r2' or 'd'.")
  }

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }

# Request body
body <- list(paste("var=", snp, sep=""),
             paste("pop=", pop, sep=""),
             paste("r2_d=", r2d, sep=""),
             paste("token=", token, sep=""))

# URL query string
url_str <- paste(url, "?", paste(unlist(body), collapse = "&"), sep="")

# GET command, request to the web server
raw_out <- httr::GET(url=url_str)
httr::stop_for_status(raw_out)
# Parse response object, raw_out
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, sep="\t") # Parse response object

# Check for error in response data
  if(grepl("error", data_out[2,1])) {
    stop(data_out[2,1])
  }

# Evaluate 'file' option
  if (file == FALSE) {
    return(data_out)
  } else if (is.character(file)) {
    write.table(data_out, file = file, quote = F, row.names = F, sep = "\t")
    cat(paste("\nFile saved to ",file,".", sep=""))
    return(data_out)
  }

}
############################## End Function ##############################

