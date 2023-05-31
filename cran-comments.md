## Submission of the 9th release
* Change LDlink Domain URL to https://ldlink.nih.gov/ 
* Add Continuous Integration using Github Actions
* Update citation file with bibentry style

## Test environments
* local R installation, R 4.2.3, MacOS Ventura v.13.4
* win-builder (devel)
* Rhub
  * Windows Server 2022, R-devel, 64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
* Github actions
  * macos-latest (release)
  * ubuntu-latest (devel)
  * ubuntu-latest (oldrel-1)
  * ubuntu-latest (release)
  * windows-latested (release)
  
## R CMD check results
There were no ERRORs or WARNINGs. 
There were three NOTEs:

* This NOTE is only found during Rhub Fedora Linux, R-devel, clang, gfortran and 
Rhub Ubuntu Linux 20.04.1 LTS, R-release, GCC

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```
The HTML version of the manual validated locally and on all other platforms.  This would seem to be an issue with the path to `tidy` on the external Linux servers.

* The following two NOTEs were only found during Windows Server 2022, R-devel, 64 bit:

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

```
* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
  ''NULL''
```
As noted in [R-hub issue #506](https://github.com/r-hub/rhub/issues/560), this is probably an R-hub issue and can be ignored.

## Reverse Dependency Check
None found
