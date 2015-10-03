#!/usr/bin/env python

import argparse
import os
import os.path
import sys

import yaml
import json
import requests

BINTRAY_URL = "https://bintray.com/api/v1"

# sys.tracebacklimit = 0

def is_sequence(arg):
    return (not hasattr(arg, "strip") and
        hasattr(arg, "__getitem__") or
        hasattr(arg, "__iter__"))

def fetch(base_url, user, api_key, pkg_name):
    pkg_url = "{url}/{name}".format(url=base_url, name=pkg_name)
    response = requests.get(pkg_url, auth=(user, api_key))
    if (response.status_code == 200):
        return json.loads(response.text)
    if (response.status_code == 404):
        return None
    raise Exception(
        "Failed to query package {0}: {1}\n{2}".format(
            pkg_name, response.status_code, response.text))

def create(base_url, user, api_key, pkg_data):
    payload = json.dumps(pkg_data)
    response = requests.post(base_url, auth=(user, api_key), data=payload)
    if response.status_code != 201:
        raise Exception(
            "Failed to create package {0}: {1}\n{2}".format(
                pkg_data['name'], response.status_code, response.text))

def needs_sync(old_pkg_data, pkg_data):
    if pkg_data['name'] != old_pkg_data['name']:
        raise Exception(
            "Package names don't match: {0} != {1}".format(
                pkg_data['name'], old_pkg_data['name']))

    for attr in pkg_data:
        if pkg_data.get(attr) != old_pkg_data.get(attr):
            if is_sequence(pkg_data.get(attr)):
               if sorted(pkg_data.get(attr)) != sorted(old_pkg_data.get(attr)):
                   return True
            else:
                print "  Attr: {0} Old: {1} New: {2}".format(attr, old_pkg_data.get(attr), pkg_data.get(attr))
                return True 

    return False 

def sync(base_url, user, api_key, old_pkg_data, pkg_data):
    pkg_name = pkg_data['name']
    pkg_url = "{url}/{name}".format(url=base_url, name=pkg_name)

    if not needs_sync(old_pkg_data, pkg_data):
        return False

    payload = json.dumps(pkg_data)
    response = requests.patch(pkg_url, auth=(user, api_key), data=payload)
    if response.status_code != 200:
        raise Exception(
            "Failed to modify package {0}: {1}\n{2}".format(
                pkg_name, response.status_code, response.text))

    return True

def main():
    parser = argparse.ArgumentParser(description="Create multiple BinTray packages.")
    parser.add_argument("--user", "-u", help="BinTray user", nargs=1, required=True)
    parser.add_argument("--api-key-file", "-a", help="File containing BinTray API key", nargs=1, required=True)
    parser.add_argument("--organization", "-o", help="BinTray organization", nargs=1, required=True)
    parser.add_argument("--packages-file", "-p", help="File containing Packages YAML", nargs=1, required=True)

    args = parser.parse_args()

    if not os.path.isfile(args.api_key_file[0]):
        raise ValueError("File {0} is not present".format(args.api_key_file[0]))

    if not os.path.isfile(args.packages_file[0]):
        raise ValueError("File {0} is not present".format(args.packages_file[0]))

    # read api key
    api_file = open(args.api_key_file[0], 'r')
    api_key = api_file.read().strip()
    api_file.close()

    # read yaml
    pkg_file = open(args.packages_file[0], 'r')
    pkg_data = yaml.safe_load(pkg_file)
    pkg_file.close()

    success = True    
    for repo_name in pkg_data['repos']:
        repo = pkg_data['repos'].get(repo_name)
        base_url = "{url}/packages/{a.organization[0]}/{r}".format(url=BINTRAY_URL, a=args, r=repo_name)
        for package in repo:
            pkg_name = package['name']
            pkg_old_data = fetch(base_url, args.user[0], api_key, pkg_name)
            if pkg_old_data is not None:
                try:
                    if sync(base_url, args.user[0], api_key, pkg_old_data, package):
                        print "{0}/{1} modified".format(repo_name, pkg_name)
                    else:
                        print "{0}/{1} up to date".format(repo_name, pkg_name)
                except Exception as e:
                    print "Failed to modify package {0}/{1}: {2}".format(repo_name, pkg_name, e)
                    success = False
                    raise
            else:
                try:
                    create(base_url, args.user[0], api_key, package)
                except Exception as e:
                    print "Failed to create package {0}/{1}: {2}".format(repo_name, pkg_name, e)
                    success = False
                else:
                    print "{0}/{1} created".format(repo_name, pkg_name)

    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
