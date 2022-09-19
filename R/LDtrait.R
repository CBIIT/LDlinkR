#' Determine if genomic variants are associated with a trait or disease.
#'
#' Search if a list of variants (or variants in LD with those variants) have been
#' previously associated with a trait or disease. Trait and disease data is updated
#' nightly from the GWAS Catalog (\url{https://www.ebi.ac.uk/gwas/docs/file-downloads}.
#'
#' @param snps between 1 - 50 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446").
#' All input variants must match a bi-allelic variant.
#' @param pop a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU".
#' Use the `list_pop` function to see a list of available human reference populations.
#' @param r2d use "r2" to filter desired output from a threshold based on estimated
#' LD R2 (R squared) or "d" for LD D' (D-prime), default = "r2".
#' @param r2d_threshold R2 or D' (depends on 'r2d' user input parameter) threshold for LD filtering. Any variants
#' within -/+ of the specified genomic window and R^2 or D' less than the threshold will be removed. Value needs
#' to be in the range 0 to 1. Default value is 0.1.
#' @param win_size set genomic window size for LD calculation. Specify a value greater than or equal to zero and less than or
#' equal to 1,000,000bp. Default value is -/+ 500,000 bp.
#' @param token LDlink provided user token, default = NULL, register for token at \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param file Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.
#' @param genome_build Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
#' `grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
#' data sets.  Default is GRCh37 (hg19).
#' @param api_root Optional alternative root url for API.
#'
#' @return A data frame of all query variant RS numbers with a list of queried variants
#' in LD with a variant reported in the GWAS Catalog (\url{https://www.ebi.ac.uk/gwas/docs/file-downloads}.
#' @importFrom httr POST content stop_for_status http_error
#' @importFrom utils capture.output read.delim write.table
#' @export
#'
#' @examples
#' \dontrun{LDtrait(snps = "rs456",
#'                  pop = c("YRI", "CEU"),
#'                  r2d = "r2",
#'                  r2d_threshold = "0.1",
#'                  win_size = "500000",
#'                  token = Sys.getenv("LDLINK_TOKEN")
#'                 )
#'          }
#'
LDtrait <- function(snps,
                    pop = "CEU",
                    r2d = "r2",
                    r2d_threshold = 0.1,
                    win_size = 500000,
                    token = NULL,
                    file = FALSE,
                    genome_build = "grch37",
                    api_root="https://ldlink.nci.nih.gov/LDlinkRest") {

LD_config <- list(ldtrait_url_base = paste0(api_root,"/ldtrait"),
                  avail_pop = c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                                "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                                "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                                "GIH","PJL","BEB","STU","ITU",
                                "ALL", "AFR", "AMR", "EAS", "EUR", "SAS"),
                  avail_ld = c("r2", "d"),
                  avail_genome_build=c("grch37", "grch38", "grch38_high_coverage")
)

ldtrait_url <- LD_config[["ldtrait_url_base"]]
avail_pop <- LD_config[["avail_pop"]]
avail_ld <- LD_config[["avail_ld"]]
avail_genome_build <- LD_config[["avail_genome_build"]]

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
if(!(length(snps) >= 1) & (length(snps) <= 50)) {
  stop("Input is between 1 to 50 variants.")
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
  pop=paste(unlist(pop), collapse = "+")
}

if(!(r2d %in% avail_ld)) {
  stop("Not a valid r2d.  Enter 'r2' or 'd'.")
}

# first, ensure 'r2d_threshold' is type 'numeric'
r2d_threshold <- as.numeric(r2d_threshold)

if (!(r2d_threshold >= 0 & r2d_threshold <= 1)) {
  stop(paste("'r2d' threshold must be between 0 and 1. Threshold input was ", r2d_threshold, ".", sep=""))
} else {
  # convert back to character
  r2d_threshold <- as.character(r2d_threshold)
}

# first, ensure 'win_size' is type 'integer'
win_size <- as.integer(win_size)

if (!(win_size >= 0 & win_size <= 1000000))
{
  stop(paste("Window size must be between 0 and 1000000 bp. Input window size was ", win_size, " bp.", sep=""))
} else {
  # convert back to character
  win_size <- as.character(win_size)
}

if(is.null(token)) {
  stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
}

if(!(is.character(file) | file == FALSE)) {
  stop("Invalid input for file option.")
}

# Ensure input for 'genome_build' is valid.
if(length(genome_build) > 1) {
  stop("Invalid input.  Please choose only one available genome build.")
}

if(!(all(genome_build %in% avail_genome_build))) {
  stop("Not an available genome build.")
}

# Request body
snps_to_upload <- paste(unlist(snps), collapse = "\n")
pop_to_upload <- paste(unlist(pop), collapse = "+")

jsonbody <- list(snps = snps_to_upload,
                 pop = pop_to_upload,
                 r2_d = r2d,
                 r2_d_threshold = r2d_threshold,
                 window = win_size,
                 genome_build = genome_build
                )

# URL string
url_str <- paste(ldtrait_url, "?", "token=", token, sep="")

# before 'POST command', check if LDlink server is up and accessible...
# if server is down pkg should fail gracefully with informative message (not error)
r_url <- httr::POST(ldtrait_url)
if (httr::http_error(r_url)) { # if server is down use message (and not an error)
  message("The LDlink server is down or not accessible. Please try again later.")
  return(NULL)
} else { # network is up then proceed
  message("\nLDlink server is working...\n")
}

# POST command
raw_out <-  httr::POST(url=url_str, body=jsonbody, encode="json")
httr::stop_for_status(raw_out)
# Parse response object
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, sep="\t")

# Check for error/warning in response data
if(sum(grepl("error:", data_out, ignore.case = TRUE), na.rm = TRUE)) {
  # subset rows in data_out that contain text 'error'
  error_msg <- subset(data_out, grepl("error", data_out[,1], ignore.case = TRUE))

  # delete any column names so that they don't go to output
  names(error_msg) <- NULL

  error_msg <- paste(error_msg, collapse = " ")

  stop(error_msg)
}

# Rename LD D-prime column from D. to D'
colnames(data_out)[colnames(data_out)=="D."] <- "D'"

# Replace any number of '.' in column names with '_'
names(data_out) <- gsub(x = names(data_out),
                        pattern = "(\\.)+",
                        replacement = "_")

# Remove last '_' at end of column names
names(data_out) <- gsub(x = names(data_out),
                        # regex pattern for underscore at the end
                        pattern = "_$",
                        replacement = "")

# convert 'factor' to 'character'
data_out[] <- lapply(data_out, as.character)

# Evaluate 'file' option
if (file == FALSE) {
  return(data_out)
} else if (is.character(file)) {
  # `invisible(capture.output())` wrapped around `write.table`function,
  # suppresses output to console
  invisible(capture.output(write.table(data_out,
                                       file = file,
                                       quote = F,
                                       row.names = F,
                                       sep = "\t")
                          )
            )
  cat(paste("\nFile saved to ",file,".\n\n", sep=""))
  return(data_out)
 }

}
############ End Primary Function ##################

