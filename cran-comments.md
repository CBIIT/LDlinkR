## Submission of the fifth release
* Responding to feedback from CRAN:
  * 'Packages which use Internet resources should fail gracefully with an informative message if the resource is not available or has changed (and not give a check warning nor error).'
* Action taken in response:
  * Code chunk in vignette example no longer requires Internet resources.
  * Included code in package functions to check status of Internet resources and use informative message if not available.
* Other minor changes

Thank you for finding this oversight and for reviewing my submission!

## Test environments
* local R installation, R 4.0.3
* win-builder (devel, release, oldrelease)
* Rhub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Oracle Solaris 10, x86, 32 bit, R-release
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, GCC

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse Dependency Check
None found

