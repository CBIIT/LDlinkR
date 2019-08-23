# LDlinkR::SNPchip

##### Function to count rows in data_out that have an rsID #####
count_snps <- function(data_out) {
  rsid_pattern <- "^rs\\d{1,}"
  z <-  sum(grepl(rsid_pattern, data_out$RS.Number, ignore.case = TRUE))
  return(z)
}
########## End Function ##########


############ Function to lookup array name abbreviations ############
array_abbrev <- function(array_name) {
  arrays <- c("Illumina Infinium Human100kv1", "Illumina Human1Mv1",
             "Illumina Human1M-Duov3",	"Illumina HumanHap240S",
             "Illumina HumanHap300v1",	"Illumina HumanHap300-Duov2",
             "Illumina HumanHap550v1",	"Illumina HumanHap550v3",
             "Illumina Human610-Quadv1",	"Illumina HumanHap650Yv3",
             "Illumina Human660W-Quadv1",	"Illumina HumanCNV-12",
             "Illumina HumanCNV370-Duov1",	"Illumina HumanCNV370-Quadv3",
             "Illumina HumanCVDv1",	"Illumina Cardio-MetaboChip",
             "Illumina HumanCore-12v1",	"Illumina HumanCoreExome-12v1",
             "Illumina HumanCoreExome-12v1.1",	"Illumina HumanCoreExome-24v1",
             "Illumina HumanCoreExome-24v1.1",	"Illumina HumanCytoSNP-12v2",
             "Illumina HumanCytoSNP-12v2.1",	"Illumina HumanCytoSNP-12v2.1 FFPE",
             "Illumina Infinium CytoSNP-850K",	"Illumina HumanExome-12v1.1",
             "Illumina HumanExon510Sv1",	"Illumina HumanImmuno-24v1",
             "Illumina HumanImmuno-24v2",	"Illumina HumanLinkage-12",
             "Illumina HumanLinkage-24",	"Illumina Infinium Multi-Ethnic Global-8",
             "Illumina HumanNS-12",	"Illumina HumanOmni1-Quadv1",
             "Illumina HumanOmni1S-8v1",	"Illumina HumanOmni2.5-4v1",
             "Illumina HumanOmni2.5-8v1.2",	"Illumina HumanOmni2.5Exome-8v1",
             "Illumina HumanOmni2.5Exome-8v1.1",	"Illumina HumanOmni2.5Exome-8v1.2",
             "Illumina HumanOmni2.5S-8v1",	"Illumina HumanOmni5-4v1",
             "Illumina HumanOmni5Exome-4v1",	"Illumina HumanOmniExpress-12v1",
             "Illumina HumanOmniExpress-12v1 FFPE",	"Illumina HumanOmniExpress-24v1",
             "Illumina HumanOmniExpressExome-8v1",	"Illumina HumanOmniExpressExome-8v1.1",
             "Illumina HumanOmniExpressExome-8v1.2",	"Illumina HumanOmniExpressExome-8v1.3",
             "Illumina HumanOmniZhongHua-8v1",	"Illumina HumanOmniZhongHua-8v1.1",
             "Illumina HumanOmniZhongHua-8v1.2",	"Illumina Infinium OncoArray-500K",
             "Illumina Infinium PsychArray-24v1",	"Illumina Infinium PsychArray-24v1.1",
             "Affymetrix Mapping 10K Xba142",	"Affymetrix Mapping 250K Nsp",
             "Affymetrix Mapping 250K Sty",	"Affymetrix Mapping 50K Hind240",
             "Affymetrix Mapping 50K Xba240",	"Affymetrix Axiom GW AFR",
             "Affymetrix Axiom GW ASI",	"Affymetrix Axiom GW CHB2",
             "Affymetrix DMET Plus",	"Affymetrix Axiom GW EAS",	"Affymetrix Axiom GW EUR",
             "Affymetrix Axiom Exome 1A",	"Affymetrix Axiom Exome 319",
             "Affymetrix Axiom GW Hu",	"Affymetrix Axiom GW Hu-CHB",
             "Affymetrix Axiom GW LAT",	"Affymetrix OncoScan",	"Affymetrix OncoScan CNV",
             "Affymetrix SNP 5.0",	"Affymetrix SNP 6.0")
  abbrev <- c("I_100",	"I_1M",	"I_1M-D",	"I_240S",	"I_300",	"I_300-D",
              "I_550v1",	"I_550v3",	"I_610-Q",	"I_650Y",	"I_660W-Q",
              "I_CNV-12",	"I_CNV370-D",	"I_CNV370-Q",	"I_CVD",	"I_CardioMetab",
              "I_Core-12",	"I_CoreE-12v1",	"I_CoreE-12v1.1",	"I_CoreE-24v1",
              "I_CoreE-24v1.1",	"I_Cyto-12v2",	"I_Cyto-12v2.1",	"I_Cyto-12v2.1f",
              "I_Cyto850",	"I_Exome-12",	"I_Exon510S",	"I_Immuno-24v1",
              "I_Immuno-24v2",	"I_Linkage-12",	"I_Linkage-24",	"I_ME-Global-8",
              "I_NS-12",	"I_O1-Q",	"I_O1S-8",	"I_O2.5-4",	"I_O2.5-8",	"I_O2.5E-8v1",
              "I_O2.5E-8v1.1",	"I_O2.5E-8v1.2",	"I_O2.5S-8",	"I_O5-4",	"I_O5E-4",
              "I_OE-12",	"I_OE-12f",	"I_OE-24",	"I_OEE-8v1",	"I_OEE-8v1.1",
              "I_OEE-8v1.2",	"I_OEE-8v1.3",	"I_OZH-8v1",	"I_OZH-8v1.1",
              "I_OZH-8v1.2",	"I_OncoArray",	"I_Psyc-24v1",	"I_Psyc-24v1.1",
              "A_10X",	"A_250N",	"A_250S",	"A_50H",	"A_50X",	"A_AFR",	"A_ASI",
              "A_CHB2",	"A_DMETplus",	"A_EAS",	"A_EUR",	"A_Exome1A",	"A_Exome319",
              "A_Hu",	"A_Hu-CHB",	"A_LAT",	"A_Onco",	"A_OncoCNV",	"A_SNP5.0",
              "A_SNP6.0")

  return(abbrev[match(trimws(array_name),arrays)])
}
########## End Function ##########


