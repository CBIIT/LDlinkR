% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LDexpress.R
\name{LDexpress}
\alias{LDexpress}
\title{Determine if genomic variants are associated with gene expression.}
\usage{
LDexpress(
  snps,
  pop = "CEU",
  tissue = "ALL",
  r2d = "r2",
  r2d_threshold = 0.1,
  p_threshold = 0.1,
  win_size = 5e+05,
  genome_build = "grch37",
  token = NULL,
  file = FALSE,
  api_root = "https://ldlink.nih.gov/LDlinkRest"
)
}
\arguments{
\item{snps}{between 1 - 10 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446")}

\item{pop}{a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU".
Use the `list_pop` function to see a list of available human reference populations.}

\item{tissue}{select from 1 - 54 non-diseased tissue sites collected for the GTEx project, multiple
allowed.  Acceptable user input is taken either from "tissue_name_ldexpress" or "tissue_abbrev_ldexpress"
(tissue abbreviation) code listed in available GTEx tissue sites using the
\code{list_getex_tissues()} function (e.g. "ADI_SUB" for Adipose Subcutaneous). Input is case sensitive.
Default = "ALL" for all available tissue types.}

\item{r2d}{either "r2" for LD R2 or "d" for LD D', default = "r2".}

\item{r2d_threshold}{R2 or D' (depends on 'r2d' user input parameter) threshold for LD filtering. Any variants
within -/+ of the specified genomic window and R^2 or D' less than the threshold will be removed. Value needs
to be in the range 0 to 1. Default value is 0.1.}

\item{p_threshold}{define the eQTL significance threshold used for returning query results. Default value
is 0.1 which returns all GTEx eQTL associations with P-value less than 0.1.}

\item{win_size}{set genomic window size for LD calculation. Specify a value greater than or equal to zero and less than or
equal to 1,000,000 basepairs (bp). Default value is -/+ 500,000bp.}

\item{genome_build}{Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
`grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
data sets.  Default is GRCh37 (hg19).}

\item{token}{LDlink provided user token, default = NULL, register for token at \url{https://ldlink.nih.gov/?tab=apiaccess}}

\item{file}{Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.}

\item{api_root}{Optional alternative root url for API.}
}
\value{
A data frame of all query variant RS numbers, respective QTL which are in LD with query variant,
and associated gene expression.
}
\description{
Search if a list of genomic variants (or variants in LD with those variants) is associated with gene
expression in tissues of interest. Quantitative trait loci data is downloaded from the
GTEx Portal (\url{https://gtexportal.org/home/}).
}
\examples{
\dontrun{LDexpress(snps = c("rs345", "rs456"),
                   pop = c("YRI", "CEU"),
                   tissue = c("ADI_SUB", "ADI_VIS_OME"),
                   r2d = "r2",
                   r2d_threshold = "0.1",
                   p_threshold = "0.1",
                   win_size = "500000",
                   genome_build = "grch37",
                   token = Sys.getenv("LDLINK_TOKEN")
                  )
         }

}
