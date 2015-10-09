#!/bin/sh
set -e
wget https://dl.bintray.com/insideo/uc-linux-main-buggy/Packages

for pkg in $(cat Packages | grep Filename | awk '{print $2}'); do
	wget https://dl.bintray.com/insideo/uc-linux-main-buggy/${pkg}
done
