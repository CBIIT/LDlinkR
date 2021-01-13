# Calculates population specific haplotype frequencies of all haplotypes observed for a list of query variants

########### Secondary Function:  Called by primary function LDhap ##########
df_merge <- function(data_out) {

  ### Count the number of snps listed in data_out ###
  for (i in 1:dim(data_out)[1]) {
    if (substr(data_out[i,], 1, 1)[1]=="#") {
      break
    }
  }
  num_of_snps <- i-1

  ### split data_out into two, then create new data.frame from pieces of both ###
  # 1
  data_out1 <- data_out[1:num_of_snps,]                                            # create first of new data frames

  # 2
  data_out2 <- data_out[(num_of_snps+2):nrow(data_out),]                           # create second of new data frames
  colnames(data_out2) <- as.character(unlist(data_out2[1,]))                       # assign first row as new column names
  data_out2 <- data_out2[-1,]                                                      # remove first row, no longer needed

  # 3
  if (num_of_snps == 1) {                                                          # when num_of_snps = 1, no need to split column by delimiter
    data_out_merge <- data_out2                                                    # for consistency
    names(data_out_merge)[1] <- as.character(unlist(data_out1$RS_Number))          # change column name to match RS_number from data_out1
    rownames(data_out_merge) <- NULL                                               # Remove row names
    return(data_out_merge)

  } else if (num_of_snps > 1) {
    tmp <- strsplit(as.character(data_out2$Haplotype),'_')                              # split first column by delimiter '_', creates a list
    data_out_merge <- with(data_out2, data.frame(t(sapply(tmp, `[`))))                  # create new data.frame, sapply()'s results need to be transposed
    data_out_merge <- cbind(data_out_merge, data_out2[,2:3])                            # combine columns #2 & 3 from data_out w/ data_out_merge
    names(data_out_merge)[1:num_of_snps] <- as.character(unlist(data_out1$RS_Number))   # change column names to match RS_numbers from data_out1
    rownames(data_out_merge) <- NULL                                                    # Remove row names
    return(data_out_merge)
  }

}
############################## End Sec. Function ##############################


########## Primary Function:  LDhap ##########
#' Query LDhap API
#'
#' @param snps list of between 1 - 30 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446")
#' @param pop a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU"
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param file Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.
#'
#' @return a data frame
#' @importFrom httr GET content stop_for_status
#' @importFrom utils capture.output read.delim write.table
#' @export
#'
#' @examples
#' \dontrun{LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN"))}
#' \dontrun{LDhap("rs148890987", c("YRI", "CEU"), token = Sys.getenv("LDLINK_TOKEN"))}
#'
LDhap <- function(snps, pop="CEU", token=NULL, file = FALSE) {


LD_config <- list(ldhap.url="https://ldlink.nci.nih.gov/LDlinkRest/ldhap",
                    avail_pop=c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                                "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                                "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                                "GIH","PJL","BEB","STU","ITU",
                                "ALL", "AFR", "AMR", "EAS", "EUR", "SAS")
                              )


url <- LD_config[["ldhap.url"]]
avail_pop <- LD_config[["avail_pop"]]

# ensure file option is a character string
file <- as.character(file)

# Define regular expressions used to check arguments for valid input below
    rsid_pattern <- "^rs\\d{1,}"
    # Syntax               Description
    # ^rs                  rsid starts with 'rs'
    # \\d{1,}              followed by 1 or more digits

    chr_coord_pattern <- "(^chr)(\\d{1,2}|X|x|Y|y):(\\d{1,9})$"
    # Syntax               Description
    # (^chr)               chromosome coordinate starts with 'chr'
    # (\\d{1,2}|X|x|Y|y)   followed by one or two digits, 'X', 'x', 'Y', 'y', to designate chromosome
    # :                    followed by a colon
    # (\\d{1,9})$          followed by 1 to 9 digits only to the end of string


# Checking arguments for valid input
  if(!(length(snps) >= 1) & (length(snps) <= 30)) {
    stop("Input is between 1 to 30 variants only.")
  }

  for(i in 1:length(snps)) {
    if(!((grepl(rsid_pattern, snps[i], ignore.case = TRUE)) | (grepl(chr_coord_pattern, snps[i], ignore.case = TRUE))))  {
      stop(paste("Invalid query format for variant: ",snps[i], ".", sep=""))
    }
  }

  if(!(all(pop %in% avail_pop))) {
    stop("Not a valid population code.")
  }

  if(length(pop) > 1) {
    pop=paste(unlist(pop), collapse = "%2B")
  }

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }


# Request body
snps_to_upload <- paste(unlist(snps), collapse = "%0A")
body <- list(paste("snps=", snps_to_upload, sep=""),
             paste("pop=", pop, sep=""),
             paste("token=", token, sep=""))

# URL query string
url_str <- paste(url, "?", paste(unlist(body), collapse = "&"), sep="")

# GET command, request to the web server
raw_out <- httr::GET(url=url_str)
httr::stop_for_status(raw_out)
# Parse response object, raw_out
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, as.is = T, sep="\t")

# Check for error in response data
  if(grepl("error", data_out[2,1])) {
    stop(data_out[2,1])
  }

# Call function to create a new data.frame by merging data returned from the LDlink web site
data_out_merge <- df_merge(data_out)

# Evaluate 'file' option
  if (file == FALSE) {
    return(data_out_merge)
  } else if (is.character(file)) {
    write.table(data_out_merge, file = file, quote = F, row.names = F, sep = "\t")
    cat(paste("\nFile saved to ",file,".", sep=""))
    return(data_out_merge)
  }

}
############################## End Function ##############################

