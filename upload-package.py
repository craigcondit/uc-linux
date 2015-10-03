#!/usr/bin/env python

import argparse
import os
import os.path
import sys
from subprocess import Popen, PIPE

import json
import requests

BINTRAY_URL = "https://bintray.com/api/v1"

def upload(base_url, user, api_key, org, repo, distro, comp, pkg_file, force):
    pkg_name = Popen(["dpkg-deb", "-f", pkg_file, "Package"], stdout=PIPE).communicate()[0].strip()
    pkg_version = Popen(["dpkg-deb", "-f", pkg_file, "Version"], stdout=PIPE).communicate()[0].strip()
    pkg_arch = Popen(["dpkg-deb", "-f", pkg_file, "Architecture"], stdout=PIPE).communicate()[0].strip()
    if pkg_arch == "":
        pkg_arch = "amd64"

    pkg_filename = "{0}_{1}_{2}.deb".format(pkg_name, pkg_version, pkg_arch)

    pkg_url = "{url}/content/{org}/{repo}/{pkg_name}/{pkg_version}/pool/{comp}/{dir}/{pkg_filename}".format(
        url=base_url, org=org, repo=repo, pkg_name=pkg_name, pkg_version=pkg_version,
        dir=pkg_name[0], comp=comp, pkg_filename=pkg_filename)

    parameters = { "publish" : "1", "override": ("1" if force else "0") }
    headers = {
        "X-Bintray-Debian-Distribution": distro,
        "X-Bintray-Debian-Architecture": pkg_arch,
        "X-Bintray-Debian-Component": comp
    }    

    with open(pkg_file, "rb") as package_fp:
        response = requests.put(
            pkg_url, auth=(user, api_key), params=parameters,
            headers=headers, data=package_fp)

    if response.status_code != 201:
        print "{0} failed to upload: {1}\n    {2}".format(pkg_file, response.status_code, response.text)
        return False

    print "{0} uploaded.".format(pkg_file)
    return True

def main():
    parser = argparse.ArgumentParser(description="Create multiple BinTray packages.")
    parser.add_argument("package", help="Package file")
    parser.add_argument("--user", "-u", help="BinTray user", nargs=1, required=True)
    parser.add_argument("--api-key-file", "-a", help="File containing BinTray API key", nargs=1, required=True)
    parser.add_argument("--organization", "-o", help="BinTray organization", nargs=1, required=True)
    parser.add_argument("--repository", "-r", help="BinTray repository", nargs=1, required=True)
    parser.add_argument("--distribution", "-d", help="Debian distribution", nargs=1, required=True)
    parser.add_argument("--component", "-c", help="Debian component", nargs=1, required=True)
    parser.add_argument("--force", "-f", help="Force upload even if package is present", dest="force", action="store_true")
    parser.set_defaults(force = False)

    args = parser.parse_args()

    if not os.path.isfile(args.api_key_file[0]):
        raise ValueError("File {0} is not present".format(args.api_key_file[0]))

    if not os.path.isfile(args.package):
        raise ValueError("File {0} is not present".format(args.package))

    # read api key
    api_file = open(args.api_key_file[0], 'r')
    api_key = api_file.read().strip()
    api_file.close()

    # upload package
    upload(BINTRAY_URL, args.user[0], api_key, args.organization[0],
        args.repository[0], args.distribution[0], args.component[0], args.package, args.force)

if __name__ == "__main__":
    main()
