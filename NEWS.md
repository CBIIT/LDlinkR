# LDlinkR 1.2.0
* Issue #13 - Add new argument to `LDhap` (table_type) with four options for different types data output.
* Issue #14 - Fix `LDhap` valid input check for number of input 'snps', line 94.
* Add 'snps' to the WORDLIST
* Update test-ldhap with additional tests
* Update vignette with new `LDhap` usage examples.
* Make LDhap able to write to file for both types of data returned by the new 'table_type' options.
* Add feature 'genome_build' to support different genome builds, GRCh37(hg19), GRCh38(hg38), and GRCh38 High Coverage.
* Improve/update error and warning message returned in the response data from the LDlink API server.

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
