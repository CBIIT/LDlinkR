# LDlinkR::LDpair

# This function queries the LDlink > LDpair web tool using two RS numbers and a population(s) as input
# and returns a data frame with the results.
# arg1:  the first RS number or genomic coordinate (e.g. "chr7:24966446")
# arg2:  the second RS number or genomic coordinate (e.g. "ch7:24966446")
# arg3:  pop, a particular population(s), (e.g. YRI or CEU), multiple allowed, default=CEU
# arg4:  token, LDlink provided user token, default = NULL, register for token at: https://ldlink.nci.nih.gov/?tab=apiaccess
# arg5:  output, two output options available, "text" or "table", default = "table"
# arg6:  optional character string naming a path and file


########## Function for Output option "Table" ##############
table_out <- function (data_out) {
# Tidy up data_out
z <- strsplit(data_out[,1], "\\s+")

# Create new 'table' from elements of data_out
df_pair_tbl <- data.frame(var1 = z[[1]][1],
                          var2 = z[[2]][1],
                          pops = z[[3]][1],
                          var1_pos = substr(z[[1]][2], 2, (nchar(z[[1]][2]))-1),
                          var2_pos = substr(z[[2]][2], 2, (nchar(z[[2]][2]))-1),
                          var1_a1 = z[[7]][2],
                          var1_a2 = z[[9]][2],
                          var1_a1_freq = as.numeric(substr(z[[7]][9], 2, (nchar(z[[7]][9]))-1)),
                          var1_a2_freq = as.numeric(substr(z[[9]][9], 2, (nchar(z[[9]][9]))-1)),
                          var2_a1 = z[[5]][2],
                          var2_a2 = z[[5]][3],
                          var2_a1_freq = as.numeric(substr(z[[12]][2], 2, (nchar(z[[12]][2]))-1)),
                          var2_a2_freq = as.numeric(substr(z[[12]][3], 2, (nchar(z[[12]][3]))-1)),
                          d_prime = as.numeric(z[[17]][3]),
                          r2 = as.numeric(z[[18]][3]),
                          chisq = as.numeric(z[[19]][3]),
                          p_val = as.numeric(substr(z[[20]][3], 2, (nchar(z[[20]][3])))),
                        stringsAsFactors = FALSE
                        )

if (grepl("warning", z[[22]][1], ignore.case = TRUE))  {
      # Add these two columns to df_pair_tbl, if there is a "warning" message in data_out
      df_pair_tbl$ld <- paste(z[[21]], collapse = " ")
      df_pair_tbl$note <- paste(z[[22]], collapse = " ")

  } else {
      # Used if no "warning" message in data_out
      df_pair_tbl$corr_alleles <- paste(z[[21]][1], "-", z[[21]][6], ", ", z[[22]][1], "-", z[[22]][6], sep="")
    }

 return(df_pair_tbl)
}
################ End Function ##############################


###### Primary Function #######
LDpair <- function(var1, var2, pop = "CEU", token=NULL, output = "table", file = FALSE) {

LD_config <- list(ldpair_url="https://ldlink.nci.nih.gov/LDlinkRest/ldpair",
                  avail_pop=c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                              "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                              "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                              "GIH","PJL","BEB","STU","ITU",
                              "ALL", "AFR", "AMR", "EAS", "EUR", "SAS"),
                  avail_output=c("text", "table")
                 )


  url <- LD_config[["ldpair_url"]]
  avail_pop <- LD_config[["avail_pop"]]
  avail_output <- LD_config[["avail_output"]]

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

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }

  if(!(all(output %in% avail_output))) {
    stop("Not a valid output option. Please specify either \"text\" or \"table\".")
  }

  if(!(is.character(file) | file == FALSE)) {
    stop("Invalid input for file option.")
  }


# Request body
# snps_to_upload <- paste(unlist(snps), collapse = "%0A")
pop_to_upload <- paste(unlist(pop), collapse = "%2B")
body <- list(paste("var1=", var1, sep=""),
             paste("var2=", var2, sep=""),
             paste("pop=", pop_to_upload, sep=""),
             paste("token=", token, sep=""))

# URL query string
url_str <- paste(url, "?", paste(unlist(body), collapse = "&"), sep="")

# GET command, request to the web server
raw_out <- httr::GET(url=url_str)
httr::stop_for_status(raw_out)
# Parse response object from web server
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, as.is = T, sep="\t")

# Check for error/warning in parsed response object
  if(grepl("error", data_out[2,1])) {
    stop(data_out[2,1])
  }

  if(grepl("WARNING", data_out[22,])) {
    message(data_out[22,])
  }

# Evaluate 'output' option for either "text" or "table"
  if(output == "text") {
    if(file == FALSE) {
      cat(content(raw_out, "text"))
    } else if (is.character(file)) {
      cat(content(raw_out, "text"))
      writeLines(capture.output(cat(content(raw_out, "text"))), file)
      cat(paste("\nFile saved to ",file,".", sep=""))
     }
  } else if (output == "table") {
    if(file == FALSE) {
      data_out_tbl <- table_out(data_out)
      return(data_out_tbl)
    } else if (is.character(file)) {
      data_out_tbl <- table_out(data_out)
      print(data_out_tbl)
      write.table(data_out_tbl, file = file, quote = F, row.names = F, sep = "\t")
      cat(paste("\nTable saved to ",file,".", sep=""))
      return(data_out_tbl)
    }
  }

}
############ End Primary Function ##################


