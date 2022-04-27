# LDlinkR::LDpop

#' Investigates allele frequencies and linkage disequilibrium
#' patterns across 1000 Genomes Project populations.
#'
#' @param var1 the first RS number or genomic coordinate (e.g. "chr7:24966446")
#' @param var2 the second RS number or genomic coordinate (e.g. "ch7:24966446")
#' @param pop a 1000 Genomes Project population(s), (e.g. YRI or CEU), multiple allowed, default = "CEU"
#' @param r2d either "r2" for LD R2 or "d" for LD D', default = "r2"
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param file Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.
#' @param genome_build Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
#' `grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
#' data sets.  Default is GRCh37 (hg19).
#'
#' @return a data frame
#' @importFrom httr GET content stop_for_status http_error
#' @importFrom utils capture.output read.delim write.table
#' @export
#'
#' @examples
#' \dontrun{LDpop(var1 = "rs3", var2 = "rs4",
#'                pop = "YRI", r2d = "r2",
#'                token = Sys.getenv("LDLINK_TOKEN"))
#'              }
#'
LDpop <- function(var1,
                  var2,
                  pop = "CEU",
                  r2d="r2",
                  token=NULL,
                  file = FALSE,
                  genome_build = "grch37") {

LD_config <- list(ldpop_url="https://ldlink.nci.nih.gov/LDlinkRest/ldpop",
                  avail_pop=c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                                "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                                "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                                "GIH","PJL","BEB","STU","ITU",
                                "ALL", "AFR", "AMR", "EAS", "EUR", "SAS"),
                  avail_ld=c("r2", "d"),
       avail_genome_build = c("grch37", "grch38", "grch38_high_coverage"))


  url <- LD_config[["ldpop_url"]]
  avail_pop <- LD_config[["avail_pop"]]
  avail_ld <- LD_config[["avail_ld"]]
  avail_genome_build <- LD_config[["avail_genome_build"]]

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
  if(!(length(var1) == 1)) {
    stop("Input one SNP for Variant 1 only.")
  }

  if(!(length(var2) == 1)) {
    stop("Input one SNP for Variant 2 only.")
  }

  if(!((grepl(rsid_pattern, var1, ignore.case = TRUE)) | (grepl(chr_coord_pattern, var1, ignore.case = TRUE)))) {
    stop(paste("Invalid query SNP format for Variant 1: ",var1,".", sep=""))
  }

  if(!((grepl(rsid_pattern, var2, ignore.case = TRUE)) | (grepl(chr_coord_pattern, var2, ignore.case = TRUE)))) {
    stop(paste("Invalid query SNP format for Variant 2: ",var2,".", sep=""))
  }

  if(!(all(pop %in% avail_pop))) {
    stop("Not a valid population code.")
  }

  if(!(r2d %in% avail_ld)) {
    stop("Not a valid r2d.  Enter 'r2' or 'd'.")
  }

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }

  # Ensure input for 'genome_build' is valid.
  if(length(genome_build) > 1) {
    stop("Invalid input.  Please choose only one available genome build.")
  }

  if(!(all(genome_build %in% avail_genome_build))) {
    stop("Not an available genome build.")
  }

# Request body
# snps_to_upload <- paste(unlist(snps), collapse = "%0A")
pop_to_upload <- paste(unlist(pop), collapse = "%2B")
body <- list(paste("var1=", var1, sep=""),
             paste("var2=", var2, sep=""),
             paste("pop=", pop_to_upload, sep=""),
             paste("r2_d=", r2d, sep=""),
             paste("genome_build=", genome_build, sep=""),
             paste("token=", token, sep=""))

# URL query string
url_str <- paste(url, "?", paste(unlist(body), collapse = "&"), sep="")

# before 'GET' command', check if LDlink server is up and accessible...
# if server is down pkg should fail gracefully with informative message (not error)
if (httr::http_error(url)) { # if server is down use message (and not an error)
  message("The LDlink server is down or not accessible. Please try again later.")
  return(NULL)
} else { # network is up then proceed
  message("\nLDlink server is working...\n")
}

# GET command, send request to the web server
raw_out <- httr::GET(url=url_str)
httr::stop_for_status(raw_out)
# Parse response object from web server
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, as.is = T, sep="\t")

# Rename LD D-prime column from D. to D'
colnames(data_out)[colnames(data_out)=="D."] <- "D'"
# edit chromosome coordinate, if needed
names(data_out) <- sub(x = names(data_out),
                       pattern = "(?<=chr\\d|chr\\d\\d|chrX|chrY)\\.",
                       replacement = ":",
                       ignore.case = TRUE,
                       perl = TRUE)
# Convert any number of '.' and replace with '_'
names(data_out) <- gsub(x = names(data_out),
                      pattern = "(\\.)+",
                      replacement = "_")

# Check for error/warning in response data
if(sum(grepl("error", data_out, ignore.case = TRUE), na.rm = TRUE)) {
  # subset rows in data_out that contain text 'error'
  error_msg <- subset(data_out, grepl("error", data_out[,1], ignore.case = TRUE))

  # delete any column names so that they don't go to output
  names(error_msg) <- NULL

  error_msg <- paste(error_msg, collapse = " ")

  stop(error_msg)
}

if(sum(grepl("WARNING", data_out, ignore.case = TRUE), na.rm = TRUE)) {
  # subset rows in data_out that contain text 'error'
  warning_msg <- subset(data_out, grepl("WARNING", data_out[,1], ignore.case = TRUE))

  # delete any column names so that they don't go to output
  names(warning_msg) <- NULL

  warning_msg <- paste(warning_msg, collapse = " ")

  message(warning_msg)
}

# Evaluate 'file' option
  if (file == FALSE) {
    return(data_out)
  } else if (is.character(file)) {
    write.table(data_out, file = file, quote = F, row.names = F, sep = "\t")
    cat(paste("\nFile saved to ",file,".", "\n\n", sep=""))
    return(data_out)
  }

}
############ End Primary Function ##################
