## Submission of the 7th release
* Fix bug in LDexpress() that returned GRCH37 results when genome build was GRCh38 or GRCh38 High Coverage.
* Fix bug in LDproxy() handling of error/warning warning messages in response data.

## Test environments
* local R installation, R 4.1.2, MacOS Monterey v.12.3.1
* win-builder (devel, release, oldrelease)
* Rhub
  * Windows Server 2008 R2 SP1, R-release, 32/64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  * Debian Linux, R-devel, clang, ISO-8859-15 locale
  * Apple Silicon (M1), macOS 11.6 Big Sur, R-release

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse Dependency Check
None found

