## Submission of the 6th release
* Fix status NOTE about LazyData in CRAN package check results
* Add new argument to each function to support different genome builds
* Add new argument to `LDhap` (table_type) - Issue #13
* Fix `LDhap` valid input check for number of input 'snps' - Issue #14
* Improve/update error and warning message returned in the response data
* Add support for new genotyping chips in function `SNPchip`
* Update vignette and README
* Miscellaneous minor changes

## Test environments
* local R installation, R 4.1.2, MacOS Monterey v.12.3.1
* win-builder (devel, release, oldrelease)
* Rhub
  * Windows Server 2022, R-devel, 64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  * Debian Linux, R-devel, clang, ISO-8859-15 locale
  * Apple Silicon (M1), macOS 11.6 Big Sur, R-release

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse Dependency Check
None found

