# LDlinkR::LDhap

########### Secondary Function:  Called by primary function LDhap ##########
df_merge <- function(data_out, table_type, genome_build) {

  ### Count the number of snps listed in data_out ###
  for (i in 1:dim(data_out)[1]) {
    if (substr(data_out[i,], 1, 1)[1]=="#") {
      break
    }
  }
  num_of_snps <- i-1

  ### split data_out into two, then create new data.frames from pieces of these two ###
  # 1
  data_out_var <- data_out[1:num_of_snps,]                                         # create first of new data frames

  # 2
  data_out2 <- data_out[(num_of_snps+2):nrow(data_out),]                           # create second of new data frames
  colnames(data_out2) <- as.character(unlist(data_out2[1,]))                       # assign first row as new column names
  data_out2 <- data_out2[-1,]                                                      # remove first row, no longer needed

  # 3
  if (num_of_snps == 1) {                                                          # when num_of_snps = 1, no need to split column by delimiter
    data_out_hap <- data_out2                                                      # for consistency only
    names(data_out_hap)[1] <- as.character(unlist(data_out_var$RS_Number))         # change column name to match RS_number from data_out_var
    rownames(data_out_hap) <- NULL                                                 # Remove row names
    # return(data_out_hap)

  } else if (num_of_snps > 1) {
    tmp <- strsplit(as.character(data_out2$Haplotype),'_')                              # split first column by delimiter '_', creates a list
    data_out_hap <- with(data_out2, data.frame(t(sapply(tmp, `[`))))                    # create new data.frame, sapply()'s results need to be transposed
    data_out_hap <- cbind(data_out_hap, data_out2[,2:3])                                # combine columns #2 & 3 from data_out w/ data_out_hap
    names(data_out_hap)[1:num_of_snps] <- as.character(unlist(data_out_var$RS_Number))  # change column names to match RS_numbers from data_out_var
    rownames(data_out_hap) <- NULL                                                      # Remove row names
    # return(data_out_hap)
  }

  # Before eval 'table_type' arg, use regex [^<>]+ to change column names of data_out_var
  colnames(data_out_var) <- gsub("Position[^<>]+", paste("Position", genome_build, sep="_"), colnames(data_out_var))
  colnames(data_out_var) <- gsub("Allele[^<>]+", "Allele_Frequency", colnames(data_out_var))

  # Evaluate 'table_type' parameter
  if (table_type == "variant") {
    return(data_out_var)
  } else if (table_type == "haplotype") {
    return(data_out_hap)
  } else if (table_type == "both") {
    # combine data_out_var and data_out_hap into a list
    data_out_both <- list(data_out_var, data_out_hap)
    return(data_out_both)
  } else if (table_type == "merged") {
    # transpose data.frame
    data_out_hap_t <- as.data.frame(t(as.matrix(data_out_hap)))

    # combine haplotypes from data_out_hap_t
    df_all <- cbind(data_out_var, data_out_hap_t[c(1:num_of_snps),c(1:ncol(data_out_hap_t))])

    # remove extra rownames
    # rownames(df_all) <- c()

    # change column names
    names(df_all)[4] <- "Haplotypes"

    # create new data.frame that includes Count & Frequency
    df1 <- data_out_hap_t[(num_of_snps+1):nrow(data_out_hap_t),]
    # change row names to "Haplotype_Count" & "Haplotype Frequency"
    rownames(df1)[rownames(df1) %in%
                    c("Count", "Frequency")] <-
      c("Haplotype_Count", "Haplotype_Frequency")
    # Convert row names into first column
    df1 <- cbind(rownames(df1), data.frame(df1, row.names=NULL))

    # create empty data.frame
    df2 <- data.frame(matrix("   ", nrow = 2, ncol = 2))
    # combine df1 & df2
    df3 <- cbind(df2, df1)

    # row bind new data frame, df3, to df_all
    data_out_merged <- data.frame(mapply(c, df_all, df3))

    # change column names
    names(data_out_merged)[5:ncol(data_out_merged)] <- "  "

    # return data
    return(data_out_merged)
    # End else if
  }

  # End bracket
}
############################## End Sec. Function ##############################


