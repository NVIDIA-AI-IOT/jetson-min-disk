#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

sudo date
echo $HOSTNAME

DIFF_FILE=$1
if [ ! -f "$DIFF_FILE" ] || [ -z "$DIFF_FILE" ]; then
    echo "[ERROR] Cannot find : $DIFF_FILE"
    exit 1
else
    echo "DIFF file given: $DIFF_FILE"
fi


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUTPUT_DIR=${SCRIPT_DIR}/../log/$(date '+%Y-%m-%d-%H-%M-%S')
mkdir -p ${OUTPUT_DIR}

#
# State A : Full JetPack (or State a: Bare BSP)
#
echo "###### State A (Alpha) ######" 

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-A_stat.txt

echo ">>> df /mmcblk0p1 (1)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-A_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-A_dpkg-list.txt

echo ">>> apt-get -s autoremove" 
apt-get -s autoremove

echo ">>> df /mmcblk0p1 (2)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-A_tree100.txt
echo ">> (tree over 100MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\"" >> ${TREE_FILE}

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-A_tree10.txt
echo ">> (tree over 10MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\"" >> ${TREE_FILE}


#
# State B : JetPack Minus Ubuntu Desktop GUI
#
echo "###### State B (Bravo) ######" 

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-B_stat.txt

echo ">>> [Simulating reduction to minimal configuration]"
sudo apt-get -s purge $(cat ${DIFF_FILE}) | tee ${OUTPUT_DIR}/${HOSTNAME}_state-B_to-be-removed.txt
echo ">>> [Performing reduction to minimal configuration]" 
### Purge
sudo apt-get purge -y $(cat ${DIFF_FILE})
echo ">>> Going to execute: sudo apt-get -y --fix-broken install" 
sudo apt-get -y --fix-broken install 
sudo apt-get purge -y $(cat ${DIFF_FILE}) # In case filed
sudo apt-get install -y network-manager # Make sure Eth0 is available

echo ">>> df /mmcblk0p1 (1)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-B_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-B_dpkg-list.txt

echo ">>> sudo apt-get clean"
sudo apt-get clean

### Install back
sudo apt-get install -y nvidia-jetpack 
sudo apt clean
sudo rm -rf /var/cuda-repo-l4t-10-2-local

echo ">>> sudo apt-get clean" 
sudo apt-get clean

echo ">>> df /mmcblk0p1 (2)" >> $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
echo "### After nvidia-jetpack install ###" >> ${OUTPUT_DIR}/${HOSTNAME}_state-B_apt-list.txt
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-B_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-B-after-reintall_dpkg-list.txt

echo ">>> df /mmcblk0p1 (3)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-B_tree100.txt
echo ">> (tree over 100MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\"" >> ${TREE_FILE}

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-B_tree10.txt
echo ">> (tree over 10MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\"" >> ${TREE_FILE}

#
# State C : Minus Docs & Samples packages
#
echo "###### State C (Charlie) ######" 

dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(sample|doc)" >> ${OUTPUT_DIR}/${HOSTNAME}_state-C-pre_docs-sample.txt

sudo apt-get purge --simulate $(dpkg --list | grep -E -o 'cuda-documentation-[0-9\-]*') $(dpkg --list | grep -E -o 'cuda-samples-[0-9\-]*') "libnvinfer-doc" "libnvinfer-samples" "libvisionworks-samples" "vpi.-samples" | tee -a ${OUTPUT_DIR}/${HOSTNAME}_state-C_apt-purge-simulate.txt

# Remove
sudo apt-get purge $(dpkg --list | grep -E -o 'cuda-documentation-[0-9\-]*') $(dpkg --list | grep -E -o 'cuda-samples-[0-9\-]*') "libnvinfer-doc" "libnvinfer-samples" "libvisionworks-samples" "vpi.-samples" 

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-C_stat.txt

echo ">>> df /mmcblk0p1 (1)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> sudo apt-get clean" | tee -a $STAT
sudo apt-get clean

echo ">>> df /mmcblk0p1 (2)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-C_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-C_dpkg-list.txt

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-C_tree100.txt
echo ">> (tree over 100MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\"" >> ${TREE_FILE}

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-C_tree10.txt
echo ">> (tree over 10MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\"" >> ${TREE_FILE}

#
# State D : Minus dev packages / static libraries
#
echo "###### State D (Delta) ######" 

sudo find / -name 'lib*_static*.a' | tr '\n' '\0' | du -sch --files0-from=-
#sudo find / -name 'lib*_static*.a' -delete
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | tee -a ${OUTPUT_DIR}/${HOSTNAME}_state-D_packages-to-be-removed.txt
dpkg-query -Wf '${Package}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | tee -a ${OUTPUT_DIR}/${HOSTNAME}_state-D_name-of-packages-to-be-removed.txt
sudo apt-get purge --simulate $(dpkg-query -Wf '${Package}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" ) | tee -a ${OUTPUT_DIR}/${HOSTNAME}_state-D_apt-purge-simulate.txt
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | awk '{sum+=$1}END{print sum/1024 " MiB";}' | tee -a ${OUTPUT_DIR}/${HOSTNAME}_state-D_packages-to-be-removed.txt

# Remove
sudo apt-get purge $(dpkg-query -Wf '${Package}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" ) 

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-D_stat.txt

echo ">>> df /mmcblk0p1 (1)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-D_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-D_dpkg-list.txt

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-D_tree100.txt
echo ">> (tree over 100MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\"" >> ${TREE_FILE}

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-D_tree10.txt
echo ">> (tree over 10MD) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\"" >> ${TREE_FILE}