########### Function to reformat output returned by LDlink ###########
format_tbl <- function(out_raw) {

  snp_count <- count_snps(out_raw)

  out <- out_raw[1:count_snps(out_raw), 1:2]
  colnames(out) <- c("RS_Number", "Position_GRCh37")
  out$Position_GRCh37 <- c(paste("chr", out[,2], sep=""))
  arrays <- as.character(out_raw[1:snp_count,3])

  ### Entries from vairant list not found on any of the selected arrays
  if (!(sum(is.na(out_raw[,3])) == 0)) {
    return(out)
  }
  #############

  for (i in 1:dim(out)[1])
  {
    snp_arrays_i <- strsplit(arrays[i], split=",")[[1]]
    if (!(length(snp_arrays_i) == 0))
       {
        for (j in 1:length(snp_arrays_i))
           {
            array_j <- array_abbrev(snp_arrays_i[j])
            if (!(array_j %in% names(out)))
             {
              out <- data.frame(out,assign(array_j,rep(0,length(arrays))))
              names(out)[length(names(out))] <- array_j
             }
           out[i,match(array_j,names(out))] <- 1
           }
        }
     }
  return(out)
}
##### end function #####


############ Begin Primary Function ##################
#' Query SNPchip API
#'
#' @param snps between 1 - 5,000 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446")
#' @param chip chip or arrays, platform code(s) for a SNP chip array, ALL_Illumina, ALL_Affy or ALL, default=ALL
#' @param token LDlink provided user token, default = NULL, register for token at  \url{https://ldlink.nci.nih.gov/?tab=apiaccess}
#' @param file Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.
#'
#' @return a data frame
#' @importFrom httr POST content stop_for_status
#' @importFrom utils capture.output read.delim write.table
#' @export
#'
#' @examples
#' \dontrun{SNPchip(c("rs3", "rs4", "rs148890987"), "ALL",
#'                  token = Sys.getenv("LDLINK_TOKEN"))
#'                }
#' \dontrun{SNPchip(c("rs3", "rs4", "rs148890987"),
#'                  c("A_CHB2", "A_SNP5.0"),
#'                  token = Sys.getenv("LDLINK_TOKEN"))
#'                  }
#' \dontrun{SNPchip("rs148890987", "ALL_Affy", token = Sys.getenv("LDLINK_TOKEN"))}
#'
SNPchip <- function(snps, chip="ALL", token=NULL, file = FALSE) {

LD_config <- list(snpchip_url_base="https://ldlink.nci.nih.gov/LDlinkRest/snpchip",
                  avail_chip=c("I_100","I_1M","I_1M-D","I_240S","I_300","I_300-D","I_550v1",
                               "I_550v3","I_610-Q","I_650Y","I_660W-Q","I_CNV-12","I_CNV370-D",
                               "I_CNV370-Q","I_CVD","I_CardioMetab","I_Core-12","I_CoreE-12v1",
                               "I_CoreE-12v1.1","I_CoreE-24v1","I_CoreE-24v1.1","I_Cyto-12v2",
                               "I_Cyto-12v2.1","I_Cyto-12v2.1f","I_Cyto850","I_Exome-12",
                               "I_Exon510S","I_Immuno-24v1","I_Immuno-24v2","I_Linkage-12",
                               "I_Linkage-24","I_ME-Global-8","I_NS-12","I_O1-Q","I_O1S-8",
                               "I_O2.5-4","I_O2.5-8","I_O2.5E-8v1","I_O2.5E-8v1.1","I_O2.5E-8v1.2",
                               "I_O2.5S-8","I_O5-4","I_O5E-4","I_OE-12","I_OE-12f","I_OE-24",
                               "I_OEE-8v1","I_OEE-8v1.1","I_OEE-8v1.2","I_OEE-8v1.3","I_OZH-8v1",
                               "I_OZH-8v1.1","I_OZH-8v1.2","I_OncoArray","I_Psyc-24v1","I_Psyc-24v1.1",
                               "A_10X","A_250N","A_250S","A_50H","A_50X","A_AFR","A_ASI","A_CHB2",
                               "A_DMETplus","A_EAS","A_EUR","A_Exome1A","A_Exome319","A_Hu","A_Hu-CHB",
                               "A_LAT","A_Onco","A_OncoCNV","A_SNP5.0","A_SNP6.0", "ALL_Illumina",
                               "ALL_Affy", "ALL")
                             )


url <- LD_config[["snpchip_url_base"]]
avail_chip <- LD_config[["avail_chip"]]

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
  if(!(length(snps) >= 1) & (length(snps) <= 1000)) {
    stop("Input is between 2 to 1000 variants.")
  }

  for(i in 1:length(snps)) {
    if(!((grepl(rsid_pattern, snps[i], ignore.case = TRUE)) | (grepl(chr_coord_pattern, snps[i], ignore.case = TRUE))))  {
      stop(paste("Invalid query format for variant: ",snps[i], ".", sep=""))
    }
  }

  if(!(all(chip %in% avail_chip))) {
    stop("Invalid SNP chip array platorm code.")
  }

  if(is.null(token)) {
    stop("Enter valid access token. Please register using the LDlink API Access tab: https://ldlink.nci.nih.gov/?tab=apiaccess")
  }

  if(!(is.character(file) | file == FALSE)) {
    stop("Invalid input for file option.")
  }

# When 'chip' is 'ALL'
if (length(chip) == 1) {
   if (chip == "ALL") {
     chip <- avail_chip[1:76]
   } else if (chip == "ALL_Illumina") {
     chip <- avail_chip[1:56]
   } else if (chip == "ALL_Affy") {
     chip <- avail_chip[57:76]
   }
}

# Request body
snps_to_upload <- paste(unlist(snps), collapse = "\n")
chip_to_upload <- paste(unlist(chip), collapse = "+")
jsonbody <- list(snps=snps_to_upload, platforms=chip_to_upload)

# URL string
url_str <- paste(url, "?", "token=", token, sep="")

# POST command
raw_out <-  httr::POST(url=url_str, body=jsonbody, encode="json")
httr::stop_for_status(raw_out)
# Parse response object
data_out <- read.delim(textConnection(httr::content(raw_out, "text", encoding = "UTF-8")), header=T, sep="\t")
# convert 'factor' to 'character'
data_out[] <- lapply(data_out, as.character)

# Count number of SNPs returned by SNPchip
snp_count <- count_snps(data_out)

# Check for 'error' in response data and print message
  if (grepl("error", data_out[snp_count+1,1], ignore.case = TRUE)) {
    stop(data_out[snp_count+1,1])
  }

# Check for 'warning' in response data and print message
  if (grepl("warning", data_out[(snp_count+1), 1], ignore.case = TRUE)) {
    message(data_out[(snp_count+1),1], "\n")

    # when 'warning' message continues to a second line.
    if (nrow(data_out) > snp_count+1) {
    message(data_out[nrow(data_out), 1], "\n")
    }
  }

# Call function to reformat 'data_out'
format_data_out <- format_tbl(data_out)

# Evaluate 'file' option
  if (file == FALSE) {
    return(format_data_out)
  } else if (is.character(file)) {
    print(format_data_out)
    write.table(format_data_out, file = file, quote = F, row.names = F, sep = "\t")
    cat(paste("\nFile saved to ",file,".", sep=""))
    return(format_data_out)
  }

}
############ End Primary Function ##################

