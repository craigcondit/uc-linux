# uc-linux

Micro-container for Docker which is designed to be small (~ 15 MB),
extensible (support for Debian .deb packages), and functional. Further,
images should be able to have reproducible builds.

### Base Packages ###
    - base-files - 0.0.1-0
    - busybox - 1.24.1-0
    - libarchive - 3.1.2-0
    - libassuan - 2.4.2-0
    - libbz2 - 1.0.6-0
    - libc - 2.22-0
    - libcurl - 7.44.0-0
    - libgpg-error - 1.20-0
    - libgpgme - 1.6.0-0
    - liblzma - 5.2.1-0
    - libnghttp2 - 1.3.4-0
    - libopkg - 0.3.0-0
    - libssl - 1.0.2d-0
    - libz - 1.2.8-1
    - openssl - 1.0.2d-0
    - opkg - 0.3.0-0
    - update-alternatives - 1.18.3-0

This small base gives us wide compatibility with a large range of existing
software as well as the ability to build and deploy simple .deb packages.

Glibc was chosen due to its widespread support. Busybox was chosen to give
a functional userland with minimal overhead. OpenSSL is present to allow
busybox's wget implementation to download from https sites. UC Docker
supports simple package management using opkg.

### Other packages ###

The current repository for uc-linux version 0 (codename buggy) is hosted on [Bintray](https://bintray.com/insideo/uc-linux-main-buggy).

### Source code ###

Source code of UC Linux is available on [GitHub](https://github.com/insideo/uc-linux).

### Credits ###

Many of the initial build scripts and patches were taken from [LinuxFromScratch](http://www.linuxfromscratch.org/).
