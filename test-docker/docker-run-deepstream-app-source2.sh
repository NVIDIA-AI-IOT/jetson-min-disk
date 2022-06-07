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

sudo docker run -it --rm --net=host --runtime nvidia -w /opt/nvidia/deepstream/deepstream -v /tmp/.X11-unix/:/tmp/.X11-unix -v ${PWD}/_output:/opt/nvidia/deepstream/deepstream/_output nvcr.io/nvidia/deepstream-l4t:6.0-samples bash -c "deepstream-app -c samples/configs/deepstream-app/source2_1080p_dec_infer-resnet_demux_int8.txt; cp out_*.mp4 ./_output/"