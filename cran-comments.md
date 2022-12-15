## Submission of the 8th release
* Add feature to provide root URL to API
* Fix bug that scrambled columns in LDproxy_batch when 'append' option is TRUE
* Update Roxygen version to 7.2.2

## Test environments
* local R installation, R 4.1.2, MacOS Monterey v.12.6.1
* win-builder (devel, release, oldrelease)
* Rhub
  * Windows Server 2022, R-devel, 64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  
## R CMD check results
There were no ERRORs or WARNINGs. 
There is one NOTE:

* ONLY found during Rhub Fedora Linux, R-devel, clang, gfortran:

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```
The HTML version of the manual validated locally and on all other platforms.  This would seem to be an issue with the path to `tidy` on the external Fedora Linux server.

## Reverse Dependency Check
None found

