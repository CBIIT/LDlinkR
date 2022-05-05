#' Provides a data frame listing the names and abbreviation codes
#' for available commercial SNP Chip Arrays from Illumina and Affymetrix.
#'
#' @return a data frame listing the names and abbreviation codes for available SNP Chip Arrays from Illumina and Affymetrix
#' @export
#'
#' @examples
#' list_chips()
list_chips <- function() {

  avail_chips <- data.frame("chip_code" = c("I_100",	"I_1M",	"I_1M-D",	"I_240S",	"I_300",	"I_300-D",
                                            "I_550v1",	"I_550v3",	"I_610-Q",	"I_650Y",	"I_660W-Q",
                                            "I_CNV-12",	"I_CNV370-D",	"I_CNV370-Q",	"I_CVD",	"I_CardioMetab",
                                            "I_Core-12",	"I_CoreE-12v1",	"I_CoreE-12v1.1",	"I_CoreE-24v1",
                                            "I_CoreE-24v1.1",	"I_Cyto-12v2",	"I_Cyto-12v2.1",	"I_Cyto-12v2.1f",
                                            "I_Cyto850",	"I_Exome-12",	"I_Exon510S",	"I_GSA-v1", "I_GSA-v2",
                                            "I_Immuno-24v1", "I_Immuno-24v2",	"I_Linkage-12",	"I_Linkage-24",
                                            "I_ME-Global-8", "I_MEGA", "I_NS-12",	"I_O1-Q",	"I_O1S-8",	"I_O2.5-4",
                                            "I_O2.5-8",	"I_O2.5E-8v1", "I_O2.5E-8v1.1",	"I_O2.5E-8v1.2",
                                            "I_O2.5S-8",	"I_O5-4",	"I_O5E-4", "I_OE-12",	"I_OE-12f",	"I_OE-24",
                                            "I_OEE-8v1",	"I_OEE-8v1.1",  "I_OEE-8v1.2",	"I_OEE-8v1.3",
                                            "I_OZH-8v1",	"I_OZH-8v1.1", "I_OZH-8v1.2",	"I_OncoArray",	"I_Psyc-24v1",
                                            "I_Psyc-24v1.1", "A_10X",	"A_250N",	"A_250S",	"A_50H",	"A_50X",	"A_AFR",
                                            "A_ASI", "A_CHB2",	"A_DMETplus",	"A_EAS",	"A_EUR",	"A_Exome1A",
                                            "A_Exome319", "A_Hu",	"A_Hu-CHB",	"A_LAT",	"A_Onco",	"A_OncoCNV",
                                            "A_PMRA", "A_SNP5.0", "A_SNP6.0", "A_UKBA"),
                            "chip_name" = c("Illumina Infinium Human100kv1", "Illumina Human1Mv1",
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
                                            "Illumina HumanExon510Sv1",	"Illumina Global Screening version 1",
                                            "Illumina Global Screening version 2", "Illumina HumanImmuno-24v1",
                                            "Illumina HumanImmuno-24v2",	"Illumina HumanLinkage-12",
                                            "Illumina HumanLinkage-24",	"Illumina Infinium Multi-Ethnic Global-8",
                                            "Illumina Multi-Ethnic Global", "Illumina HumanNS-12",	"Illumina HumanOmni1-Quadv1",
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
                                            "Affymetrix Axiom Precision Medicine Research", "Affymetrix SNP 5.0",
                                            "Affymetrix SNP 6.0","Affymetrix Axiom UK Biobank")

                             )
      avail_chips <- avail_chips[order(avail_chips$chip_name),]
      row.names(avail_chips) <- 1:nrow(avail_chips)
   return(avail_chips)
}
