## Submission of the 10th release
* Increased maximum allowed variants in `LDmatrix` to 2500
* Added base pair window size parameter to `LDproxy`
* Added base pair window size parameter to `LDproxy_batch`
* Added Zenodo DOI badge

## Test environments
* local R installation, R 4.3.2, MacOS Sonoma v.14.3.1
* win-builder (devel, release, oldrelease)
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

0 errors | 0 warnings | 5 notes 

There were five NOTEs:

* This NOTE is only found during Rhub Fedora Linux, R-devel, clang, gfortran and 
Rhub Ubuntu Linux 20.04.1 LTS, R-release, GCC

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```
The HTML version of the manual validated locally and on all other platforms.  This would seem to be an issue with the path to `tidy` on the external Linux servers.

* The following two NOTEs were only found during Rhub Windows Server 2022, R-devel, 64 bit:

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

* The following two NOTEs were only found intermittently during `R CMD checks` on a **local** macOS system:

```
Found the following (possibly) invalid URLs:
    URL: https://ldlink.nih.gov/?tab=apiaccess
    From:....
    Status: Error
      Message: libcurl error code 35:

```

The URL in question is operated and maintained by a USA government research institute. It is accessible via browsers, suggesting an intermittent network or SSL handshake issue.

```
Found the following HTML validation problems:
  LDexpress.html:4:1 (LDexpress.Rd:5): Warning: <link> inserting "type" attribute
  LDexpress.html:12:1 (LDexpress.Rd:5): Warning: <script> proprietary attribute "onload"
  ....
```

The validation notes are intermittent and arise from automatically generated documentation. These do not impact functionality or user accessibility and reflect the output of current documentation tools.

## revdepcheck results

We checked 2 reverse dependencies (1 from CRAN + 1 from Bioconductor), comparing `R CMD check` results across CRAN and dev versions of this package.

 * We saw 0 problems with 1 package from CRAN
 * One check failed for 1 package from Bioconductor
 
The maintainer of the Bioconductor package (`GRaNIE`) was notified on 2024-03-20 (~3 weeks ago) via email of the upcoming new release of `LDlinkR`.
 
