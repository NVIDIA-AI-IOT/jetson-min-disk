#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

NEW_FLAVOR=$1

apt-get update
apt-get install -y qemu-user-static wget sudo

cd /l4t/tools/samplefs
./nv_build_samplefs.sh --abi aarch64 --distro ubuntu --flavor ${NEW_FLAVOR} --version focal