# uc-linux

Micro-container for Docker which is designed to be small (~ 15 MB),
extensible (support for Debian .deb packages), and functional. Further,
images should be able to have reproducible builds.

### Base Packages ###
    - base-files - 1.0.0-1 
    - busybox - 1.25.1-1 
    - libarchive - 3.2.2-1
    - libassuan - 2.4.3-1
    - libbz2 - 1.0.6-1
    - libc - 2.24-1
    - libcurl - 7.51.0-1
    - libgpg-error - 1.22-1
    - libgpgme - 1.7.1-1
    - liblzma - 5.2.2-1
    - libnghttp2 - 1.16.1-1
    - libopkg - 0.3.3-1
    - libssl - 1.0.2j-1
    - libz - 1.2.8-2
    - openssl - 1.0.2j-1
    - opkg - 0.3.3-1
    - update-alternatives - 1.18.10-1

This small base gives us wide compatibility with a large range of existing
software as well as the ability to build and deploy simple .deb packages.

Glibc was chosen due to its widespread support. Busybox was chosen to give
a functional userland with minimal overhead. OpenSSL is present to allow
busybox's wget implementation to download from https sites. UC Docker
supports simple package management using opkg.

### Other packages ###

The current repository for uc-linux 2016R1 (Hydrogen) is hosted on [Bintray](https://bintray.com/insideo/uc-linux-main-hydrogen).

### Source code ###

Source code of UC Linux is available on [GitHub](https://github.com/insideo/uc-linux).

### Credits ###

Many of the initial build scripts and patches were taken from [LinuxFromScratch](http://www.linuxfromscratch.org/).
