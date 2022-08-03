#!/usr/bin/env bash
# build.sh
# Builds the nats-server for the s390x architecture within a Debian package
# Usage:
# ./build.sh [-n | --nats-release url]
#
# Dependencies:
# bash >= 5.x to support this script
# curl: to download the nats release tarball
# golang: to build nats-server for s390x
# nfpm: for debian packaging

set -Eeuo pipefail

nats_release=https://github.com/nats-io/nats-server/archive/refs/tags/v2.8.4.tar.gz

INSTALL_ARGS=$(getopt -o n: --long nats-release: -- "$@")
eval set -- "$INSTALL_ARGS"

while true; do
  case "$1" in
    -n|--nats-release)
      nats_release="$2"
      shift 2
      ;;
    --)
      shift;
      break
      ;;
  esac
done

echo "***********************************"
echo "building nats release $nats_release"
echo "***********************************"

# clean existing build environment
rm -rf build
mkdir -p build/nats-server/release

# extract file name and version number
file_name="${nats_release##*/}"
version_number="${file_name::-7}"

# download NATS release
curl -L -o build/"$file_name" "$nats_release"
cd build && \
   tar -xzf "$file_name" --strip 1 -C nats-server && \
   cd -

# build NATS for s390x
echo "Building NATS version $version_number"
cd build/nats-server && \
   GOOS=linux GOARCH=s390x go build -o ../release/nats-server && \
   cd -

echo "NATS build complete."
echo "nats-server is located in build/release/nats-server"

echo "Creating deb package file"
nfpm package --packager deb --target build/release
