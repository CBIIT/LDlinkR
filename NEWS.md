# LDlinkR 1.3.0.9002 (dev version)
* Added Zenodo DOI badge in version 1.3.0.9000
* 3/1/2024 - Increased maximum allowed variants in LDmatrix to 2500
* 3/1/2024 - Added bp window size parameter to LDproxy
* 3/4/2024 - Add bp window size parameter to LDproxy_batch
* 3/4/2024 - Test all changes
* 3/4/2024 - Update dev version number to 1.3.0.9002
* To do: Merge branch ldproxy-bp-window with branch master

# LDlinkR 1.3.0.9000 (development version)
* Add Zenodo DOI badge
* To do: Increase maximum allowed variants in LDmatrix to 3000.

# LDlinkR 1.3.0
* Change LDlink Domain URL to https://ldlink.nih.gov/ (previous url root will no longer work following an unspecified amount of time).
* Add Continuous Integration using Github Actions.
* Update citation file with bibentry style

# LDlinkR 1.2.3
* Add feature to provide root URL to API
* Fix bug that scrambled columns in LDproxy_batch when 'append' option is TRUE
* Update Roxygen version to 7.2.2

# LDlinkR 1.2.2
* Issue #19, fix bug in LDtrait error handling of response data.
* Update CRAN downloads badge in README
* Remove link for 1000 Genomes Project in README and vignette

# LDlinkR 1.2.1
* Update version number
* Fix bug in LDexpress that returned GRCH37 results when genome build was GRCh38 or GRCh38 High Coverage.
* Fix bug in LDproxy handling of error/warning messages in response data.
* Update RoxygenNote to 7.2.0

# LDlinkR 1.2.0
* Submission date: 2022-05-11
* Issue #13 - Add new argument to `LDhap` (table_type) with four options for different types data output.
* Issue #14 - Fix `LDhap` valid input check for number of input 'snps', line 94.
* Add 'snps' to the WORDLIST
* Update test-ldhap with additional tests
* Update vignette with new `LDhap` usage examples with new argument.
* Make LDhap able to write to file for both types of data returned by the new 'table_type' options.
* Add feature 'genome_build' to support different genome builds, GRCh37(hg19), GRCh38(hg38), and GRCh38 High Coverage.
* Improve/update error and warning message returned in the response data from the LDlink API server.
* Fix CRAN note about 'LazyData' by removing line from Description file.
* Update README file.
* Add testthat tests for feature genome_build
* Add three new Illumina chips to SNPchip
* Add two new Affymetrix chips to SNPchip
* Major update to vignette with new feature genome_build

# LDlinkR 1.1.2
* Submission date: 2021-02-19
* Add link to LDlink web site documentation.
* Correct code chunk in vignette FAQ #4, changed option to eval=FALSE; this vignette code chunk no longer requires an internet resource
* added notes to README and vignette that 'internet access required' to use
* Add code to check if required internet resources are available per CRAN

# LDlinkR 1.1.1
* Release date: 2021-02-02
* Added three new functions, `LDtrait`, `LDexpress` & `list_gtex_tissues`
* Updated vignette with new descriptions of functions and examples.
* Major update to `README.md`, including basic examples
* Added a `NEWS.md` file to track changes to the package.
* Issue #2, fixed warning message from write.table in `LDproxy_batch` when append = TRUE
* Updated most function descriptions on package help page
* Added spell checking for building package

# LDlinkR 1.0.2
* Release date 2020-03-02
* Minor updates

# LDlinkR 1.0.1
* Release date 2019-10-17
* Minor updates made for publication.

# LDlinkR 1.0.0
* Release date 2019-08-01
* Initial release.
