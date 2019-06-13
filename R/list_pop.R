#' List available reference populations
#'
#' @return a data frame listing the available reference populations, continental (ex: European, African, and Admixed American) and sub-populations (ex: Finnish, Gambian, and Peruvian)
#' @export
#'
#' @examples
#' list_pop()
#'
list_pop <- function() {

  avail_pop <- data.frame("pop_code" = c("ALL", "AFR", "YRI", "LWK",
                                         "GWD", "MSL", "ESN", "ASW",
                                         "ACB", "AMR", "MXL", "PUR",
                                         "CLM", "PEL", "EAS", "CHB",
                                         "JPT", "CHS", "CDX", "KHV",
                                         "EUR", "CEU", "TSI", "FIN",
                                         "GBR", "IBS", "SAS", "GIH",
                                         "PJL", "BEB", "STU", "ITU"),
                    "super_pop_code" = c("ALL", rep("AFR", 8), rep("AMR", 5),
                                             rep("EAS", 6), rep("EUR", 6),
                                             rep("SAS", 6)),
                          "pop_name" = c("ALL POPULATIONS",
                                         "AFRICAN",
                                         "Yoruba in Ibadan, Nigera",
                                         "Luhya in Webuye, Kenya",
                                         "Gambian in Western Gambia",
                                         "Mende in Sierra Leone",
                                         "Esan in Nigera",
                                         "Americans of African Ancestry in SW USA",
                                         "African Carribbeans in Barbados",
                                         "AD MIXED AMERICAN",
                                         "Mexican Ancestry from Los Angeles, USA",
                                         "Puerto Ricans from Puerto Rico",
                                         "Colombians from Medellin, Colombia",
                                         "Peruvians from Lima, Peru",
                                         "EAST ASIAN",
                                         "Han Chinese in Bejing, China",
                                         "Japanese in Tokyo, Japan",
                                         "Southern Han Chinese",
                                         "Chinese Dai in Xishuangbanna, China",
                                         "Kinh in Ho Chi Minh City, Vietnam",
                                         "EUROPEAN",
                                         "Utah Residents from North and West Europe",
                                         "Toscani in Italia",
                                         "Finnish in Finland",
                                         "British in England and Scotland",
                                         "Iberian population in Spain",
                                         "SOUTH ASIAN",
                                         "Gujarati Indian from Houston, Texas, USA",
                                         "Punjabi from Lahore, Pakistan",
                                         "Bengali from Bangladesh",
                                         "Sri Lankan Tamil from the UK",
                                         "Indian Telugu from the UK")

                             )
  return(avail_pop)
}
