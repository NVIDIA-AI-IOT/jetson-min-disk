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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUTPUT_DIR=${SCRIPT_DIR}/../log/$(date '+%Y-%m-%d-%H-%M-%S')
mkdir -p ${OUTPUT_DIR}

#
# State [a] : Regular L4T 
#

echo "###### State a (lower-letter a, alpha) ######" 

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-a_stat.txt

echo ">>> df /mmcblk0p1 (1)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

echo ">>> apt list --installed | wc -l" | tee -a $STAT
apt list --installed | wc -l | tee -a $STAT
apt list --installed >> ${OUTPUT_DIR}/${HOSTNAME}_state-a_apt-list.txt

echo ">>> dpkg-query with size" | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' | wc -l | tee -a $STAT
dpkg-query -Wf '${Installed-Size;10} KiB \t${Package;-30}\t${binary:Summary}\n' >> ${OUTPUT_DIR}/${HOSTNAME}_state-a_dpkg-list.txt

echo ">>> apt-get -s autoremove" 
apt-get -s autoremove

echo ">>> df /mmcblk0p1 (2)" | tee -a $STAT
df /dev/mmcblk0p1 >> $STAT
df /dev/mmcblk0p1 -h | tee -a $STAT

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-a_tree100.txt
echo ">> (tree over 100MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\"" >> ${TREE_FILE}

TREE_FILE=${OUTPUT_DIR}/${HOSTNAME}_state-a_tree10.txt
echo ">> (tree over 10MB) --> ${TREE_FILE}" | tee -a $STAT
df /dev/mmcblk0p1 >> ${TREE_FILE}
df /dev/mmcblk0p1 -h >> ${TREE_FILE}
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\"" >> ${TREE_FILE}

#
# a --> A : Installing JetPack
#

STAT=${OUTPUT_DIR}/${HOSTNAME}_state-a-to-A_stat.txt

echo "(a1) sudo apt update" | tee -a $STAT
sudo apt update 

df /dev/mmcblk0p1  | tee -a $STAT
df -h /dev/mmcblk0p1  | tee -a $STAT

echo "(a2) sudo apt dist-upgrade" | tee -a $STAT
sudo apt -y dist-upgrade 

df /dev/mmcblk0p1  | tee -a $STAT
df -h /dev/mmcblk0p1  | tee -a $STAT

echo "(a3) sudo apt install -y nvidia-jetpack" | tee -a $STAT
sudo apt install -y nvidia-jetpack 

df /dev/mmcblk0p1  | tee -a $STAT
df -h /dev/mmcblk0p1  | tee -a $STAT

echo "(a4) sudo apt clean" | tee -a $STAT
sudo apt clean

df /dev/mmcblk0p1  | tee -a $STAT
df -h /dev/mmcblk0p1  | tee -a $STAT