########## Primary Function:  LDhap ##########
#' Calculates population specific haplotype frequencies of all
#' haplotypes observed for a list of query variants.
#'
#' @param snps list of between 1 - 30 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446")
#' @param pop a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU"
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param file Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.
#' @param table_type Choose from one of four options available to determine output
#' format type...`haplotype`, `variant`, `both` and `merged`. Default = "haplotype".
#' @param genome_build Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
#' `grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
#' data sets.  Default is GRCh37 (hg19).
#'
#' @return a data frame or list
#' @importFrom httr GET content stop_for_status http_error
#' @importFrom utils capture.output read.delim write.table
#' @export
#'
#' @examples
#' \dontrun{LDhap(c("rs3", "rs4", "rs148890987"), "CEU", token = Sys.getenv("LDLINK_TOKEN"))}
#' \dontrun{LDhap("rs148890987", c("YRI", "CEU"), token = Sys.getenv("LDLINK_TOKEN"))}
#'
LDhap <- function(snps,
                  pop="CEU",
                  token=NULL,
                  file = FALSE,
                  table_type="haplotype",
                  genome_build = "grch37"
                  ) {


  LD_config <- list(ldhap.url="https://ldlink.nci.nih.gov/LDlinkRest/ldhap",
                    avail_pop=c("YRI","LWK","GWD","MSL","ESN","ASW","ACB",
                                "MXL","PUR","CLM","PEL","CHB","JPT","CHS",
                                "CDX","KHV","CEU","TSI","FIN","GBR","IBS",
                                "GIH","PJL","BEB","STU","ITU",
                                "ALL", "AFR", "AMR", "EAS", "EUR", "SAS"),
             avail_table_type=c("haplotype", "variant", "both", "merged"),
         avail_genome_build = c("grch37", "grch38", "grch38_high_coverage")
  )

  url <- LD_config[["ldhap.url"]]
  avail_pop <- LD_config[["avail_pop"]]
  avail_table_type <- LD_config[["avail_table_type"]]
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
  if(!(length(snps) >= 1 & length(snps) <= 30)) {
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

  if(!(all(table_type %in% avail_table_type))) {
    stop("Not a valid option for table_type.")
  }

  # Ensure input for 'genome_build' is valid.
  if(length(genome_build) > 1) {
    stop("Invalid input.  Please choose only one available genome build.")
  }

  if(!(all(genome_build %in% avail_genome_build))) {
    stop("Not an available genome build.")
  }

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }


  # Request body
  snps_to_upload <- paste(unlist(snps), collapse = "%0A")
  body <- list(paste("snps=", snps_to_upload, sep = ""),
               paste("pop=", pop, sep = ""),
               paste("genome_build=", genome_build, sep = ""),
               paste("token=", token, sep=""))

  # URL query string
  url_str <- paste(url, "?", paste(unlist(body), collapse = "&"), sep="")

  # before 'GET command', check if LDlink server is up and accessible...
  # if server is down pkg should fail gracefully with informative message (not error)
  if (httr::http_error(url)) { # if server is down use message (and not an error)
    message("The LDlink server is down or not accessible. Please try again later.")
    return(NULL)
  } else { # network is up then proceed
    message("\nLDlink server is working...\n")
  }

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
  data_out_hap <- df_merge(data_out, table_type)

  # Evaluate 'file' option
  # File output depends on 'table_type' option selected, opt. 'both' output is returned
  # as a vector/list while the other three options return output as a data.frame. These
  # require different ways to write to file.
  if (file == FALSE) {
    return(data_out_hap)
  } else if (is.character(file)) {
    if (is.data.frame(data_out_hap)) {
      write.table(data_out_hap, file = file, quote = F, row.names = F, sep = "\t")
      cat(paste("\nFile saved to ",file,".\n\n", sep=""))
      return(data_out_hap)
    } else if (is.vector(data_out_hap)) {
      sink(file = file)
      print(data_out_hap)
      sink()
      cat(paste("\nFile saved to ",file,".\n\n", sep=""))
      return(data_out_hap)
    }
  }

}
############################## End Function ##############################

