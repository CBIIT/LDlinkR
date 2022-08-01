## Submission of the 7th release
* Fix bug in LDtrait() error handling of API response data.
* Update CRAN downloads badge in README.md

## Test environments
* local R installation, R 4.1.2, MacOS Monterey v.12.3.1
* win-builder (devel, release, oldrelease)
* Rhub
  * Windows Server 2022, R-devel, 64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  
## R CMD check results
There were no ERRORs or WARNINGs. 

There is one NOTE that is only found during R-hub Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

## Reverse Dependency Check
None found

