#!/bin/bash
set -e
cd "$(dirname $0)"
cd "$(pwd -P)/install-check"

docker rmi -f insideo/uc-linux-install-check 2>/dev/null || true
docker build -t insideo/uc-linux-install-check .
docker rmi -f insideo/uc-linux-install-check

echo "All packages installed successfully."
