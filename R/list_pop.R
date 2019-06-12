#' List available reference populations
#'
#' @return a data frame listing the available reference populations, continental (ex: European, African, and Admixed American) and sub-populations (ex: Finnish, Gambian, and Peruvian)
#' @export
#'
#' @examples
#' list_pop()
#'
list_pop <- function() {

  avail_pop <- data.frame("pop_name" = c("All Populations",
                                         "African",
                                         "Yoruba in Ibadan, Nigera",
                                         "Luhya in Webuye, Kenya",
                                         "Gambian in Western Gambia",
                                         "Mende in Sierra Leone",
                                         "Esan in Nigera",
                                         "Americans of African Ancestry in SW USA",
                                         "African Carribbeans in Barbados",
                                         "Ad Mixed American",
                                         "Mexican Ancestry from Los Angeles, USA",
                                         "Puerto Ricans from Puerto Rico",
                                         "Colombians from Medellin, Colombia",
                                         "Peruvians from Lima, Peru",
                                         "East Asian",
                                         "Han Chinese in Bejing, China",
                                         "Japanese in Tokyo, Japan",
                                         "Southern Han Chinese",
                                         "Chinese Dai in Xishuangbanna, China",
                                         "Kinh in Ho Chi Minh City, Vietnam",
                                         "European",
                                         "Utah Residents from North and West Europe",
                                         "Toscani in Italia",
                                         "Finnish in Finland",
                                         "British in England and Scotland",
                                         "Iberian population in Spain",
                                         "South Asian",
                                         "Gujarati Indian from Houston, Texas",
                                         "Punjabi from Lahore, Pakistan",
                                         "Bengali from Bangladesh",
                                         "Sri Lankan Tamil from the UK",
                                         "Indian Telugu from the UK "),
                           "pop_code" = c("ALL", "AFR", "YRI", "LWK",
                                          "GWD", "MSL", "ESN", "ASW",
                                          "ACB", "AMR", "MXL", "PUR",
                                          "CLM", "PEL", "EAS", "CHB",
                                          "JPT", "CHS", "CDX", "KHV",
                                          "EUR", "CEU", "TSI", "FIN",
                                          "GBR", "IBS", "SAS", "GIH",
                                          "PJL", "BEB", "STU", "ITU")
                             )
   return(avail_pop)
}
