#' Provides a data frame listing the GTEx full names, `LDexpress` full names
#' (without spaces) and acceptable abbreviation codes of the 54 non-diseased
#' tissue sites collected for the GTEx Portal and used as input for the
#' `LDexpress` function.
#'
#' @return a data frame listing the GTEx tissues, their names and abbreviation codes
#' used as input for LDexpress.
#' @export
#'
#' @examples
#' list_gtex_tissues()
list_gtex_tissues <- function() {

    all_tissues <- data.frame(
                     "tissue_name_gtex" = c("Adipose - Subcutaneous", "Adipose - Visceral (Omentum)", "Adrenal Gland",
                                            "Artery - Aorta", "Artery - Coronary", "Artery - Tibial", "Bladder", "Brain - Amygdala",
                                            "Brain - Anterior cingulate cortex (BA24)", "Brain - Caudate (basal ganglia)",
                                            "Brain - Cerebellar Hemisphere", "Brain - Cerebellum", "Brain - Cortex",
                                            "Brain - Frontal Cortex (BA9)",	"Brain - Hippocampus", "Brain - Hypothalamus",
                                            "Brain - Nucleus accumbens (basal ganglia)",	"Brain - Putamen (basal ganglia)",
                                            "Brain - Spinal cord (cervical c-1)", "Brain - Substantia nigra",
                                            "Breast - Mammary Tissue",	"Cells - Cultured fibroblasts",
                                            "Cells - EBV-transformed lymphocytes", "Cervix - Ectocervix", "Cervix - Endocervix",
                                            "Colon - Sigmoid",	"Colon - Transverse", "Esophagus - Gastroesophageal Junction",
                                            "Esophagus - Mucosa", "Esophagus - Muscularis", "Fallopian Tube",
                                            "Heart - Atrial Appendage", "Heart - Left Ventricle", "Kidney - Cortex",
                                            "Kidney - Medulla", "Liver", "Lung", "Minor Salivary Gland", "Muscle - Skeletal",
                                            "Nerve - Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate",
                                            "Skin - Not Sun Exposed (Suprapubic)", "Skin - Sun Exposed (Lower leg)",
                                            "Small Intestine - Terminal Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus",
                                            "Vagina", "Whole Blood", "Select All Tissues"),
                "tissue_name_ldexpress" = c("Adipose_Subcutaneous", "Adipose_Visceral_Omentum", "Adrenal_Gland", "Artery_Aorta",
                                            "Artery_Coronary", "Artery_Tibial", "Bladder", "Brain_Amygdala",
                                            "Brain_Anterior_cingulate_cortex_BA24", "Brain_Caudate_basal_ganglia",
                                            "Brain_Cerebellar_Hemisphere", "Brain_Cerebellum", "Brain_Cortex",
                                            "Brain_Frontal_Cortex_BA9", "Brain_Hippocampus", "Brain_Hypothalamus",
                                            "Brain_Nucleus_accumbens_basal_ganglia", "Brain_Putamen_basal_ganglia",
                                            "Brain_Spinal_cord_cervical_c-1", "Brain_Substantia_nigra", "Breast_Mammary_Tissue",
                                            "Cells_Cultured_fibroblasts", "Cells_EBV_transformed_lymphocytes", "Cervix_Ectocervix",
                                            "Cervix_Endocervix", "Colon_Sigmoid", "Colon_Transverse",
                                            "Esophagus_Gastroesophageal_Junction",	"Esophagus_Mucosa", "Esophagus_Muscularis",
                                            "Fallopian_Tube", "Heart_Atrial_Appendage", "Heart_Left_Ventricle", "Kidney_Cortex",
                                            "Kidney_Medulla", "Liver", "Lung", "Minor_Salivary_Gland", "Muscle_Skeletal",
                                            "Nerve_Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate",
                                            "Skin_Not_Sun_Exposed_Suprapubic", "Skin_Sun_Exposed_Lower_leg",
                                            "Small_Intestine_Terminal_Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus",
                                            "Vagina", "Whole_Blood", "ALL"),
              "tissue_abbrev_ldexpress" = c("ADI_SUB", "ADI_VIS_OME", "ADR_GLA", "ART_AOR", "ART_COR", "ART_TIB", "BLA", "BRA_AMY",
                                            "BRA_ANT_CIN_COR_BA2", "BRA_CAU_BAS_GAN", "BRA_CER_HEM", "BRA_CER", "BRA_COR",
                                            "BRA_FRO_COR_BA9", "BRA_HIP", "BRA_HYP", "BRA_NUC_ACC_BAS_GAN", "BRA_PUT_BAS_GAN",
                                            "BRA_SPI_COR_CER_C-1", "BRA_SUB_NIG", "BRE_MAM_MAM_TIS", "CEL_CUL_FIB", "CEL_EBV_TRA_LYN",
                                            "CER_ECT", "CER_END", "COL_SIG", "COL_TRA", "ESO_GAS_JUN", "ESO_MUC", "ESO_MUS", "FAL_TUB",
                                            "HEA_ATR", "HEA_LEF", "KID_COR", "KID_MED", "LIV", "LUN", "MIN_SAL_GLA", "MUS_SKE",
                                            "NER_TIB", "OVA", "PAN", "PIT", "PRO", "SKI_NOT_SUN_EXP_SUP", "SKI_SUN_EXP_LOW_LEG",
                                            "SMA_INT_TER_ILE", "SPL", "STO", "TES", "THY", "UTE", "VAG", "WHO_BLO", "ALL")

                          )

   return(all_tissues)
}
