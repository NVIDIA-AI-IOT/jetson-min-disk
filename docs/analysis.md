# Analyze Disk Usage

## Commands to Analyze Disk Usage

### `df`

If you already have a running Jetson system, you may want to start by knowing how much disk space you are using and left available.

```
df -h /dev/mmcblk0p1
```

??? info "Example outputs of `df` command after installing full JetPack"

    === ":material-numeric-6-box: JetPack 6.0 GA"

        Example output on Jetson AGX Orin Developer Kit with JetPack 6.0 GA:
        ```
        $ df -h /dev/nvme0n1p1
        Filesystem      Size  Used Avail Use% Mounted on
        /dev/nvme0n1p1  227G   19G  197G   9% /
        ```

        Example output on Jetson AGX Orin Developer Kit with **just L4T r36.3.0**:
        ```
        $ df -h /dev/nvme0n1p1
        Filesystem      Size  Used Avail Use% Mounted on
        /dev/nvme0n1p1  227G  6.4G  209G   3% /
        ```

    === ":material-numeric-5-box-multiple: JetPack 5.0.2"

        Example output on Jetson AGX Orin Developer Kit with JetPack 5.0.2:
        ```
        $ df -h /dev/mmcblk0p1
        Filesystem      Size  Used Avail Use% Mounted on
        /dev/mmcblk0p1   57G   16G   39G  29% / 
        ```

    === ":material-numeric-4-box-multiple-outline: JetPack 4.6.x"

        Example output on Jetson Xavier NX Developer Kit with JetPack 4.6.1:
        ```
        $ df -h /dev/mmcblk0p1
        Filesystem      Size  Used Avail Use% Mounted on
        /dev/mmcblk0p1   59G   13G   44G  22% /
        ```


### Count installed packages

```
dpkg-query -W | wc -l
```

or 

```
dpkg -l | grep -c '^ii'
```

!!! info "Example outputs summarized into a table format for JetPack versions"

    | <img width=240/> | JetPack 6.0 GA<br>(Rel 36.3.0)<br>Jetson AGX Orin<br>Developer Kit | JetPack 5.0.2<br>(Rel 35.1.0)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|--:|
    | [a] Regular L4T BSP | 2077 | 1909  | 2217 |  |
    | [A] Full JetPack    | 2204 | 2038 | 2340 | 2348 |
    | [B] GUI removed     | | nnn  | 993 | 1003 |
    | [C] Docs/Samples removed | | nnn  | 988 | 998 |
    | [D] dev packages removed | | nnn  | **969** | **979** |

### `tree` command output filtered by disk usage size

To understand what takes up your disk space, `Disk Usage Analyzer` app on Ubuntu Desktop is a great tool, but you can also run the following tree based command to show what takes up a big chunk of disk space.

Below is an example of listing directories and files that are over 100MB.

```
sudo apt-get install tree
sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\""
```

??? info "Example output of the `tree` command on JetPack 6.x, 5.x and 4.x:"

    === ":material-numeric-6-box: JetPack 6.0 GA"

        ```
        [ 19G]  .
        ├── [2.9G]  opt
        │   ├── [2.7G]  nvidia
        │   │   ├── [1.2G]  nsight-compute
        │   │   │   └── [1.2G]  2023.2.2
        │   │   │       ├── [624M]  host
        │   │   │       │   ├── [322M]  linux-desktop-glibc_2_11_3-x64
        │   │   │       │   │   ├── [163M]  Plugins
        │   │   │       │   └── [301M]  linux-v4l_l4t-t210-a64
        │   │   │       │       ├── [150M]  Plugins
        │   │   │       └── [521M]  target
        │   │   │           ├── [194M]  linux-desktop-glibc_2_11_3-x64
        │   │   │           ├── [191M]  linux-v4l_l4t-t210-a64
        │   │   │           └── [131M]  qnx-700-t210-a64
        │   │   ├── [544M]  nsight-graphics-for-embeddedlinux
        │   │   │   └── [544M]  nsight-graphics-for-embeddedlinux-2023.4.1.0
        │   │   │       ├── [365M]  host
        │   │   │       │   └── [365M]  linux-v4l_l4t-nomad-t210-a64
        │   │   │       └── [179M]  target
        │   │   │           ├── [116M]  linux-v4l_l4t-nomad-t210-a64
        │   │   ├── [874M]  nsight-systems
        │   │   │   └── [874M]  2024.2.2
        │   │   │       ├── [631M]  host-linux-armv8
        │   │   │       │   ├── [246M]  libQt6WebEngineCore.so.6
        │   │   │       └── [223M]  target-linux-tegra-armv8
        │   │   └── [119M]  vpi3
        │   │       ├── [100M]  lib
        │   │       │   └── [100M]  aarch64-linux-gnu
        │   └── [221M]  ota_package
        │       └── [221M]  t23x
        ├── [110M]  sys
        ├── [ 16G]  usr
        │   ├── [253M]  bin
        │   ├── [195M]  include
        │   │   ├── [130M]  boost
        │   ├── [9.4G]  lib
        │   │   ├── [7.1G]  aarch64-linux-gnu
        │   │   │   ├── [1.1G]  dri
        │   │   │   ├── [148M]  libcudnn_adv_infer.so.8.9.4
        │   │   │   ├── [150M]  libcudnn_adv_infer_static.a
        │   │   │   ├── [124M]  libcudnn_adv_train.so.8.9.4
        │   │   │   ├── [127M]  libcudnn_adv_train_static.a
        │   │   │   ├── [627M]  libcudnn_cnn_infer.so.8.9.4
        │   │   │   ├── [741M]  libcudnn_cnn_infer_static.a
        │   │   │   ├── [130M]  libcudnn_cnn_train.so.8.9.4
        │   │   │   ├── [180M]  libcudnn_cnn_train_static.a
        │   │   │   ├── [101M]  libcudnn_ops_infer.so.8.9.4
        │   │   │   ├── [105M]  libcudnn_ops_infer_static.a
        │   │   │   ├── [106M]  libLLVM-15.so.1
        │   │   │   ├── [457M]  libnvinfer_builder_resource.so.8.6.2
        │   │   │   ├── [138M]  libnvinfer_dispatch_static.a
        │   │   │   ├── [163M]  libnvinfer_lean_static.a
        │   │   │   ├── [220M]  libnvinfer.so.8.6.2
        │   │   │   ├── [910M]  libnvinfer_static.a
        │   │   │   ├── [366M]  nvidia
        │   │   ├── [1.0G]  firmware
        │   │   │   ├── [140M]  netronome
        │   │   ├── [276M]  libreoffice
        │   │   │   ├── [204M]  program
        │   │   ├── [295M]  python3
        │   │   │   └── [295M]  dist-packages
        │   │   ├── [220M]  thunderbird
        │   │   │   ├── [134M]  libxul.so
        │   ├── [4.3G]  local
        │   │   ├── [4.3G]  cuda-12.2
        │   │   │   ├── [122M]  bin
        │   │   │   ├── [3.9G]  targets
        │   │   │   │   └── [3.9G]  aarch64-linux
        │   │   │   │       ├── [3.9G]  lib
        │   │   │   │       │   ├── [434M]  libcublasLt.so.12.2.5.6
        │   │   │   │       │   ├── [632M]  libcublasLt_static.a
        │   │   │   │       │   ├── [117M]  libcublas.so.12.2.5.6
        │   │   │   │       │   ├── [197M]  libcublas_static.a
        │   │   │   │       │   ├── [170M]  libcufft.so.11.0.8.103
        │   │   │   │       │   ├── [188M]  libcufft_static.a
        │   │   │   │       │   ├── [188M]  libcufft_static_nocallback.a
        │   │   │   │       │   ├── [105M]  libcurand.so.10.3.3.141
        │   │   │   │       │   ├── [105M]  libcurand_static.a
        │   │   │   │       │   ├── [130M]  libcusolver.so.11.5.2.141
        │   │   │   │       │   ├── [147M]  libcusolver_static.a
        │   │   │   │       │   ├── [275M]  libcusparse.so.12.1.2.141
        │   │   │   │       │   ├── [314M]  libcusparse_static.a
        │   │   │   │       │   ├── [107M]  libnppif.so.12.2.1.4
        │   │   │   │       │   ├── [111M]  libnppif_static.a
        │   ├── [1.1G]  share
        │   │   ├── [256M]  AAVMF
        │   │   ├── [184M]  fonts
        │   │   ├── [137M]  icons
        │   └── [437M]  src
        │       └── [200M]  tensorrt
        │           ├── [197M]  data
        └── [403M]  var
            ├── [124M]  cache
            │   ├── [100M]  apt
            ├── [274M]  lib
            │   ├── [201M]  apt
            │   │   ├── [201M]  lists
        ```

    === ":material-numeric-5-box-multiple: JetPack 5.0.2"

        ```
        ├── [112M]  boot
        ├── [1.3G]  opt
        │   ├── [1.0G]  nvidia
        │   │   ├── [824M]  nsight-systems
        │   │   │   └── [824M]  2022.3.3
        │   │   │       ├── [553M]  host-linux-armv8
        │   │   │       │   ├── [234M]  libQt6WebEngineCore.so.6
        │   │   │       ├── [140M]  target-linux-sbsa-armv8
        │   │   │       └── [110M]  target-linux-tegra-armv8
        │   │   └── [196M]  vpi2
        │   │       ├── [145M]  lib
        │   │       │   └── [145M]  aarch64-linux-gnu
        │   │       │       ├── [139M]  libnvvpi.so.2.1.6
        │   └── [282M]  ota_package
        │       ├── [157M]  t19x
        │       └── [125M]  t23x
        ├── [188M]  sys
        │   ├── [150M]  devices
        │   │   ├── [128M]  platform
        ├── [ 14G]  usr
        │   ├── [461M]  bin
        │   ├── [8.1G]  lib
        │   │   ├── [6.2G]  aarch64-linux-gnu
        │   │   │   ├── [873M]  dri
        │   │   │   ├── [139M]  libcudnn_adv_infer.so.8.4.1
        │   │   │   ├── [141M]  libcudnn_adv_infer_static.a
        │   │   │   ├── [104M]  libcudnn_adv_train.so.8.4.1
        │   │   │   ├── [106M]  libcudnn_adv_train_static.a
        │   │   │   ├── [804M]  libcudnn_cnn_infer.so.8.4.1
        │   │   │   ├── [1.0G]  libcudnn_cnn_infer_static.a
        │   │   │   ├── [101M]  libcudnn_cnn_train.so.8.4.1
        │   │   │   ├── [150M]  libcudnn_cnn_train_static.a
        │   │   │   ├── [201M]  libnvinfer_builder_resource.so.8.4.1
        │   │   │   ├── [277M]  libnvinfer.so.8.4.1
        │   │   │   ├── [795M]  libnvinfer_static.a
        │   │   │   ├── [270M]  tegra
        │   │   ├── [196M]  firefox
        │   │   │   ├── [120M]  libxul.so
        │   │   ├── [644M]  firmware
        │   │   │   ├── [140M]  netronome
        │   │   ├── [262M]  libreoffice
        │   │   │   ├── [192M]  program
        │   │   ├── [173M]  python3
        │   │   │   └── [173M]  dist-packages
        │   │   ├── [110M]  snapd
        │   │   ├── [199M]  thunderbird
        │   │   │   ├── [119M]  libxul.so
        │   ├── [3.8G]  local
        │   │   ├── [3.8G]  cuda-11.4
        │   │   │   ├── [157M]  samples
        │   │   │   ├── [3.5G]  targets
        │   │   │   │   └── [3.5G]  aarch64-linux
        │   │   │   │       └── [3.5G]  lib
        │   │   │   │           ├── [354M]  libcublasLt.so.11.6.6.23
        │   │   │   │           ├── [480M]  libcublasLt_static.a
        │   │   │   │           ├── [160M]  libcublas.so.11.6.6.23
        │   │   │   │           ├── [203M]  libcublas_static.a
        │   │   │   │           ├── [167M]  libcufft.so.10.6.0.143
        │   │   │   │           ├── [206M]  libcufft_static.a
        │   │   │   │           ├── [179M]  libcufft_static_nocallback.a
        │   │   │   │           ├── [247M]  libcusolverMg.so.11.2.0.238
        │   │   │   │           ├── [208M]  libcusolver.so.11.2.0.238
        │   │   │   │           ├── [202M]  libcusolver_static.a
        │   │   │   │           ├── [220M]  libcusparse.so.11.6.0.238
        │   │   │   │           ├── [245M]  libcusparse_static.a
        │   ├── [673M]  share
        │   │   ├── [169M]  fonts
        │   │   ├── [110M]  icons
        │   └── [828M]  src
        │       ├── [133M]  nvidia
        │       └── [525M]  tensorrt
        │           ├── [521M]  data
        │           │   ├── [294M]  resnet50
        └── [327M]  var
            ├── [109M]  cache
            ├── [206M]  lib
            │   ├── [150M]  apt
            │   │   ├── [150M]  lists
        ```

    === ":material-numeric-5-box-multiple: JetPack 5.0.1 DP"

        ```
        ├── [109M]  boot
        ├── [1.1G]  opt
        │   ├── [861M]  nvidia
        │   │   ├── [724M]  nsight-systems
        │   │   │   └── [724M]  2022.2.3
        │   │   │       ├── [472M]  host-linux-armv8
        │   │   │       │   ├── [234M]  libQt6WebEngineCore.so.6
        │   │   │       ├── [115M]  target-linux-sbsa-armv8
        │   │   │       └── [116M]  target-linux-tegra-armv8
        │   │   └── [121M]  vpi2
        │   └── [279M]  ota_package
        │       ├── [165M]  t19x
        │       └── [114M]  t23x
        ├── [110M]  sys
        ├── [ 12G]  usr
        │   ├── [354M]  bin
        │   ├── [7.0G]  lib
        │   │   ├── [6.6G]  aarch64-linux-gnu
        │   │   │   ├── [873M]  dri
        │   │   │   ├── [154M]  libcudnn_adv_infer.so.8.3.2
        │   │   │   ├── [157M]  libcudnn_adv_infer_static.a
        │   │   │   ├── [104M]  libcudnn_adv_train.so.8.3.2
        │   │   │   ├── [106M]  libcudnn_adv_train_static.a
        │   │   │   ├── [863M]  libcudnn_cnn_infer.so.8.3.2
        │   │   │   ├── [1.1G]  libcudnn_cnn_infer_static.a
        │   │   │   ├── [101M]  libcudnn_cnn_train.so.8.3.2
        │   │   │   ├── [149M]  libcudnn_cnn_train_static.a
        │   │   │   ├── [228M]  libnvinfer_builder_resource.so.8.4.0
        │   │   │   ├── [451M]  libnvinfer.so.8.4.0
        │   │   │   ├── [1.1G]  libnvinfer_static.a
        │   │   │   ├── [229M]  tegra
        │   ├── [3.8G]  local
        │   │   ├── [3.8G]  cuda-11.4
        │   │   │   ├── [157M]  samples
        │   │   │   ├── [3.5G]  targets
        │   │   │   │   └── [3.5G]  aarch64-linux
        │   │   │   │       └── [3.5G]  lib
        │   │   │   │           ├── [354M]  libcublasLt.so.11.6.5.24
        │   │   │   │           ├── [480M]  libcublasLt_static.a
        │   │   │   │           ├── [160M]  libcublas.so.11.6.5.24
        │   │   │   │           ├── [203M]  libcublas_static.a
        │   │   │   │           ├── [167M]  libcufft.so.10.6.0.71
        │   │   │   │           ├── [206M]  libcufft_static.a
        │   │   │   │           ├── [179M]  libcufft_static_nocallback.a
        │   │   │   │           ├── [247M]  libcusolverMg.so.11.2.0.165
        │   │   │   │           ├── [208M]  libcusolver.so.11.2.0.165
        │   │   │   │           ├── [202M]  libcusolver_static.a
        │   │   │   │           ├── [220M]  libcusparse.so.11.6.0.165
        │   │   │   │           ├── [245M]  libcusparse_static.a
        │   ├── [250M]  share
        │   └── [762M]  src
        │       └── [525M]  tensorrt
        │           ├── [521M]  data
        │           │   ├── [294M]  resnet50
        └── [206M]  var
            ├── [169M]  lib
            │   ├── [141M]  apt
            │   │   ├── [141M]  lists
        ```

    === ":material-numeric-4-box-multiple-outline: JetPack 4.6.x"

        ```
        ├── [442M]  lib
        │   ├── [325M]  firmware
        ├── [298M]  opt
        │   ├── [123M]  nvidia
        │   │   └── [107M]  vpi1
        │   └── [175M]  ota_package
        │       └── [150M]  t19x
        ├── [359M]  sys
        │   ├── [258M]  kernel
        │   │   ├── [238M]  slab
        ├── [ 10G]  usr
        │   ├── [466M]  bin
        │   ├── [5.0G]  lib
        │   │   ├── [3.7G]  aarch64-linux-gnu
        │   │   │   ├── [535M]  dri
        │   │   │   ├── [104M]  libcudnn_adv_infer.so.8.2.1
        │   │   │   ├── [396M]  libcudnn_cnn_infer.so.8.2.1
        │   │   │   ├── [121M]  libcudnn_ops_infer.so.8.2.1
        │   │   │   ├── [810M]  libcudnn_static_v8.a
        │   │   │   ├── [157M]  libnvinfer.so.8.2.1
        │   │   │   ├── [345M]  libnvinfer_static.a
        │   │   │   ├── [142M]  tegra
        │   │   ├── [296M]  chromium-browser
        │   │   │   ├── [176M]  chromium-browser
        │   │   ├── [265M]  libreoffice
        │   │   │   ├── [207M]  program
        │   │   ├── [185M]  python3
        │   │   │   └── [185M]  dist-packages
        │   │   ├── [200M]  thunderbird
        │   │   │   ├── [119M]  libxul.so
        │   ├── [2.8G]  local
        │   │   ├── [2.8G]  cuda-10.2
        │   │   │   ├── [328M]  doc
        │   │   │   │   ├── [209M]  html
        │   │   │   │   └── [116M]  pdf
        │   │   │   ├── [203M]  samples
        │   │   │   ├── [2.2G]  targets
        │   │   │   │   └── [2.2G]  aarch64-linux
        │   │   │   │       └── [2.2G]  lib
        │   │   │   │           ├── [192M]  libcufft.so.10.1.2.300
        │   │   │   │           ├── [184M]  libcufft_static.a
        │   │   │   │           ├── [201M]  libcufft_static_nocallback.a
        │   │   │   │           ├── [209M]  libcusolver.so.10.3.0.300
        │   │   │   │           ├── [118M]  libcusolver_static.a
        │   │   │   │           ├── [135M]  libcusparse.so.10.3.1.300
        │   │   │   │           ├── [143M]  libcusparse_static.a
        │   │   │   │           ├── [157M]  libnvgraph.so.10.2.300
        │   │   │   │           ├── [160M]  libnvgraph_static.a
        │   ├── [988M]  share
        │   │   ├── [162M]  fonts
        │   │   ├── [117M]  locale
        │   └── [754M]  src
        │       └── [536M]  tensorrt
        │           ├── [532M]  data
        │           │   ├── [294M]  resnet50
        └── [1.4G]  var
            ├── [1.0G]  cuda-repo-l4t-10-2-local
            │   ├── [105M]  libcufft-10-2_10.1.2.300-1_arm64.deb
            │   ├── [188M]  libcufft-dev-10-2_10.1.2.300-1_arm64.deb
            ├── [201M]  lib
            │   ├── [136M]  apt
            │   │   ├── [136M]  lists
        ```

#### Above 10MB

!!! note "For listing directories and files over 10MB:"

    ```
    sudo bash -c "cd /; tree --du  -h  | grep -E \"\[[0-9[:space:]][0-9]*M]|G]\""
    ```

### `dpkg-query` with Size

```
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n'
```

??? info "Example outputs of the `dpkg-query` command:"

    === ":material-numeric-6-box: JetPack 6.0 GA"

        Jetson AGX Orin Developer Kit with JetPack 6.0 GA 
        ```
             496 KiB 	accountsservice               	query and manipulate user account information
             172 KiB 	acl                           	access control list - utilities
             608 KiB 	adduser                       	add and remove users and groups
            5234 KiB 	adwaita-icon-theme            	default icon theme of GNOME (small subset)
            8800 KiB 	aisleriot                     	GNOME solitaire card game collection
             464 KiB 	alsa-base                     	ALSA driver configuration files
             597 KiB 	alsa-ucm-conf                 	ALSA Use Case Manager configuration files
            2420 KiB 	alsa-utils                    	Utilities for configuring and using ALSA
              94 KiB 	anacron                       	cron-like program that doesn't go by time
             105 KiB 	apg                           	Automated Password Generator - Standalone version
            2632 KiB 	apparmor                      	user-space parser utility for AppArmor
             812 KiB 	apport                        	automatically generate crash reports for debugging
             205 KiB 	apport-gtk                    	GTK+ frontend for the apport crash report system
              61 KiB 	apport-symptoms               	symptom scripts for apport
             292 KiB 	appstream                     	Software component metadata management
            3941 KiB 	apt                           	commandline package manager
              26 KiB 	apt-config-icons              	APT configuration snippet to enable icon downloads
              26 KiB 	apt-config-icons-hidpi        	APT configuration snippet to enable HiDPI icon downloads
             176 KiB 	aptdaemon                     	transaction based package management service
             248 KiB 	aptdaemon-data                	data files for clients
              55 KiB 	apturl                        	install packages using the apt protocol - GTK+ frontend
             168 KiB 	apturl-common                 	install packages using the apt protocol - common data
             320 KiB 	aspell                        	GNU Aspell spell-checker
             424 KiB 	aspell-en                     	English dictionary for GNU Aspell
             264 KiB 	at-spi2-core                  	Assistive Technology Service Provider Interface (dbus core)
            2032 KiB 	autoconf                      	automatic configure script builder
             134 KiB 	autotools-dev                 	Update infrastructure for config.{guess,sub} files
             121 KiB 	avahi-autoipd                 	Avahi IPv4LL network address configuration daemon
             289 KiB 	avahi-daemon                  	Avahi mDNS/DNS-SD daemon
             153 KiB 	avahi-utils                   	Avahi browsing, publishing and discovery utilities
             788 KiB 	baobab                        	GNOME disk usage analyzer
             389 KiB 	base-files                    	Debian base system miscellaneous files
             235 KiB 	base-passwd                   	Debian base system master password and group files
            1864 KiB 	bash                          	GNU Bourne Again SHell
            1464 KiB 	bash-completion               	programmable completion for the bash shell
             203 KiB 	bc                            	GNU bc arbitrary precision calculator language
             171 KiB 	bind9-host                    	DNS Lookup Utility
            3283 KiB 	bind9-libs                    	Shared Libraries used by BIND 9
             183 KiB 	binfmt-support                	Support for extra binary formats
             113 KiB 	binutils                      	GNU assembler, linker and binary utilities
           13487 KiB 	binutils-aarch64-linux-gnu    	GNU binary utilities, for aarch64-linux-gnu target
             504 KiB 	binutils-common               	Common files for the GNU assembler, linker and binary utilities
            2432 KiB 	bison                         	YACC-compatible parser generator
              29 KiB 	blt                           	graphics extension library for Tcl/Tk - run-time
            3600 KiB 	bluez                         	Bluetooth tools and daemons
             676 KiB 	bluez-obexd                   	bluez obex daemon
             453 KiB 	bolt                          	system daemon to manage thunderbolt 3 devices
            1168 KiB 	branding-ubuntu               	Replacement artwork with Ubuntu branding
             114 KiB 	bridge-utils                  	Utilities for configuring the Linux Ethernet bridge
            7916 KiB 	brltty                        	Access software for a blind person using a braille display
             309 KiB 	bsdextrautils                 	extra utilities from 4.4BSD-Lite
             330 KiB 	bsdutils                      	basic utilities from 4.4BSD-Lite
             121 KiB 	bubblewrap                    	utility for unprivileged chroot and namespace manipulation
             381 KiB 	busybox-initramfs             	Standalone shell setup for initramfs
             110 KiB 	bzip2                         	high-quality block-sorting file compressor - utilities
             390 KiB 	ca-certificates               	Common CA certificates
             104 KiB 	ca-certificates-mono          	Common CA certificates (Mono keystore)
             599 KiB 	can-utils                     	SocketCAN userspace utilities and tools
             434 KiB 	cheese                        	tool to take pictures and videos from your webcam
             912 KiB 	cheese-common                 	Common files for the Cheese tool to take pictures and videos
             265 KiB 	cli-common                    	common files between all CLI packages
             924 KiB 	colord                        	system service to manage device colour profiles -- system daemon
            1000 KiB 	colord-data                   	system service to manage device colour profiles -- data files
             426 KiB 	console-setup                 	console font and keymap setup program
            2171 KiB 	console-setup-linux           	Linux specific part of console-setup
            6220 KiB 	coreutils                     	GNU core utilities
             308 KiB 	cpio                          	GNU cpio -- a program to manage archives of files
              67 KiB 	cpp                           	GNU C preprocessor (cpp)
           24392 KiB 	cpp-11                        	GNU C preprocessor
             259 KiB 	cpuset                        	Allows manipluation of cpusets and provides higher level fun
             574 KiB 	cracklib-runtime              	runtime support for password checker library cracklib2
             247 KiB 	cron                          	process scheduling daemon
             568 KiB 	cryptsetup-bin                	disk encryption support - command line tools
             210 KiB 	dash                          	POSIX-compliant shell
             542 KiB 	dbus                          	simple interprocess messaging system (daemon and utilities)
             130 KiB 	dbus-user-session             	simple interprocess messaging system (systemd --user integration)
             156 KiB 	dbus-x11                      	simple interprocess messaging system (X11 deps)
             123 KiB 	dc                            	GNU dc arbitrary precision reverse-polish calculator
              81 KiB 	dconf-cli                     	simple configuration storage system - utilities
              74 KiB 	dconf-gsettings-backend       	simple configuration storage system - GSettings back-end
              98 KiB 	dconf-service                 	simple configuration storage system - D-Bus service
             260 KiB 	dctrl-tools                   	Command-line tools to process Debian package information
             512 KiB 	debconf                       	Debian configuration management system
             105 KiB 	debconf-utils                 	debconf utilities
             230 KiB 	debianutils                   	Miscellaneous utilities specific to Debian
            1388 KiB 	deja-dup                      	Backup utility
             248 KiB 	desktop-file-utils            	Utilities for .desktop files
             392 KiB 	device-tree-compiler          	Device Tree Compiler for Flat Device Trees
             765 KiB 	dictionaries-common           	spelling dictionaries - common utilities
             392 KiB 	diffutils                     	File comparison utilities
             635 KiB 	dirmngr                       	GNU privacy guard - network certificate management service
              69 KiB 	distro-info                   	provides information about the distributions' releases
              20 KiB 	distro-info-data              	information about the distributions' releases (data files)
             280 KiB 	dmsetup                       	Linux Kernel Device Mapper userspace library
            3567 KiB 	dmz-cursor-theme              	Style neutral, scalable cursor theme
              18 KiB 	dns-root-data                 	DNS root data including root zone and DNSSEC key
             852 KiB 	dnsmasq-base                  	Small caching DNS proxy and DHCP/TFTP server
            2134 KiB 	docbook-xml                   	standard XML documentation system for software and systems
             229 KiB 	dosfstools                    	utilities for making and checking MS-DOS FAT filesystems
            6669 KiB 	dpkg                          	Debian package management system
            1284 KiB 	duplicity                     	encrypted bandwidth-efficient backup
            1432 KiB 	e2fsprogs                     	ext2/ext3/ext4 file system utilities
             148 KiB 	eject                         	ejects CDs and operates CD-Changers under Linux
              62 KiB 	emacsen-common                	Common facilities for all emacsen
              57 KiB 	enchant-2                     	Wrapper for various spell checker engines (binary programs)
            2064 KiB 	eog                           	Eye of GNOME graphics viewer program
           10054 KiB 	espeak-ng-data                	Multi-lingual software speech synthesizer: speech data files
             614 KiB 	ethtool                       	display or change Ethernet device settings
             971 KiB 	evince                        	Document (PostScript, PDF) viewer
            1596 KiB 	evince-common                 	Document (PostScript, PDF) viewer - common files
            2725 KiB 	evolution-data-server         	evolution database backend server
             524 KiB 	evolution-data-server-common  	architecture independent files for Evolution Data Server
             421 KiB 	fdisk                         	collection of partitioning utilities
              80 KiB 	file                          	Recognize the type of data in a file using "magic" numbers
            1768 KiB 	file-roller                   	archive manager for GNOME
             604 KiB 	findutils                     	utilities for finding files--find, xargs
            7400 KiB 	fio                           	flexible I/O tester
             972 KiB 	flex                          	fast lexical analyzer generator
             345 KiB 	fontconfig                    	generic font configuration library - support binaries
             172 KiB 	fontconfig-config             	generic font configuration library - configuration
               9 KiB 	fonts-beng                    	Metapackage to install Bengali and Assamese fonts
             662 KiB 	fonts-beng-extra              	TrueType fonts for Bengali language
            2954 KiB 	fonts-dejavu-core             	Vera font family derivate with additional characters
               9 KiB 	fonts-deva                    	Meta package to install all Devanagari fonts
            3310 KiB 	fonts-deva-extra              	Free fonts for Devanagari script
            7347 KiB 	fonts-droid-fallback          	handheld device font with extensive style and language support (fallback)
            6497 KiB 	fonts-freefont-ttf            	Freefont Serif, Sans and Mono Truetype fonts
              91 KiB 	fonts-gargi                   	OpenType Devanagari font
             147 KiB 	fonts-gubbi                   	Gubbi free font for Kannada script
               9 KiB 	fonts-gujr                    	Meta package to install all Gujarati fonts
             385 KiB 	fonts-gujr-extra              	Free fonts for Gujarati script
              10 KiB 	fonts-guru                    	Meta package to install all Punjabi fonts
             134 KiB 	fonts-guru-extra              	Free fonts for Punjabi language
               9 KiB 	fonts-indic                   	Meta package to install all Indian language fonts
             978 KiB 	fonts-kacst                   	KACST free TrueType Arabic fonts
             117 KiB 	fonts-kacst-one               	TrueType font designed for Arabic language
             463 KiB 	fonts-kalapi                  	Kalapi Gujarati Unicode font
             539 KiB 	fonts-khmeros-core            	KhmerOS Unicode fonts for the Khmer language of Cambodia
              10 KiB 	fonts-knda                    	Meta package for Kannada fonts
             206 KiB 	fonts-lao                     	TrueType font for Lao language
            2089 KiB 	fonts-liberation              	Fonts with the same metrics as Times, Arial and Courier
            4288 KiB 	fonts-liberation2             	Fonts with the same metrics as Times, Arial and Courier (v2)
             320 KiB 	fonts-lklug-sinhala           	Unicode Sinhala font by Lanka Linux User Group
             165 KiB 	fonts-lohit-beng-assamese     	Lohit TrueType font for Assamese Language
             165 KiB 	fonts-lohit-beng-bengali      	Lohit TrueType font for Bengali Language
             193 KiB 	fonts-lohit-deva              	Lohit TrueType font for Devanagari script
              98 KiB 	fonts-lohit-gujr              	Lohit TrueType font for Gujarati Language
              62 KiB 	fonts-lohit-guru              	Lohit TrueType font for Punjabi Language
             230 KiB 	fonts-lohit-knda              	Lohit TrueType font for Kannada Language
              83 KiB 	fonts-lohit-mlym              	Lohit TrueType font for Malayalam Language
             120 KiB 	fonts-lohit-orya              	Lohit TrueType font for Oriya Language
              84 KiB 	fonts-lohit-taml              	Lohit TrueType font for Tamil Language
             100 KiB 	fonts-lohit-taml-classical    	Lohit Tamil TrueType fonts for Tamil script
             370 KiB 	fonts-lohit-telu              	Lohit TrueType font for Telugu Language
             352 KiB 	fonts-lyx                     	TrueType versions of some TeX fonts used by LyX
              10 KiB 	fonts-mlym                    	Meta package to install all Malayalam fonts
             344 KiB 	fonts-nakula                  	Free Unicode compliant Devanagari font
             150 KiB 	fonts-navilu                  	Handwriting font for Kannada
           91003 KiB 	fonts-noto-cjk                	"No Tofu" font families with large Unicode coverage (CJK regular and bold)
           10740 KiB 	fonts-noto-color-emoji        	color emoji font from Google
            1160 KiB 	fonts-noto-mono               	"No Tofu" monospaced font family with large Unicode coverage
             456 KiB 	fonts-opensymbol              	OpenSymbol TrueType font
              10 KiB 	fonts-orya                    	Meta package to install all Odia fonts
             174 KiB 	fonts-orya-extra              	Free fonts for Odia script
             207 KiB 	fonts-pagul                   	Free TrueType font for the Sourashtra language
             361 KiB 	fonts-sahadeva                	Free Unicode compliant Devanagari font
             140 KiB 	fonts-samyak-deva             	Samyak TrueType font for Devanagari script
             113 KiB 	fonts-samyak-gujr             	Samyak TrueType font for Gujarati language
              60 KiB 	fonts-samyak-mlym             	Samyak TrueType font for Malayalam language
              62 KiB 	fonts-samyak-taml             	Samyak TrueType font for Tamil language
             137 KiB 	fonts-sarai                   	truetype font for devanagari script
            1271 KiB 	fonts-sil-abyssinica          	Ethiopic script font designed in a calligraphic style
            3349 KiB 	fonts-sil-padauk              	Burmese Unicode TrueType font with OpenType and Graphite support
              15 KiB 	fonts-smc                     	Metapackage for various TrueType fonts for Malayalam Language
             351 KiB 	fonts-smc-anjalioldlipi       	AnjaliOldLipi malayalam font
             266 KiB 	fonts-smc-chilanka            	Chilanka malayalam font
             254 KiB 	fonts-smc-dyuthi              	Dyuthi malayalam font
             562 KiB 	fonts-smc-gayathri            	Gayathri Malayalam font
             472 KiB 	fonts-smc-karumbi             	Karumbi malayalam font
             241 KiB 	fonts-smc-keraleeyam          	Keraleeyam malayalam font
             466 KiB 	fonts-smc-manjari             	Manjari malayalam font
             328 KiB 	fonts-smc-meera               	Meera malayalam font
             648 KiB 	fonts-smc-rachana             	Rachana malayalam font
              78 KiB 	fonts-smc-raghumalayalamsans  	RaghuMalayalamSans malayalam font
             354 KiB 	fonts-smc-suruma              	Suruma malayalam font
             192 KiB 	fonts-smc-uroob               	Uroob malayalam font
              10 KiB 	fonts-taml                    	Meta package to install all Tamil fonts
               9 KiB 	fonts-telu                    	Meta package to install all Telugu fonts
             420 KiB 	fonts-telu-extra              	Free fonts for Telugu script
           11511 KiB 	fonts-teluguvijayam           	TrueType fonts for Telugu script (te)
              31 KiB 	fonts-thai-tlwg               	Thai fonts maintained by TLWG (metapackage)
            4424 KiB 	fonts-tibetan-machine         	font for Tibetan, Dzongkha and Ladakhi (OpenType Unicode)
              37 KiB 	fonts-tlwg-garuda             	Thai Garuda font (dependency package)
             351 KiB 	fonts-tlwg-garuda-ttf         	Thai Garuda TrueType font
              37 KiB 	fonts-tlwg-kinnari            	Thai Kinnari font (dependency package)
             618 KiB 	fonts-tlwg-kinnari-ttf        	Thai Kinnari TrueType font
              37 KiB 	fonts-tlwg-laksaman           	Thai Laksaman font (dependency package)
             494 KiB 	fonts-tlwg-laksaman-ttf       	Thai Laksaman TrueType font
              35 KiB 	fonts-tlwg-loma               	Thai Loma font (dependency package)
             386 KiB 	fonts-tlwg-loma-ttf           	Thai Loma TrueType font
              35 KiB 	fonts-tlwg-mono               	Thai TlwgMono font (dependency package)
             418 KiB 	fonts-tlwg-mono-ttf           	Thai TlwgMono TrueType font
              35 KiB 	fonts-tlwg-norasi             	Thai Norasi font (dependency package)
             720 KiB 	fonts-tlwg-norasi-ttf         	Thai Norasi TrueType font
              24 KiB 	fonts-tlwg-purisa             	Thai Purisa font (dependency package)
             655 KiB 	fonts-tlwg-purisa-ttf         	Thai Purisa TrueType font
              24 KiB 	fonts-tlwg-sawasdee           	Thai Sawasdee font (dependency package)
             419 KiB 	fonts-tlwg-sawasdee-ttf       	Thai Sawasdee TrueType font
              24 KiB 	fonts-tlwg-typewriter         	Thai TlwgTypewriter font (dependency package)
             440 KiB 	fonts-tlwg-typewriter-ttf     	Thai TlwgTypewriter TrueType font
              35 KiB 	fonts-tlwg-typist             	Thai TlwgTypist font (dependency package)
             434 KiB 	fonts-tlwg-typist-ttf         	Thai TlwgTypist TrueType font
              35 KiB 	fonts-tlwg-typo               	Thai TlwgTypo font (dependency package)
             435 KiB 	fonts-tlwg-typo-ttf           	Thai TlwgTypo TrueType font
              37 KiB 	fonts-tlwg-umpush             	Thai Umpush font (dependency package)
             566 KiB 	fonts-tlwg-umpush-ttf         	Thai Umpush TrueType font
              35 KiB 	fonts-tlwg-waree              	Thai Waree font (dependency package)
             414 KiB 	fonts-tlwg-waree-ttf          	Thai Waree TrueType font
            4339 KiB 	fonts-ubuntu                  	sans-serif font set from Ubuntu
           11095 KiB 	fonts-urw-base35              	font set metric-compatible with the 35 PostScript Level 2 Base Fonts
            3252 KiB 	fonts-yrsa-rasa               	Open-source, libre fonts for Latin + Gujarati
             437 KiB 	foomatic-db-compressed-ppds   	OpenPrinting printer support - Compressed PPDs derived from the database
            1313 KiB 	foomatic-filters              	OpenPrinting printer support - filters
             632 KiB 	fprintd                       	D-Bus daemon for fingerprint reader access
             294 KiB 	freeglut3                     	OpenGL Utility Toolkit
              82 KiB 	fuse3                         	Filesystem in Userspace (3.x version)
            6160 KiB 	fwupd                         	Firmware update daemon
              80 KiB 	fwupd-signed                  	Linux Firmware Updater EFI signed binary
              16 KiB 	g++                           	GNU C++ compiler
           26907 KiB 	g++-11                        	GNU C++ compiler
              37 KiB 	gamemode                      	Optimise Linux system performance on demand
             196 KiB 	gamemode-daemon               	Optimise Linux system performance on demand (daemon)
              50 KiB 	gcc                           	GNU C compiler
           48978 KiB 	gcc-11                        	GNU C compiler
             273 KiB 	gcc-11-base                   	GCC, the GNU Compiler Collection (base package)
             272 KiB 	gcc-12-base                   	GCC, the GNU Compiler Collection (base package)
             376 KiB 	gcr                           	GNOME crypto services (daemon and tools)
            2045 KiB 	gdal-data                     	Geospatial Data Abstraction Library - Data files
           15081 KiB 	gdb                           	GNU Debugger
             701 KiB 	gdbserver                     	GNU Debugger (remote server)
             670 KiB 	gdisk                         	GPT fdisk text-mode partitioning tool
            1812 KiB 	gdm3                          	GNOME Display Manager
            1709 KiB 	gedit                         	official text editor of the GNOME desktop environment
            2948 KiB 	gedit-common                  	official text editor of the GNOME desktop environment (support files)
             438 KiB 	geoclue-2.0                   	geoinformation service
             252 KiB 	gettext-base                  	GNU Internationalization utilities for the base system
             230 KiB 	ghostscript                   	interpreter for the PostScript language and for PDF
             215 KiB 	ghostscript-x                 	interpreter for the PostScript language and for PDF - X11 support
              33 KiB 	gir1.2-accountsservice-1.0    	GObject introspection data for AccountService
             107 KiB 	gir1.2-adw-1                  	GObject introspection files for libadwaita
              28 KiB 	gir1.2-appindicator3-0.1      	Typelib files for libappindicator3-1.
              92 KiB 	gir1.2-atk-1.0                	ATK accessibility toolkit (GObject introspection)
              76 KiB 	gir1.2-atspi-2.0              	Assistive Technology Service Provider (GObject introspection)
             112 KiB 	gir1.2-freedesktop            	Introspection data for some FreeDesktop components
              59 KiB 	gir1.2-gck-1                  	GObject introspection data for the GCK library
              79 KiB 	gir1.2-gcr-3                  	GObject introspection data for the GCR library
              28 KiB 	gir1.2-gdesktopenums-3.0      	GObject introspection for GSettings desktop-wide schemas
              51 KiB 	gir1.2-gdkpixbuf-2.0          	GDK Pixbuf library - GObject-Introspection
             106 KiB 	gir1.2-gdm-1.0                	GObject introspection data for the GNOME Display Manager
              45 KiB 	gir1.2-geoclue-2.0            	convenience library to interact with geoinformation service (introspection)
             677 KiB 	gir1.2-glib-2.0               	Introspection data for GLib, GObject, Gio and GModule
              30 KiB 	gir1.2-gmenu-3.0              	GObject introspection data for the GNOME menu library
              27 KiB 	gir1.2-gnomebluetooth-3.0     	Introspection data for GnomeBluetooth
              68 KiB 	gir1.2-gnomedesktop-3.0       	Introspection data for GnomeDesktop (GTK 3)
              82 KiB 	gir1.2-goa-1.0                	Introspection data for GNOME Online Accounts
              52 KiB 	gir1.2-graphene-1.0           	library of graphic data types (introspection files)
             273 KiB 	gir1.2-gst-plugins-bad-1.0    	GObject introspection data for the GStreamer libraries from the "bad" set
             471 KiB 	gir1.2-gst-plugins-base-1.0   	GObject introspection data for the GStreamer Plugins Base library
             373 KiB 	gir1.2-gstreamer-1.0          	GObject introspection data for the GStreamer library
            1020 KiB 	gir1.2-gtk-3.0                	GTK graphical user interface library -- gir bindings
             877 KiB 	gir1.2-gtk-4.0                	GTK graphical user interface library -- gir bindings
              92 KiB 	gir1.2-gtksource-4            	gir files for the GTK+ syntax highlighting widget
              22 KiB 	gir1.2-gudev-1.0              	libgudev-1.0 introspection data
              41 KiB 	gir1.2-gweather-3.0           	GObject introspection data for the GWeather library
              74 KiB 	gir1.2-handy-1                	GObject introspection files for libhandy
             134 KiB 	gir1.2-harfbuzz-0.0           	OpenType text shaping engine (GObject introspection data)
             352 KiB 	gir1.2-ibus-1.0               	Intelligent Input Bus - introspection data
             324 KiB 	gir1.2-javascriptcoregtk-4.0  	JavaScript engine library from WebKitGTK - GObject introspection data
              43 KiB 	gir1.2-json-1.0               	GLib JSON manipulation library (introspection data)
             548 KiB 	gir1.2-mutter-10              	GObject introspection data for Mutter
             366 KiB 	gir1.2-nm-1.0                 	GObject introspection data for the libnm library
              29 KiB 	gir1.2-nma-1.0                	GObject introspection data for libnma
              23 KiB 	gir1.2-notify-0.7             	sends desktop notifications to a notification daemon (Introspection files)
             123 KiB 	gir1.2-packagekitglib-1.0     	GObject introspection data for the PackageKit GLib library
             186 KiB 	gir1.2-pango-1.0              	Layout and rendering of internationalized text - gir bindings
              31 KiB 	gir1.2-peas-1.0               	Application plugin library (introspection files)
              48 KiB 	gir1.2-polkit-1.0             	GObject introspection data for PolicyKit
             196 KiB 	gir1.2-rb-3.0                 	GObject introspection data for the rhythmbox music player
              73 KiB 	gir1.2-rsvg-2.0               	gir files for renderer library for SVG files
              45 KiB 	gir1.2-secret-1               	Secret store (GObject-Introspection)
              71 KiB 	gir1.2-snapd-1                	Typelib file for libsnapd-glib1
             137 KiB 	gir1.2-soup-2.4               	GObject introspection data for the libsoup HTTP library
              47 KiB 	gir1.2-totem-1.0              	GObject introspection data for Totem media player
              28 KiB 	gir1.2-totemplparser-1.0      	GObject introspection data for the Totem Playlist Parser library
              35 KiB 	gir1.2-upowerglib-1.0         	GObject introspection data for upower
              59 KiB 	gir1.2-vte-2.91               	GObject introspection data for the VTE library
             617 KiB 	gir1.2-webkit2-4.0            	Web content engine library for GTK - GObject introspection data
              67 KiB 	gir1.2-wnck-3.0               	GObject introspection data for the WNCK library
           18032 KiB 	git                           	fast, scalable, distributed revision control system
            1958 KiB 	git-man                       	fast, scalable, distributed revision control system (manual pages)
             186 KiB 	gjs                           	Mozilla-based javascript bindings for the GNOME platform (cli tool)
              26 KiB 	gkbd-capplet                  	GNOME control center tools for libgnomekbd
             205 KiB 	glib-networking               	network-related giomodules for GLib
              48 KiB 	glib-networking-common        	network-related giomodules for GLib - data files
              46 KiB 	glib-networking-services      	network-related giomodules for GLib - D-Bus services
              32 KiB 	glibc-tools                   	Tools and libraries that used to be part of glibc
            5633 KiB 	gnome-accessibility-themes    	High Contrast GTK+ 2 theme and icons
             160 KiB 	gnome-bluetooth               	GNOME Bluetooth Send To app
             984 KiB 	gnome-bluetooth-3-common      	GNOME Bluetooth 3 common files
              60 KiB 	gnome-bluetooth-common        	GNOME Bluetooth common files
            3464 KiB 	gnome-calculator              	GNOME desktop calculator
             856 KiB 	gnome-calendar                	Calendar application for GNOME
             720 KiB 	gnome-characters              	character map application
            4865 KiB 	gnome-control-center          	utilities to configure the GNOME desktop
             996 KiB 	gnome-control-center-data     	configuration applets for GNOME - data files
            1332 KiB 	gnome-control-center-faces    	utilities to configure the GNOME desktop - faces images
             552 KiB 	gnome-desktop3-data           	Common files for GNOME desktop apps
            1012 KiB 	gnome-disk-utility            	manage and configure disk drives and media
             296 KiB 	gnome-font-viewer             	font viewer for GNOME
            1696 KiB 	gnome-initial-setup           	Initial GNOME system setup helper
            3032 KiB 	gnome-keyring                 	GNOME keyring services (daemon and tools)
             114 KiB 	gnome-keyring-pkcs11          	GNOME keyring module for the PKCS#11 module loading library
             756 KiB 	gnome-logs                    	viewer for the systemd journal
            3376 KiB 	gnome-mahjongg                	classic Eastern tile game for GNOME
             252 KiB 	gnome-menus                   	GNOME implementation of the freedesktop menu specification
             792 KiB 	gnome-mines                   	popular minesweeper puzzle game for GNOME
             294 KiB 	gnome-online-accounts         	service to manage online accounts for the GNOME desktop
             312 KiB 	gnome-power-manager           	power management tool for the GNOME desktop
             448 KiB 	gnome-remote-desktop          	Remote desktop daemon for GNOME using PipeWire
             248 KiB 	gnome-screenshot              	screenshot application for GNOME
             442 KiB 	gnome-session-bin             	GNOME Session Manager - Minimal runtime
              46 KiB 	gnome-session-canberra        	GNOME session log in and log out sound events
             232 KiB 	gnome-session-common          	GNOME Session Manager - common files
            1196 KiB 	gnome-settings-daemon         	daemon handling the GNOME session settings
             344 KiB 	gnome-settings-daemon-common  	daemon handling the GNOME session settings - common files
            3861 KiB 	gnome-shell                   	graphical shell for the GNOME desktop
            2608 KiB 	gnome-shell-common            	common files for the GNOME graphical shell
             256 KiB 	gnome-shell-extension-appindic	AppIndicator, KStatusNotifierItem and tray support for GNOME Shell
             432 KiB 	gnome-shell-extension-desktop-	desktop icon support for GNOME Shell
             732 KiB 	gnome-shell-extension-ubuntu-d	Ubuntu Dock for GNOME Shell
            2797 KiB 	gnome-software                	Software Center for GNOME
             160 KiB 	gnome-software-common         	Software Center for GNOME (common files)
             106 KiB 	gnome-software-plugin-snap    	Snap support for GNOME Software
             174 KiB 	gnome-startup-applications    	Startup Applications manager for GNOME
            1004 KiB 	gnome-sudoku                  	Sudoku puzzle game for GNOME
            2940 KiB 	gnome-system-monitor          	Process viewer and system resource monitor for GNOME
             620 KiB 	gnome-terminal                	GNOME terminal emulator application
            1644 KiB 	gnome-terminal-data           	Data files for the GNOME terminal emulator
              42 KiB 	gnome-themes-extra            	Adwaita GTK+ 2 theme — engine
             504 KiB 	gnome-themes-extra-data       	Adwaita GTK+ 2 theme — common files
             467 KiB 	gnome-todo                    	minimalistic personal task manager designed to fit GNOME desktop
             284 KiB 	gnome-todo-common             	common files for GNOME To Do
            3199 KiB 	gnome-user-docs               	GNOME Help
             124 KiB 	gnome-video-effects           	Collection of GStreamer effects
             473 KiB 	gnupg                         	GNU privacy guard - a free PGP replacement
             392 KiB 	gnupg-l10n                    	GNU privacy guard - localization files
             735 KiB 	gnupg-utils                   	GNU privacy guard - utility programs
              51 KiB 	gnupg2                        	GNU privacy guard - a free PGP replacement (dummy transitional package)
            1097 KiB 	gpg                           	GNU Privacy Guard -- minimalist public key operations
             566 KiB 	gpg-agent                     	GNU privacy guard - cryptographic agent
             175 KiB 	gpg-wks-client                	GNU privacy guard - Web Key Service client
             159 KiB 	gpg-wks-server                	GNU privacy guard - Web Key Service server
             264 KiB 	gpgconf                       	GNU privacy guard - core configuration utilities
             460 KiB 	gpgsm                         	GNU privacy guard - S/MIME version
             307 KiB 	gpgv                          	GNU privacy guard - signature verification tool
             112 KiB 	gpiod                         	Tools for interacting with Linux GPIO character device - binary
             476 KiB 	grep                          	GNU grep, egrep and fgrep
            1408 KiB 	grilo-plugins-0.3-base        	Framework for discovering and browsing media - Plugins
            3343 KiB 	groff-base                    	GNU troff text-formatting system (base system components)
           13600 KiB 	grub-common                   	GRand Unified Bootloader (common files)
             308 KiB 	gsettings-desktop-schemas     	GSettings desktop-wide schemas
              33 KiB 	gsettings-ubuntu-schemas      	GSettings deskop-wide schemas for Ubuntu
             174 KiB 	gstreamer1.0-alsa             	GStreamer plugin for ALSA
              29 KiB 	gstreamer1.0-clutter-3.0      	Clutter PLugin for GStreamer 1.0
             393 KiB 	gstreamer1.0-gl               	GStreamer plugins for GL
             149 KiB 	gstreamer1.0-gtk3             	GStreamer plugin for GTK+3
             249 KiB 	gstreamer1.0-libav            	ffmpeg plugin for GStreamer
              51 KiB 	gstreamer1.0-packagekit       	GStreamer plugin to install codecs using PackageKit
             137 KiB 	gstreamer1.0-pipewire         	GStreamer 1.0 plugin for the PipeWire multimedia server
            8132 KiB 	gstreamer1.0-plugins-bad      	GStreamer plugins from the "bad" set
            2129 KiB 	gstreamer1.0-plugins-base     	GStreamer plugins from the "base" set
             166 KiB 	gstreamer1.0-plugins-base-apps	GStreamer helper programs from the "base" set
            6036 KiB 	gstreamer1.0-plugins-good     	GStreamer plugins from the "good" set
             800 KiB 	gstreamer1.0-plugins-ugly     	GStreamer plugins from the "ugly" set
              90 KiB 	gstreamer1.0-pulseaudio       	GStreamer plugin for PulseAudio (transitional package)
             252 KiB 	gstreamer1.0-tools            	Tools for use with GStreamer
             294 KiB 	gstreamer1.0-x                	GStreamer plugins for X11 and Pango
             152 KiB 	gtk-update-icon-cache         	icon theme caching utility
             265 KiB 	gtk2-engines-murrine          	cairo-based gtk+-2.0 theme engine
             118 KiB 	gtk2-engines-pixbuf           	pixbuf-based theme for GTK 2
           44058 KiB 	guile-2.2-libs                	Core Guile libraries
             346 KiB 	gvfs                          	userspace virtual filesystem - GIO module
            1642 KiB 	gvfs-backends                 	userspace virtual filesystem - backends
             100 KiB 	gvfs-common                   	userspace virtual filesystem - common data files
             487 KiB 	gvfs-daemons                  	userspace virtual filesystem - servers
              77 KiB 	gvfs-fuse                     	userspace virtual filesystem - fuse server
             448 KiB 	gvfs-libs                     	userspace virtual filesystem - private libraries
             235 KiB 	gzip                          	GNU compression utilities
              88 KiB 	haveged                       	Linux entropy source using the HAVEGE algorithm
             440 KiB 	hicolor-icon-theme            	default fallback theme for FreeDesktop.org icon themes
              47 KiB 	hostname                      	utility to set/show the host name or domain name
           20660 KiB 	humanity-icon-theme           	Humanity Icon theme
             878 KiB 	hunspell-en-us                	English_american dictionary for hunspell
             287 KiB 	i2c-tools                     	heterogeneous set of I2C tools for Linux
            1160 KiB 	ibus                          	Intelligent Input Bus - core
           56044 KiB 	ibus-data                     	Intelligent Input Bus - data files
              75 KiB 	ibus-gtk                      	Intelligent Input Bus - GTK2 support
              75 KiB 	ibus-gtk3                     	Intelligent Input Bus - GTK3 support
              75 KiB 	ibus-gtk4                     	Intelligent Input Bus - GTK4 support
            1876 KiB 	ibus-table                    	table engine for IBus
             998 KiB 	ibverbs-providers             	User space provider drivers for libibverbs
             601 KiB 	icu-devtools                  	Development utilities for International Components for Unicode
             121 KiB 	iio-sensor-proxy              	IIO sensors to D-Bus proxy
             364 KiB 	im-config                     	Input method configuration framework
             133 KiB 	init-system-helpers           	helper tools for all init systems
             148 KiB 	initramfs-tools               	generic modular initramfs generator (automation)
             123 KiB 	initramfs-tools-bin           	binaries used by initramfs-tools
             275 KiB 	initramfs-tools-core          	generic modular initramfs generator (core tools)
              68 KiB 	inputattach                   	utility to connect serial-attached peripherals to the input subsystem
              55 KiB 	iperf3                        	Internet Protocol bandwidth measuring tool
            5032 KiB 	ipp-usb                       	Daemon for IPP over USB printer support
            2776 KiB 	iproute2                      	networking and traffic control tools
            2286 KiB 	iptables                      	administration tools for packet filtering and NAT
             109 KiB 	iputils-ping                  	Tools to test the reachability of network hosts
             633 KiB 	isc-dhcp-client               	DHCP client for automatically obtaining an IP address
            1117 KiB 	isc-dhcp-server               	ISC DHCP server for automatic IP address assignment
           19769 KiB 	iso-codes                     	ISO language, territory, currency, script codes and their translations
             293 KiB 	iw                            	tool for configuring Linux wireless devices
              59 KiB 	jetson-gpio-common            	Jetson GPIO library package (common files)
            1232 KiB 	kbd                           	Linux console font and keytable utilities
              79 KiB 	kerneloops                    	kernel oops tracker
             222 KiB 	kexec-tools                   	tools to support fast kexec reboots
             842 KiB 	keyboard-configuration        	system-wide keyboard preferences
             399 KiB 	klibc-utils                   	small utilities built with klibc for early boot
             239 KiB 	kmod                          	tools for managing Linux kernel modules
               9 KiB 	language-pack-en              	translation updates for language English
            3760 KiB 	language-pack-en-base         	translations for language English
            1776 KiB 	language-selector-common      	Language selector for Ubuntu
             121 KiB 	language-selector-gnome       	Language selector frontend for Ubuntu
              20 KiB 	laptop-detect                 	system chassis type checker
             650 KiB 	ldap-utils                    	OpenLDAP utilities
             312 KiB 	less                          	pager program similar to more
              66 KiB 	liba52-0.7.4                  	library for decoding ATSC A/52 streams
             151 KiB 	libaa1                        	ASCII art library
            1441 KiB 	libabsl20210324               	extensions to the C++ standard library
             258 KiB 	libabw-0.1-1                  	library for reading and writing AbiWord(tm) documents
             239 KiB 	libaccountsservice0           	query and manipulate user account information - shared libraries
              62 KiB 	libacl1                       	access control list - shared library
            1576 KiB 	libadwaita-1-0                	Library with GTK widgets for mobile phones
              49 KiB 	libaec0                       	Adaptive Entropy Coding library
              32 KiB 	libaio1                       	Linux kernel AIO access library - shared library
              24 KiB 	libao-common                  	Cross Platform Audio Output Library (Common files)
             139 KiB 	libao4                        	Cross Platform Audio Output Library
            3046 KiB 	libaom3                       	AV1 Video Codec Library
             167 KiB 	libapparmor1                  	changehat AppArmor library
             572 KiB 	libappstream4                 	Library to access AppStream services
            2998 KiB 	libapt-pkg6.0                 	package management runtime library
             843 KiB 	libarchive13                  	Multi-format archive and compression library (shared library)
              47 KiB 	libargon2-1                   	memory-hard hashing function - runtime library
             705 KiB 	libarmadillo10                	streamlined C++ linear algebra library
             261 KiB 	libarpack2                    	Fortran77 subroutines to solve large scale eigenvalue problems
            7602 KiB 	libasan6                      	AddressSanitizer -- a fast memory error detector
            1146 KiB 	libasound2                    	shared library for ALSA applications
             217 KiB 	libasound2-data               	Configuration files and profiles for ALSA drivers
             677 KiB 	libasound2-dev                	shared library for ALSA applications -- development files
             282 KiB 	libasound2-plugins            	ALSA library additional plugins
            2052 KiB 	libaspell15                   	GNU Aspell spell-checker runtime library
             187 KiB 	libass9                       	library for SSA/ASS subtitles rendering
             102 KiB 	libassuan0                    	IPC library for the GnuPG components
              39 KiB 	libasyncns0                   	Asynchronous name service query library
              78 KiB 	libatasmart4                  	ATA S.M.A.R.T. reading and parsing library
              55 KiB 	libatk-adaptor                	AT-SPI 2 toolkit bridge
             241 KiB 	libatk-bridge2.0-0            	AT-SPI 2 toolkit bridge - shared library
             202 KiB 	libatk1.0-0                   	ATK accessibility toolkit
              44 KiB 	libatk1.0-data                	Common files for the ATK accessibility toolkit
             328 KiB 	libatkmm-1.6-1v5              	C++ wrappers for ATK accessibility toolkit (shared libraries)
              48 KiB 	libatomic1                    	support library providing __atomic built-in functions
             151 KiB 	libatopology2                 	shared library for handling ALSA topology definitions
             263 KiB 	libatspi2.0-0                 	Assistive Technology Service Provider Interface - shared library
              52 KiB 	libattr1                      	extended attribute handling - shared library
              23 KiB 	libaudit-common               	Dynamic library for security auditing - common files
             151 KiB 	libaudit1                     	Dynamic library for security auditing
             119 KiB 	libauthen-sasl-perl           	Authen::SASL - SASL Authentication framework
             129 KiB 	libavahi-client3              	Avahi client library
             116 KiB 	libavahi-common-data          	Avahi common data files
             114 KiB 	libavahi-common3              	Avahi common library
             282 KiB 	libavahi-core7                	Avahi's embeddable mDNS/DNS-SD library
              74 KiB 	libavahi-glib1                	Avahi GLib integration library
             111 KiB 	libavahi-ui-gtk3-0            	Avahi GTK+ User interface library for GTK3
              58 KiB 	libavc1394-0                  	control IEEE 1394 audio/video devices
           18173 KiB 	libavcodec-dev                	FFmpeg library with de/encoders for audio/video codecs - development files
           12133 KiB 	libavcodec58                  	FFmpeg library with de/encoders for audio/video codecs - runtime files
            4416 KiB 	libavfilter7                  	FFmpeg library containing media filters - runtime files
            5602 KiB 	libavformat-dev               	FFmpeg library with (de)muxers for multimedia containers - development files
            2689 KiB 	libavformat58                 	FFmpeg library with (de)muxers for multimedia containers - runtime files
            1727 KiB 	libavutil-dev                 	FFmpeg library with functions for simplifying programming - development files
             711 KiB 	libavutil56                   	FFmpeg library with functions for simplifying programming - runtime files
              86 KiB 	libayatana-appindicator3-1    	Ayatana Application Indicators (GTK-3+ version)
             184 KiB 	libayatana-ido3-0.4-0         	Widgets and other objects used for Ayatana Indicators
             104 KiB 	libayatana-indicator3-7       	panel indicator applet - shared library (GTK-3+ variant)
             454 KiB 	libbabeltrace1                	Babeltrace conversion libraries
              28 KiB 	libbasicobjects0              	Basic object types for C
              38 KiB 	libbfb0                       	bfb protocol library
            2560 KiB 	libbinutils                   	GNU binary utilities (private shared library)
             467 KiB 	libblas3                      	Basic Linear Algebra Reference implementations, shared library
             998 KiB 	libblkid-dev                  	block device ID library - headers
             318 KiB 	libblkid1                     	block device ID library
              63 KiB 	libblockdev-crypto2           	Crypto plugin for libblockdev
              80 KiB 	libblockdev-fs2               	file system plugin for libblockdev
              34 KiB 	libblockdev-loop2             	Loop device plugin for libblockdev
              26 KiB 	libblockdev-part-err2         	Partition error utility functions for libblockdev
              55 KiB 	libblockdev-part2             	Partitioning plugin for libblockdev
              34 KiB 	libblockdev-swap2             	Swap plugin for libblockdev
              51 KiB 	libblockdev-utils2            	Utility functions for libblockdev
             224 KiB 	libblockdev2                  	Library for manipulating block devices
              77 KiB 	libblosc1                     	high performance meta-compressor optimized for binary data
             271 KiB 	libbluetooth3                 	Library to use the BlueZ Linux Bluetooth stack
             364 KiB 	libbluray2                    	Blu-ray disc playback support library (shared library)
            2060 KiB 	libboost-atomic1.74.0         	atomic data types, operations, and memory ordering constraints
            2080 KiB 	libboost-chrono1.74.0         	C++ representation of time duration, time point, and clocks
            2052 KiB 	libboost-date-time1.74.0      	set of date-time libraries based on generic programming concepts
              11 KiB 	libboost-dev                  	Boost C++ Libraries development files (default version)
            2156 KiB 	libboost-filesystem1.74.0     	filesystem operations (portable paths, iteration over directories, etc) in C++
            2128 KiB 	libboost-iostreams1.74.0      	Boost.Iostreams Library
            2669 KiB 	libboost-locale1.74.0         	C++ facilities for localization
            3248 KiB 	libboost-log1.74.0            	C++ logging library
            2913 KiB 	libboost-regex1.74.0          	regular expression library for C++
            2052 KiB 	libboost-system1.74.0         	Operating system (e.g. diagnostics support) library
            2172 KiB 	libboost-thread1.74.0         	portable C++ multi-threading
          138248 KiB 	libboost1.74-dev              	Boost C++ Libraries development files
             340 KiB 	libbpf0                       	eBPF helper library (shared library)
             158 KiB 	libbrlapi0.8                  	braille display access via BRLTTY - shared library
             723 KiB 	libbrotli1                    	library implementing brotli encoder and decoder (shared libraries)
              36 KiB 	libbs2b0                      	Bauer stereophonic-to-binaural DSP library
             127 KiB 	libbsd0                       	utility functions from BSD systems - shared library
              95 KiB 	libbz2-1.0                    	high-quality block-sorting file compressor library - runtime
             107 KiB 	libc-ares2                    	asynchronous name resolver
            2048 KiB 	libc-bin                      	GNU C Library: Binaries
             295 KiB 	libc-dev-bin                  	GNU C Library: Development binaries
           10331 KiB 	libc6                         	GNU C Library: Shared libraries
           16470 KiB 	libc6-dbg                     	GNU C Library: detached debugging symbols
            9053 KiB 	libc6-dev                     	GNU C Library: Development Libraries and Header Files
            1029 KiB 	libcaca0                      	colour ASCII art library
              53 KiB 	libcairo-gobject-perl         	integrate Cairo into the Glib type system in Perl
              98 KiB 	libcairo-gobject2             	Cairo 2D vector graphics library (GObject library)
             417 KiB 	libcairo-perl                 	Perl interface to the Cairo graphics library
             205 KiB 	libcairo-script-interpreter2  	Cairo 2D vector graphics library (script interpreter)
            1283 KiB 	libcairo2                     	Cairo 2D vector graphics library
             170 KiB 	libcairomm-1.0-1v5            	C++ wrappers for Cairo (shared libraries)
            1536 KiB 	libcamel-1.2-63               	Evolution MIME message handling library
              43 KiB 	libcanberra-gtk3-0            	GTK+ 3.0 helper for playing widget event sounds with libcanberra
              57 KiB 	libcanberra-gtk3-module       	translates GTK3 widgets signals to event sounds
              52 KiB 	libcanberra-pulse             	PulseAudio backend for libcanberra
             125 KiB 	libcanberra0                  	simple abstract interface for playing event sounds
              41 KiB 	libcap-ng0                    	An alternate POSIX capabilities library
              60 KiB 	libcap2                       	POSIX 1003.1e capabilities (library)
              99 KiB 	libcap2-bin                   	POSIX 1003.1e capabilities (utilities)
              83 KiB 	libcbor0.8                    	library for parsing and generating CBOR (RFC 7049)
             136 KiB 	libcc1-0                      	GCC cc1 plugin for GDB
              47 KiB 	libcdio-cdda2                 	library to read and control digital audio CDs
              46 KiB 	libcdio-paranoia2             	library to read digital audio CDs with error correction
             177 KiB 	libcdio19                     	library to read and control CD-ROM
             126 KiB 	libcdparanoia0                	audio extraction tool for sampling CDs (library)
             634 KiB 	libcdr-0.1-1                  	library for reading and converting Corel DRAW files
            1408 KiB 	libcfitsio9                   	shared library for I/O with FITS format data files
             285 KiB 	libcharls2                    	Implementation of the JPEG-LS standard
             100 KiB 	libcheese-gtk25               	tool to take pictures and videos from your webcam - widgets
             122 KiB 	libcheese8                    	tool to take pictures and videos from your webcam - base library
              74 KiB 	libchromaprint1               	audio fingerprint library
              39 KiB 	libclone-perl                 	module for recursively copying Perl datatypes
             407 KiB 	libclucene-contribs1v5        	language specific text analyzers (runtime)
            1608 KiB 	libclucene-core1v5            	core library for full-featured text search engine (runtime)
            1627 KiB 	libclutter-1.0-0              	Open GL based interactive canvas library
              48 KiB 	libclutter-1.0-common         	Open GL based interactive canvas library (common files)
             191 KiB 	libclutter-gst-3.0-0          	Open GL based interactive canvas library GStreamer elements
              84 KiB 	libclutter-gtk-1.0-0          	Open GL based interactive canvas library GTK+ widget
           14997 KiB 	libcodec2-1.0                 	Codec2 runtime library
             224 KiB 	libcogl-common                	Object oriented GL/GLES Abstraction/Utility Layer (common files)
              62 KiB 	libcogl-pango20               	Object oriented GL/GLES Abstraction/Utility Layer
              95 KiB 	libcogl-path20                	Object oriented GL/GLES Abstraction/Utility Layer
             840 KiB 	libcogl20                     	Object oriented GL/GLES Abstraction/Utility Layer
              63 KiB 	libcolamd2                    	column approximate minimum degree ordering library for sparse matrices
              71 KiB 	libcollection4                	Collection data-type for C
             112 KiB 	libcolord-gtk1                	GTK+ convenience library for interacting with colord
             608 KiB 	libcolord2                    	system service to manage device colour profiles -- runtime
             142 KiB 	libcolorhug2                  	library to access the ColorHug colourimeter -- runtime
              96 KiB 	libcom-err2                   	common error description library
             152 KiB 	libcrack2                     	pro-active password checker library
             326 KiB 	libcrypt-dev                  	libcrypt development files
             212 KiB 	libcrypt1                     	libcrypt shared library
             552 KiB 	libcryptsetup12               	disk encryption support - shared library
             292 KiB 	libctf-nobfd0                 	Compact C Type Format library (runtime, no BFD dependency)
             215 KiB 	libctf0                       	Compact C Type Format library (runtime, BFD dependency)
              54 KiB 	libcue2                       	CUE Sheet Parser Library
             770 KiB 	libcups2                      	Common UNIX Printing System(tm) - Core library
             321 KiB 	libcupsfilters1               	OpenPrinting CUPS Filters - Shared library
             715 KiB 	libcurl3-gnutls               	easy-to-use client-side URL transfer library (GnuTLS flavour)
             735 KiB 	libcurl4                      	easy-to-use client-side URL transfer library (OpenSSL flavour)
              46 KiB 	libdaemon0                    	lightweight C library for daemons - runtime library
              64 KiB 	libdata-dump-perl             	Perl module to help dump data structures
              54 KiB 	libdatrie1                    	Double-array trie library
             705 KiB 	libdav1d5                     	fast and small AV1 video stream decoder (shared library)
              61 KiB 	libdaxctl1                    	Utility library for managing the device DAX subsystem
            1030 KiB 	libdazzle-1.0-0               	feature-filled library for GTK+ and GObject
              44 KiB 	libdazzle-common              	feature-filled library for GTK+ and GObject (common files)
            1626 KiB 	libdb5.3                      	Berkeley v5.3 Database Libraries [runtime]
             453 KiB 	libdbus-1-3                   	simple interprocess messaging system (library)
             203 KiB 	libdbus-glib-1-2              	deprecated library for D-Bus IPC
             149 KiB 	libdbusmenu-glib4             	library for passing menus over DBus
             111 KiB 	libdbusmenu-gtk3-4            	library for passing menus over DBus - GTK+ version
             249 KiB 	libdc1394-25                  	high level programming interface for IEEE 1394 digital cameras
             583 KiB 	libdc1394-dev                 	high level programming interface for IEEE 1394 digital cameras - development
             173 KiB 	libdca0                       	decoding library for DTS Coherent Acoustics streams
             102 KiB 	libdconf1                     	simple configuration storage system - runtime library
             685 KiB 	libde265-0                    	Open H.265 video codec implementation
              70 KiB 	libdebconfclient0             	Debian Configuration Management System (C-implementation library)
              41 KiB 	libdebuginfod-common          	configuration to enable the Debian debug info server
              57 KiB 	libdebuginfod1                	library to interact with debuginfod (development files)
              53 KiB 	libdecor-0-0                  	client-side window decoration library
             300 KiB 	libdee-1.0-4                  	Model to synchronize multiple instances over DBus - shared lib
             124 KiB 	libdeflate-dev                	headers for whole-buffer compression and decompression library
             121 KiB 	libdeflate0                   	fast, whole-buffer DEFLATE-based compression and decompression
             500 KiB 	libdevmapper1.02.1            	Linux Kernel Device Mapper userspace library
              32 KiB 	libdhash1                     	Dynamic hash table
             349 KiB 	libdjvulibre-text             	Linguistic support files for libdjvulibre
            1566 KiB 	libdjvulibre21                	Runtime support for the DjVu image format
             257 KiB 	libdmapsharing-3.0-2          	DMAP client and server library - runtime
            2120 KiB 	libdns-export1110             	Exported DNS Shared Library
              45 KiB 	libdotconf0                   	Configuration file parser library - runtime files
              97 KiB 	libdouble-conversion3         	routines to convert IEEE floats to and from strings
            2340 KiB 	libdpkg-perl                  	Dpkg perl modules
              80 KiB 	libdrm-amdgpu1                	Userspace interface to amdgpu-specific kernel DRM services -- runtime
              45 KiB 	libdrm-common                 	Userspace interface to kernel DRM services -- common files
            1128 KiB 	libdrm-dev                    	Userspace interface to kernel DRM services -- development files
              62 KiB 	libdrm-etnaviv1               	Userspace interface to etnaviv-specific kernel DRM services -- runtime
              79 KiB 	libdrm-freedreno1             	Userspace interface to msm/kgsl kernel DRM services -- runtime
              74 KiB 	libdrm-nouveau2               	Userspace interface to nouveau-specific kernel DRM services -- runtime
              83 KiB 	libdrm-radeon1                	Userspace interface to radeon-specific kernel DRM services -- runtime
              59 KiB 	libdrm-tegra0                 	Userspace interface to tegra-specific kernel DRM services -- runtime
             128 KiB 	libdrm2                       	Userspace interface to kernel DRM services -- runtime
             143 KiB 	libdv4                        	software library for DV format digital video (runtime lib)
             104 KiB 	libdvdnav4                    	DVD navigation library
             147 KiB 	libdvdread8                   	library for reading DVDs
            1630 KiB 	libdw-dev                     	libdw1 development libraries and header files
             693 KiB 	libdw1                        	library that provides access to the DWARF debug information
             421 KiB 	libe-book-0.1-1               	library for reading and converting various  e-book formats
             399 KiB 	libebackend-1.2-10            	Utility library for evolution data servers
             361 KiB 	libebook-1.2-20               	Client library for evolution address books
             216 KiB 	libebook-contacts-1.2-3       	Client library for evolution contacts books
             605 KiB 	libecal-2.0-1                 	Client library for evolution calendars
             819 KiB 	libedata-book-1.2-26          	Backend library for evolution address books
             520 KiB 	libedata-cal-2.0-1            	Backend library for evolution calendars
            1001 KiB 	libedataserver-1.2-26         	Utility library for evolution data servers
             241 KiB 	libedataserverui-1.2-3        	Utility library for evolution data servers
             252 KiB 	libedit2                      	BSD editline and history libraries
             114 KiB 	libefiboot1                   	Library to manage UEFI variables
             163 KiB 	libefivar1                    	Library to manage UEFI variables
             117 KiB 	libegl-dev                    	Vendor neutral GL dispatch library -- EGL development files
             365 KiB 	libegl-mesa0                  	free implementation of the EGL API -- Mesa vendor library
              96 KiB 	libegl1                       	Vendor neutral GL dispatch library -- EGL support
              73 KiB 	libegl1-mesa                  	transitional dummy package
             368 KiB 	libelf-dev                    	libelf1 development libraries and header files
             192 KiB 	libelf1                       	library to read and write ELF files
             169 KiB 	libenchant-2-2                	Wrapper library for various spell checker engines (runtime libs)
              32 KiB 	libencode-locale-perl         	utility to determine the locale encoding
              78 KiB 	libeot0                       	Library for parsing/converting Embedded OpenType files
            1472 KiB 	libepoxy0                     	OpenGL function pointer management library
             340 KiB 	libepubgen-0.1-1              	EPUB generator library
              71 KiB 	liberror-perl                 	Perl module for error/exception handling in an OO-ish way
             474 KiB 	libespeak-ng1                 	Multi-lingual software speech synthesizer: shared library
              30 KiB 	libestr0                      	Helper functions for handling strings (lib)
            7808 KiB 	libetonyek-0.1-1              	library for reading and converting Apple Keynote presentations
             135 KiB 	libevdev2                     	wrapper library for evdev devices
             624 KiB 	libevdocument3-4              	Document (PostScript, PDF) rendering library
             389 KiB 	libevent-2.1-7                	Asynchronous event notification library
             255 KiB 	libevent-core-2.1-7           	Asynchronous event notification library (core)
              42 KiB 	libevent-pthreads-2.1-7       	Asynchronous event notification library (pthreads)
             446 KiB 	libevview3-3                  	Document (PostScript, PDF) rendering library - Gtk+ widgets
            1184 KiB 	libexempi8                    	library to parse XMP metadata (Library)
             578 KiB 	libexif-dev                   	library to parse EXIF files (development files)
             392 KiB 	libexif12                     	library to parse EXIF files
            2968 KiB 	libexiv2-27                   	EXIF/IPTC/XMP metadata manipulation library
             385 KiB 	libexpat1                     	XML parsing C library - runtime library
             699 KiB 	libexpat1-dev                 	XML parsing C library - development kit
             560 KiB 	libext2fs2                    	ext2/ext3/ext4 file system libraries
              46 KiB 	libexttextcat-2.0-0           	Language detection library
             501 KiB 	libexttextcat-data            	Language detection library - data files
              38 KiB 	libextutils-depends-perl      	Perl module for building extensions that depend on other extensions
             479 KiB 	libfaad2                      	freeware Advanced Audio Decoder - runtime files
            1052 KiB 	libfabric1                    	libfabric communication library
             171 KiB 	libfakechroot                 	gives a fake chroot environment - runtime
             166 KiB 	libfakeroot                   	tool for simulating superuser privileges - shared libraries
              61 KiB 	libfastjson4                  	fast json library for C
             433 KiB 	libfdisk1                     	fdisk partitioning library
              59 KiB 	libfdt1                       	Flat Device Trees manipulation library
             295 KiB 	libffi-dev                    	Foreign Function Interface library (development files)
              58 KiB 	libffi7                       	Foreign Function Interface library runtime
              61 KiB 	libffi8                       	Foreign Function Interface library runtime
            1274 KiB 	libfftw3-single3              	Library for computing Fast Fourier Transforms - Single precision
             231 KiB 	libfido2-1                    	library for generating and verifying FIDO 2.0 objects
              39 KiB 	libfile-basedir-perl          	Perl module to use the freedesktop basedir specification
              47 KiB 	libfile-desktopentry-perl     	Perl module to handle freedesktop .desktop files
              31 KiB 	libfile-listing-perl          	module to parse directory listings
             112 KiB 	libfile-mimeinfo-perl         	Perl module to determine file types
             241 KiB 	libflac8                      	Free Lossless Audio Codec - runtime C library
           26655 KiB 	libflite1                     	Small run-time speech synthesis engine - shared libraries
             558 KiB 	libfluidsynth3                	Real-time MIDI software synthesizer (runtime library)
              69 KiB 	libfont-afm-perl              	Perl interface to Adobe Font Metrics files
             326 KiB 	libfontconfig1                	generic font configuration library - runtime
              46 KiB 	libfontenc1                   	X11 font encoding library
             795 KiB 	libfprint-2-2                 	async fingerprint library of fprint project, shared libraries
              38 KiB 	libfreeaptx0                  	Free implementation of aptX
             442 KiB 	libfreehand-0.1-1             	Library for parsing the FreeHand file format structure
             837 KiB 	libfreerdp-client2-2          	Free Remote Desktop Protocol library (client library)
             345 KiB 	libfreerdp-server2-2          	Free Remote Desktop Protocol library (server library)
            1495 KiB 	libfreerdp2-2                 	Free Remote Desktop Protocol library (core library)
             810 KiB 	libfreetype6                  	FreeType 2 font engine, shared library files
              90 KiB 	libfreexl1                    	library for direct reading of Microsoft Excel spreadsheets
             136 KiB 	libfribidi0                   	Free Implementation of the Unicode BiDi algorithm
             274 KiB 	libfuse3-3                    	Filesystem in Userspace (library) (3.x version)
             388 KiB 	libfwupd2                     	Firmware update daemon library
             588 KiB 	libfwupdplugin5               	Firmware update daemon plugin library
             301 KiB 	libfyba0                      	FYBA library to read and write Norwegian geodata standard format SOSI
             462 KiB 	libgail-common                	GNOME Accessibility Implementation Library -- common modules
              99 KiB 	libgail18                     	GNOME Accessibility Implementation Library -- shared libraries
              36 KiB 	libgamemode0                  	Optimise Linux system performance on demand (host library)
              28 KiB 	libgamemodeauto0              	Optimise Linux system performance on demand (client library)
              98 KiB 	libgbm-dev                    	generic buffer management API -- development files
             143 KiB 	libgbm1                       	generic buffer management API -- runtime
             387 KiB 	libgc1                        	conservative garbage collector for C and C++
              81 KiB 	libgcab-1.0-0                 	Microsoft Cabinet file manipulation library
           11214 KiB 	libgcc-11-dev                 	GCC support library (development files)
              99 KiB 	libgcc-s1                     	GCC support library
             254 KiB 	libgck-1-0                    	Glib wrapper library for PKCS#11 - runtime
             674 KiB 	libgcr-base-3-1               	Library for Crypto related tasks
             452 KiB 	libgcr-ui-3-1                 	Library for Crypto UI related tasks
             961 KiB 	libgcrypt20                   	LGPL Crypto library - runtime library
             456 KiB 	libgd3                        	GD Graphics Library
           20621 KiB 	libgdal30                     	Geospatial Data Abstraction Library
              44 KiB 	libgdata-common               	Library for accessing GData webservices - common data files
            1018 KiB 	libgdata22                    	Library for accessing GData webservices - shared libraries
              41 KiB 	libgdbm-compat4               	GNU dbm database routines (legacy support runtime version) 
              99 KiB 	libgdbm6                      	GNU dbm database routines (runtime version) 
            2972 KiB 	libgdcm-dev                   	Grassroots DICOM development libraries and headers
            9787 KiB 	libgdcm3.0                    	Grassroots DICOM runtime libraries
             452 KiB 	libgdk-pixbuf-2.0-0           	GDK Pixbuf library
              71 KiB 	libgdk-pixbuf2.0-bin          	GDK Pixbuf library (thumbnailer)
              56 KiB 	libgdk-pixbuf2.0-common       	GDK Pixbuf library - data files
             282 KiB 	libgdm1                       	GNOME Display Manager (shared library)
             847 KiB 	libgee-0.8-2                  	GObject based collection and utility library
             130 KiB 	libgeoclue-2-0                	convenience library to interact with geoinformation service
             174 KiB 	libgeocode-glib0              	geocoding and reverse geocoding GLib library using Nominatim
             263 KiB 	libgeos-c1v5                  	Geometry engine for Geographic Information Systems - C Library
            2309 KiB 	libgeos3.10.2                 	Geometry engine for Geographic Information Systems - C++ Library
             251 KiB 	libgeotiff5                   	GeoTIFF (geografic enabled TIFF) library -- run-time files
             235 KiB 	libgexiv2-2                   	GObject-based wrapper around the Exiv2 library
             214 KiB 	libgfapi0                     	GlusterFS gfapi shared library
            1521 KiB 	libgfortran5                  	Runtime library for GNU Fortran applications
             274 KiB 	libgfrpc0                     	GlusterFS libgfrpc shared library
             109 KiB 	libgfxdr0                     	GlusterFS libgfxdr shared library
              69 KiB 	libgif7                       	library for GIF images (library)
             174 KiB 	libgirepository-1.0-1         	Library for handling GObject introspection data (runtime library)
            1204 KiB 	libgjs0g                      	Mozilla-based javascript bindings for the GNOME platform
            1356 KiB 	libgl-dev                     	Vendor neutral GL dispatch library -- GL development files
            1037 KiB 	libgl1                        	Vendor neutral GL dispatch library -- legacy GL support
              74 KiB 	libgl1-mesa-dev               	transitional dummy package
           26164 KiB 	libgl1-mesa-dri               	free implementation of the OpenGL API -- DRI modules
              96 KiB 	libgl2ps1.4                   	Lib providing high quality vector output for OpenGL application
             381 KiB 	libglapi-mesa                 	free implementation of the GL API -- shared library
             701 KiB 	libgles-dev                   	Vendor neutral GL dispatch library -- GLES development files
             170 KiB 	libgles1                      	Vendor neutral GL dispatch library -- GLESv1 support
             182 KiB 	libgles2                      	Vendor neutral GL dispatch library -- GLESv2 support
              73 KiB 	libgles2-mesa                 	transitional dummy package
             947 KiB 	libglew2.2                    	OpenGL Extension Wrangler - runtime environment
             218 KiB 	libglib-object-introspection-p	Perl bindings for gobject-introspection libraries
             935 KiB 	libglib-perl                  	interface to the GLib and GObject libraries
            4129 KiB 	libglib2.0-0                  	GLib library of C routines
             318 KiB 	libglib2.0-bin                	Programs for the GLib library
             283 KiB 	libglib2.0-cil                	CLI binding for the GLib utility library 2.12
             150 KiB 	libglib2.0-cil-dev            	CLI binding for the GLib utility library 2.12
             112 KiB 	libglib2.0-data               	Common files for GLib library
           11063 KiB 	libglib2.0-dev                	Development files for the GLib library
             647 KiB 	libglib2.0-dev-bin            	Development utilities for the GLib library
           21807 KiB 	libglib2.0-doc                	Documentation files for the GLib library
            8822 KiB 	libglib2.0-tests              	GLib library of C routines - installed tests
            2540 KiB 	libglibmm-2.4-1v5             	C++ wrapper for the GLib toolkit (shared libraries)
             314 KiB 	libglu1-mesa                  	Mesa OpenGL utility library (GLU)
             893 KiB 	libglusterfs0                 	GlusterFS shared library
              64 KiB 	libglvnd-core-dev             	Vendor neutral GL dispatch library -- core development files
              20 KiB 	libglvnd-dev                  	Vendor neutral GL dispatch library -- development files
            1509 KiB 	libglvnd0                     	Vendor neutral GL dispatch library
              89 KiB 	libglx-dev                    	Vendor neutral GL dispatch library -- GLX development files
             607 KiB 	libglx-mesa0                  	free implementation of the OpenGL API -- GLX vendor library
             155 KiB 	libglx0                       	Vendor neutral GL dispatch library -- GLX support
             301 KiB 	libgme0                       	Playback library for video game music files - shared library
             504 KiB 	libgmp10                      	Multiprecision arithmetic library
             108 KiB 	libgnome-autoar-0-0           	Archives integration support for GNOME
             131 KiB 	libgnome-bg-4-1               	Utility library for background images - runtime files
             142 KiB 	libgnome-bluetooth-3.0-13     	GNOME Bluetooth 3 support library
             254 KiB 	libgnome-bluetooth13          	GNOME Bluetooth tools - support library
             308 KiB 	libgnome-desktop-3-19         	Utility library for the GNOME desktop - GTK 3 version
             198 KiB 	libgnome-desktop-4-1          	Utility library for the GNOME desktop - runtime files
             101 KiB 	libgnome-games-support-1-3    	library for common functions of GNOME games
              40 KiB 	libgnome-games-support-common 	library for common functions of GNOME games (common files)
             131 KiB 	libgnome-menu-3-0             	GNOME implementation of the freedesktop menu specification
              31 KiB 	libgnome-todo                 	library data for GNOME To Do
             104 KiB 	libgnomekbd-common            	GNOME library to manage keyboard configuration - common files
             146 KiB 	libgnomekbd8                  	GNOME library to manage keyboard configuration - shared library
            2296 KiB 	libgnutls30                   	GNU TLS library - main runtime library
             354 KiB 	libgoa-1.0-0b                 	library for GNOME Online Accounts
              60 KiB 	libgoa-1.0-common             	library for GNOME Online Accounts - common files
             398 KiB 	libgoa-backend-1.0-1          	backend library for GNOME Online Accounts
             156 KiB 	libgom-1.0-0                  	Object mapper from GObjects to SQLite
             300 KiB 	libgomp1                      	GCC OpenMP (GOMP) support library
             180 KiB 	libgpg-error0                 	GnuPG development runtime library
             359 KiB 	libgpgme11                    	GPGME - GnuPG Made Easy (library)
             356 KiB 	libgpgmepp6                   	C++ wrapper library for GPGME
            2499 KiB 	libgphoto2-6                  	gphoto2 digital camera library
             186 KiB 	libgphoto2-dev                	gphoto2 digital camera library (development files)
             280 KiB 	libgphoto2-port12             	gphoto2 digital camera port library
             136 KiB 	libgpiod2                     	C library for interacting with Linux GPIO device - shared libraries
              64 KiB 	libgpm2                       	General Purpose Mouse - shared library
             156 KiB 	libgpod-common                	common files for libgpod
             528 KiB 	libgpod4                      	library to read and write songs and artwork to an iPod
             147 KiB 	libgraphene-1.0-0             	library of graphic data types
             143 KiB 	libgraphite2-3                	Font rendering engine for Complex Scripts -- library
             424 KiB 	libgrilo-0.3-0                	Framework for discovering and browsing media - Shared libraries
           24689 KiB 	libgs9                        	interpreter for the PostScript language and for PDF - Library
            3095 KiB 	libgs9-common                 	interpreter for the PostScript language and for PDF - common files
             318 KiB 	libgsf-1-114                  	Structured File Library - runtime version
              60 KiB 	libgsf-1-common               	Structured File Library - common files
              64 KiB 	libgsm1                       	Shared libraries for GSM speech compressor
              34 KiB 	libgsound0                    	small library for playing system sounds
             168 KiB 	libgspell-1-2                 	spell-checking library for GTK+ applications
              48 KiB 	libgspell-1-common            	libgspell architecture-independent files
             439 KiB 	libgssapi-krb5-2              	MIT Kerberos runtime libraries - krb5 GSS-API Mechanism
             133 KiB 	libgssdp-1.2-0                	GObject-based library for SSDP
             613 KiB 	libgstreamer-gl1.0-0          	GStreamer GL libraries
             128 KiB 	libgstreamer-opencv1.0-0      	GStreamer OpenCV libraries
            1565 KiB 	libgstreamer-plugins-bad1.0-0 	GStreamer libraries from the "bad" set
            2154 KiB 	libgstreamer-plugins-bad1.0-de	GStreamer development files for libraries from the "bad" set
            2592 KiB 	libgstreamer-plugins-base1.0-0	GStreamer libraries from the "base" set
            5855 KiB 	libgstreamer-plugins-base1.0-d	GStreamer development files for libraries from the "base" set
             158 KiB 	libgstreamer-plugins-good1.0-0	GStreamer development files for libraries from the "good" set
             150 KiB 	libgstreamer-plugins-good1.0-d	GStreamer development files for libraries from the "good" set
            2888 KiB 	libgstreamer1.0-0             	Core GStreamer libraries and elements
            6059 KiB 	libgstreamer1.0-dev           	GStreamer core development files
           10246 KiB 	libgtk-3-0                    	GTK graphical user interface library
             432 KiB 	libgtk-3-common               	common files for the GTK graphical user interface library
            8602 KiB 	libgtk-4-1                    	GTK graphical user interface library
            8445 KiB 	libgtk-4-bin                  	programs for the GTK graphical user interface library
            2208 KiB 	libgtk-4-common               	common files for the GTK graphical user interface library
            5946 KiB 	libgtk2.0-0                   	GTK graphical user interface library - old version
              72 KiB 	libgtk2.0-bin                 	programs for the GTK graphical user interface library
             268 KiB 	libgtk2.0-common              	common files for the GTK graphical user interface library
             107 KiB 	libgtk3-perl                  	Perl bindings for the GTK+ graphical user interface library
            4777 KiB 	libgtkmm-3.0-1v5              	C++ wrappers for GTK+ (shared libraries)
             684 KiB 	libgtksourceview-4-0          	shared libraries for the GTK+ syntax highlighting widget
            2720 KiB 	libgtksourceview-4-common     	common files for the GTK+ syntax highlighting widget
             108 KiB 	libgtop-2.0-11                	gtop system monitoring library (shared)
              44 KiB 	libgtop2-common               	gtop system monitoring library (common)
              64 KiB 	libgudev-1.0-0                	GObject-based wrapper library for libudev
             373 KiB 	libgudev-1.0-dev              	libgudev-1.0 development files
             258 KiB 	libgupnp-1.2-1                	GObject-based library for UPnP
             305 KiB 	libgupnp-av-1.0-3             	Audio/Visual utility library for GUPnP
             320 KiB 	libgupnp-dlna-2.0-4           	DLNA utility library for GUPnP
              51 KiB 	libgupnp-igd-1.0-4            	library to handle UPnP IGD port mapping
              92 KiB 	libgusb2                      	GLib wrapper around libusb1
             830 KiB 	libgweather-3-16              	GWeather shared library
            1644 KiB 	libgweather-common            	GWeather common files
             163 KiB 	libgxps2                      	handling and rendering XPS documents (library)
             760 KiB 	libhandy-1-0                  	Library with GTK widgets for mobile phones
              31 KiB 	libharfbuzz-icu0              	OpenType text shaping engine ICU backend
             824 KiB 	libharfbuzz0b                 	OpenType text shaping engine (shared library)
             122 KiB 	libhavege2                    	entropy source using the HAVEGE algorithm - shared library
             718 KiB 	libhdf4-0-alt                 	Hierarchical Data Format library (without NetCDF)
            4009 KiB 	libhdf5-103-1                 	HDF5 C runtime files - serial version
             191 KiB 	libhdf5-hl-100                	HDF5 High Level runtime files - serial version
             502 KiB 	libheif1                      	ISO/IEC 23008-12:2017 HEIF file format decoder - shared library
             330 KiB 	libhogweed6                   	low level cryptographic library (public-key cryptos)
              62 KiB 	libhtml-form-perl             	module that represents an HTML form element
             126 KiB 	libhtml-format-perl           	module for transforming HTML into various formats
             213 KiB 	libhtml-parser-perl           	collection of modules that parse HTML text documents
              31 KiB 	libhtml-tagset-perl           	data tables pertaining to HTML
             481 KiB 	libhtml-tree-perl             	Perl module to represent and create HTML syntax trees
              50 KiB 	libhttp-cookies-perl          	HTTP cookie jars
              56 KiB 	libhttp-daemon-perl           	simple http server class
              29 KiB 	libhttp-date-perl             	module of date conversion routines
             191 KiB 	libhttp-message-perl          	perl interface to HTTP style messages
              34 KiB 	libhttp-negotiate-perl        	implementation of content negotiation
             437 KiB 	libhunspell-1.7-0             	spell checker and morphological analyzer (shared library)
            3147 KiB 	libhwasan0                    	AddressSanitizer -- a fast memory error detector
              76 KiB 	libhwloc-plugins              	Hierarchical view of the machine - plugins
             353 KiB 	libhwloc15                    	Hierarchical view of the machine - shared libs
              74 KiB 	libhyphen0                    	ALTLinux hyphenation library - shared library
              29 KiB 	libi2c0                       	userspace I2C programming library
             549 KiB 	libibus-1.0-5                 	Intelligent Input Bus - shared library
             182 KiB 	libibverbs1                   	Library for direct userspace use of RDMA (InfiniBand/iWARP)
            1388 KiB 	libical3                      	iCalendar library implementation in C (runtime)
             108 KiB 	libice6                       	X11 Inter-Client Exchange library
           45830 KiB 	libicu-dev                    	Development files for International Components for Unicode
           34279 KiB 	libicu70                      	International Components for Unicode
             227 KiB 	libidn12                      	GNU Libidn library, implementation of IETF IDN specifications
             212 KiB 	libidn2-0                     	Internationalized domain names (IDNA2008/TR46) library
              74 KiB 	libiec61883-0                 	partial implementation of IEC 61883 (shared lib)
              67 KiB 	libieee1284-3                 	cross-platform library for parallel port access
              46 KiB 	libijs-0.35                   	IJS raster image transport protocol: shared library
             635 KiB 	libilmbase-dev                	development files for IlmBase
             868 KiB 	libilmbase25                  	several utility libraries from ILM used by OpenEXR
              80 KiB 	libimagequant0                	palette quantization library
             206 KiB 	libimobiledevice6             	Library for communicating with iPhone and other Apple devices
             125 KiB 	libini-config5                	INI file parser for C
              25 KiB 	libinih1                      	simple .INI file parser
              34 KiB 	libiniparser1                 	runtime library for the iniParser INI file reader/writer
             119 KiB 	libinput-bin                  	input device management and event handling library - udev quirks
             330 KiB 	libinput10                    	input device management and event handling library - shared library
             817 KiB 	libinstpatch-1.0-2            	MIDI instrument editing library
              40 KiB 	libio-html-perl               	open an HTML file with automatic charset detection
             561 KiB 	libio-socket-ssl-perl         	Perl module implementing object oriented interface to SSL sockets
             134 KiB 	libio-stringy-perl            	modules for I/O on in-core objects (strings/arrays)
              79 KiB 	libip4tc2                     	netfilter libip4tc library
              79 KiB 	libip6tc2                     	netfilter libip6tc library
              51 KiB 	libipa-hbac0                  	FreeIPA HBAC Evaluator library
              61 KiB 	libipc-system-simple-perl     	Perl module to run commands simply, with detailed diagnostics
             221 KiB 	libiperf0                     	Internet Protocol bandwidth measuring tool (runtime files)
              87 KiB 	libirs-export161              	Exported IRS Shared Library
             494 KiB 	libisc-export1105             	Exported ISC Shared Library
             220 KiB 	libisccfg-export163           	Exported ISC CFG Shared Library
            2107 KiB 	libisl23                      	manipulating sets and relations of integer points bounded by linear constraints
             110 KiB 	libitm1                       	GNU Transactional Memory Library
              56 KiB 	libiw30                       	Wireless tools - library
            1111 KiB 	libjack-jackd2-0              	JACK Audio Connection Kit (libraries)
              91 KiB 	libjansson4                   	C library for encoding, decoding and manipulating JSON data
           26691 KiB 	libjavascriptcoregtk-4.0-18   	JavaScript engine library from WebKitGTK
              84 KiB 	libjbig-dev                   	JBIGkit development files
              69 KiB 	libjbig0                      	JBIGkit libraries
             170 KiB 	libjbig2dec0                  	JBIG2 decoder library - shared libraries
              91 KiB 	libjcat1                      	JSON catalog library
               9 KiB 	libjpeg-dev                   	Independent JPEG Group's JPEG runtime library (dependency package)
             327 KiB 	libjpeg-turbo8                	IJG JPEG compliant runtime library.
             648 KiB 	libjpeg-turbo8-dev            	Development files for the IJG JPEG library
               9 KiB 	libjpeg8                      	Independent JPEG Group's JPEG runtime library (dependency package)
               9 KiB 	libjpeg8-dev                  	Independent JPEG Group's JPEG runtime library (dependency package)
             679 KiB 	libjs-jquery                  	JavaScript library for dynamic web applications
            2400 KiB 	libjs-jquery-ui               	JavaScript UI library for dynamic web applications
             194 KiB 	libjs-sphinxdoc               	JavaScript support for Sphinx documentation
             345 KiB 	libjs-underscore              	JavaScript's functional programming helper library
              94 KiB 	libjson-c5                    	JSON manipulation library - shared library
             205 KiB 	libjson-glib-1.0-0            	GLib JSON manipulation library
              44 KiB 	libjson-glib-1.0-common       	GLib JSON manipulation library (common files)
             211 KiB 	libjsoncpp25                  	library for reading and writing JSON for C++
             284 KiB 	libk5crypto3                  	MIT Kerberos runtime libraries - Crypto Library
             104 KiB 	libkate1                      	Codec for karaoke and text encapsulation
              42 KiB 	libkeyutils1                  	Linux Key Management Utilities (library)
             126 KiB 	libklibc                      	minimal libc subset for use with initramfs
             142 KiB 	libkmlbase1                   	Library to manipulate KML 2.2 OGC standard files - libkmlbase
             736 KiB 	libkmldom1                    	Library to manipulate KML 2.2 OGC standard files - libkmldom
             261 KiB 	libkmlengine1                 	Library to manipulate KML 2.2 OGC standard files - libkmlengine
             130 KiB 	libkmod2                      	libkmod shared library
             256 KiB 	libkpathsea6                  	TeX Live: path search library for TeX (runtime part)
            1019 KiB 	libkrb5-3                     	MIT Kerberos runtime libraries
             164 KiB 	libkrb5support0               	MIT Kerberos runtime libraries - Support library
             293 KiB 	libksba8                      	X.509 and CMS support library
            1993 KiB 	liblangtag-common             	library to access tags for identifying languages -- data
             169 KiB 	liblangtag1                   	library to access tags for identifying languages
            5575 KiB 	liblapack3                    	Library of linear algebra routines 3 - shared version
              61 KiB 	liblbfgsb0                    	Limited-memory quasi-Newton bound-constrained optimization
             398 KiB 	liblcms2-2                    	Little CMS 2 color management library
             151 KiB 	liblcms2-utils                	Little CMS 2 color management library (utilities)
              62 KiB 	libldacbt-enc2                	LDAC Bluetooth encoder library (shared library)
             549 KiB 	libldap-2.5-0                 	OpenLDAP libraries
             528 KiB 	libldb2                       	LDAP-like embedded database - shared library
            2900 KiB 	liblept5                      	image processing library
             131 KiB 	liblilv-0-0                   	library for simple use of LV2 plugins
              86 KiB 	liblirc-client0               	infra-red remote control support - client library
          108644 KiB 	libllvm15                     	Modular compiler and toolchain technologies, runtime library
             104 KiB 	liblmdb0                      	Lightning Memory-Mapped Database shared library
              55 KiB 	liblocale-gettext-perl        	module using libc functions for internationalization in Perl
           10577 KiB 	liblouis-data                 	Braille translation library - data
             185 KiB 	liblouis20                    	Braille translation library - shared libs
            2951 KiB 	liblsan0                      	LeakSanitizer -- a memory leak detector (runtime)
              39 KiB 	libltc11                      	linear timecode library
             419 KiB 	libltdl7                      	System independent dlopen wrapper for GNU libtool
             489 KiB 	liblua5.3-0                   	Shared library for the Lua interpreter version 5.3
              72 KiB 	liblwp-mediatypes-perl        	module to guess media type for a file or a URL
              27 KiB 	liblwp-protocol-https-perl    	HTTPS driver for LWP::UserAgent
             132 KiB 	liblz4-1                      	Fast LZ compression algorithm library - runtime
             607 KiB 	liblzma-dev                   	XZ-format compression library - development files
             278 KiB 	liblzma5                      	XZ-format compression library
             142 KiB 	liblzo2-2                     	data compression library
            7128 KiB 	libmagic-mgc                  	File type determination library using "magic" numbers (compiled magic file)
             213 KiB 	libmagic1                     	Recognize the type of data in a file using "magic" numbers - library
             223 KiB 	libmailtools-perl             	modules to manipulate email in perl programs
              77 KiB 	libmalcontent-0-0             	library for parental control of applications
             202 KiB 	libmanette-0.2-0              	Simple GObject game controller library
              76 KiB 	libmaxminddb0                 	IP geolocation database library
             683 KiB 	libmbim-glib4                 	Support library to use the MBIM protocol
              29 KiB 	libmbim-proxy                 	Proxy to communicate with MBIM ports
              67 KiB 	libmd0                        	message digest functions from BSD systems - shared library
              55 KiB 	libmediaart-2.0-0             	media art extraction and cache management library
              86 KiB 	libmessaging-menu0            	Ayatana Messaging Menu - shared library
             193 KiB 	libmhash2                     	Library for cryptographic hashing and message authentication
              72 KiB 	libminiupnpc17                	UPnP IGD client lightweight library
              55 KiB 	libminizip1                   	compression library - minizip library
              69 KiB 	libmjpegutils-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
            1274 KiB 	libmm-glib0                   	D-Bus service for managing modems - shared libraries
              42 KiB 	libmnl0                       	minimalistic Netlink communication library
             330 KiB 	libmodplug1                   	shared libraries for mod music based on ModPlug
             112 KiB 	libmono-btls-interface4.0-cil 	Mono Mono.Btls.Interface library (for CLI 4.0)
              78 KiB 	libmono-corlib4.5-cil         	Mono core library (for CLI 4.5)
            4779 KiB 	libmono-corlib4.5-dll         	Mono core library (for CLI 4.5)
             154 KiB 	libmono-i18n-west4.0-cil      	Mono I18N.West library (for CLI 4.0)
             123 KiB 	libmono-i18n4.0-cil           	Mono I18N base library (for CLI 4.0)
             340 KiB 	libmono-security4.0-cil       	Mono Security library (for CLI 4.0)
             211 KiB 	libmono-system-configuration4.	Mono System.Configuration library (for CLI 4.0)
            1226 KiB 	libmono-system-core4.0-cil    	Mono System.Core library (for CLI 4.0)
             209 KiB 	libmono-system-numerics4.0-cil	Mono System.Numerics library (for CLI 4.0)
             409 KiB 	libmono-system-security4.0-cil	Mono System.Security library (for CLI 4.0)
            3372 KiB 	libmono-system-xml4.0-cil     	Mono System.Xml library (for CLI 4.0)
            2792 KiB 	libmono-system4.0-cil         	Mono System libraries (for CLI 4.0)
             140 KiB 	libmount-dev                  	device mounting library - headers
             382 KiB 	libmount1                     	device mounting library
           10981 KiB 	libmozjs-91-0                 	SpiderMonkey JavaScript library
             293 KiB 	libmp3lame0                   	MP3 encoding library
             121 KiB 	libmpc3                       	multiple precision complex floating-point library
              80 KiB 	libmpcdec6                    	MusePack decoder - library
             246 KiB 	libmpdec3                     	library for decimal floating point arithmetic (runtime library)
             134 KiB 	libmpeg2-4                    	MPEG1 and MPEG2 video decoder library
             173 KiB 	libmpeg2encpp-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
            1134 KiB 	libmpfr6                      	multiple precision floating-point computation
             340 KiB 	libmpg123-0                   	MPEG layer 1/2/3 audio decoder (shared library)
             129 KiB 	libmplex2-2.1-0               	MJPEG capture/editing/replay and MPEG encoding toolset (library)
             341 KiB 	libmspub-0.1-1                	library for parsing the mspub file structure
              51 KiB 	libmtdev1                     	Multitouch Protocol Translation Library - shared library
             143 KiB 	libmtp-common                 	Media Transfer Protocol (MTP) common files
              36 KiB 	libmtp-runtime                	Media Transfer Protocol (MTP) runtime tools
             516 KiB 	libmtp9                       	Media Transfer Protocol (MTP) library
              30 KiB 	libmulticobex1                	multi-protocol cable OBEX library
            3908 KiB 	libmutter-10-0                	window manager library from the Mutter window manager
            5396 KiB 	libmwaw-0.3-3                 	import library for some old Mac text documents
            1258 KiB 	libmysofa1                    	library to read HRTFs stored in the AES69-2015 SOFA format
            6661 KiB 	libmysqlclient21              	MySQL database client library
              32 KiB 	libmythes-1.2-0               	simple thesaurus library
              25 KiB 	libnatpmp1                    	portable and fully compliant implementation of NAT-PMP
              85 KiB 	libnautilus-extension1a       	libraries for nautilus components - runtime version
             293 KiB 	libncurses5                   	shared libraries for terminal handling (legacy version)
             303 KiB 	libncurses6                   	shared libraries for terminal handling
             392 KiB 	libncursesw6                  	shared libraries for terminal handling (wide character support)
             185 KiB 	libndctl6                     	Utility library for managing the libnvdimm subsystem
              41 KiB 	libndp0                       	Library for Neighbor Discovery Protocol
             621 KiB 	libnet-dbus-perl              	Perl extension for the DBus bindings
              61 KiB 	libnet-http-perl              	module providing low-level HTTP connection client
              19 KiB 	libnet-smtp-ssl-perl          	Perl module providing SSL support to Net::SMTP
            1361 KiB 	libnet-ssleay-perl            	Perl module for Secure Sockets Layer (SSL)
            1466 KiB 	libnetcdf19                   	Interface for scientific data access to large binary data
             133 KiB 	libnetfilter-conntrack3       	Netfilter netlink-conntrack library
             340 KiB 	libnettle8                    	low level cryptographic library (symmetric and one-way cryptos)
             196 KiB 	libnewt0.52                   	Not Erik's Windowing Toolkit - text mode windowing with slang
              40 KiB 	libnfnetlink0                 	Netfilter netlink library
             364 KiB 	libnfs13                      	NFS client library (shared library)
             193 KiB 	libnfsidmap1                  	NFS idmapping library
             875 KiB 	libnftables1                  	Netfilter nftables high level userspace API library
             226 KiB 	libnftnl11                    	Netfilter nftables userspace API library
             195 KiB 	libnghttp2-14                 	library implementing HTTP/2 protocol (shared library)
             371 KiB 	libnice10                     	ICE library (shared library)
             180 KiB 	libnl-3-200                   	library for dealing with netlink sockets
              52 KiB 	libnl-genl-3-200              	library for dealing with netlink sockets - generic netlink
             572 KiB 	libnl-route-3-200             	library for dealing with netlink sockets - route interface
            1475 KiB 	libnm0                        	GObject-based client library for NetworkManager
              52 KiB 	libnma-common                 	NetworkManager GUI library - translations
             382 KiB 	libnma0                       	NetworkManager GUI library
             485 KiB 	libnorm1                      	NACK-Oriented Reliable Multicast (NORM) library
              35 KiB 	libnotify-bin                 	sends desktop notifications to a notification daemon (Utilities)
              61 KiB 	libnotify4                    	sends desktop notifications to a notification daemon
              36 KiB 	libnpth0                      	replacement for GNU Pth using system threads
             351 KiB 	libnsl-dev                    	libnsl development files
             118 KiB 	libnsl2                       	Public client interface for NIS(YP) and NIS+
             310 KiB 	libnspr4                      	NetScape Portable Runtime Library
             124 KiB 	libnss-mdns                   	NSS module for Multicast DNS name resolution
              84 KiB 	libnss-sss                    	Nss library for the System Security Services Daemon
             491 KiB 	libnss-systemd                	nss module providing dynamic user and group name resolution
            3422 KiB 	libnss3                       	Network Security Service libraries
             359 KiB 	libntfs-3g89                  	read/write NTFS driver for FUSE (runtime library)
              70 KiB 	libnuma1                      	Libraries for controlling NUMA policy
              54 KiB 	libobexftp0                   	object exchange file transfer library
             411 KiB 	libodbc2                      	ODBC Driver Manager library for Unix
              90 KiB 	libodbcinst2                  	Support library for accessing ODBC configuration files
             659 KiB 	libodfgen-0.1-1               	library to generate ODF documents
             573 KiB 	libogdi4.1                    	Open Geographic Datastore Interface Library -- library
              54 KiB 	libogg0                       	Ogg bitstream library
             207 KiB 	libopenal-data                	Software implementation of the OpenAL audio API (data files)
             935 KiB 	libopenal1                    	Software implementation of the OpenAL audio API (shared library)
              55 KiB 	libopenblas-dev               	Optimized BLAS (linear algebra) library (dev, meta)
           34513 KiB 	libopenblas-pthread-dev       	Optimized BLAS (linear algebra) library (dev, pthread)
              43 KiB 	libopenblas0                  	Optimized BLAS (linear algebra) library (meta)
           26050 KiB 	libopenblas0-pthread          	Optimized BLAS (linear algebra) library (shared lib, pthread)
             175 KiB 	libopencore-amrnb0            	Adaptive Multi Rate speech codec - shared library
              92 KiB 	libopencore-amrwb0            	Adaptive Multi-Rate - Wideband speech codec - shared library
            5061 KiB 	libopencv-calib3d-dev         	development files for libopencv-calib3d4.5d
            1492 KiB 	libopencv-calib3d4.5d         	computer vision Camera Calibration library
           24450 KiB 	libopencv-contrib-dev         	development files for libopencv-contrib4.5d
            7759 KiB 	libopencv-contrib4.5d         	computer vision contrlib library
           11039 KiB 	libopencv-core-dev            	development files for libopencv-core4.5d
            2588 KiB 	libopencv-core4.5d            	computer vision core library
             327 KiB 	libopencv-dev                 	development files for opencv
           12579 KiB 	libopencv-dnn-dev             	development files for libopencv-dnn4.5d
            3097 KiB 	libopencv-dnn4.5d             	computer vision Deep neural network module
            1671 KiB 	libopencv-features2d-dev      	development files for libopencv-features2d4.5d
             581 KiB 	libopencv-features2d4.5d      	computer vision Feature Detection and Descriptor Extraction library
            1718 KiB 	libopencv-flann-dev           	development files for libopencv-flann4.5d
             413 KiB 	libopencv-flann4.5d           	computer vision Clustering and Search in Multi-Dimensional spaces library
             743 KiB 	libopencv-highgui-dev         	development files for libopencv-highgui4.5d
             220 KiB 	libopencv-highgui4.5d         	computer vision High-level GUI and Media I/O library
            1302 KiB 	libopencv-imgcodecs-dev       	development files for libopencv-imgcodecs4.5d
             340 KiB 	libopencv-imgcodecs4.5d       	computer vision Image Codecs library
            7257 KiB 	libopencv-imgproc-dev         	development files for libopencv-imgproc4.5d
            2880 KiB 	libopencv-imgproc4.5d         	computer vision Image Processing library
            1560 KiB 	libopencv-ml-dev              	development files for libopencv-ml4.5d
             460 KiB 	libopencv-ml4.5d              	computer vision Machine Learning library
            1116 KiB 	libopencv-objdetect-dev       	development files for libopencv-objdetect4.5d
             401 KiB 	libopencv-objdetect4.5d       	computer vision Object Detection library
            1359 KiB 	libopencv-photo-dev           	development files for libopencv-photo4.5d
             504 KiB 	libopencv-photo4.5d           	computer vision computational photography library
             447 KiB 	libopencv-shape-dev           	development files for libopencv-shape4.5d
             148 KiB 	libopencv-shape4.5d           	computer vision shape descriptors and matchers library
            1651 KiB 	libopencv-stitching-dev       	development files for libopencv-stitching4.5d
             509 KiB 	libopencv-stitching4.5d       	computer vision image stitching library
             363 KiB 	libopencv-superres-dev        	development files for libopencv-superres4.5d
             156 KiB 	libopencv-superres4.5d        	computer vision Super Resolution library
            1324 KiB 	libopencv-video-dev           	development files for libopencv-video4.5d
             445 KiB 	libopencv-video4.5d           	computer vision Video analysis library
            1782 KiB 	libopencv-videoio-dev         	development files for libopencv-videoio4.5d
             505 KiB 	libopencv-videoio4.5d         	computer vision Video I/O library
             687 KiB 	libopencv-videostab-dev       	development files for libopencv-videostab4.5d
             220 KiB 	libopencv-videostab4.5d       	computer vision video stabilization library
            1259 KiB 	libopencv-viz-dev             	development files for libopencv-viz4.5d
             340 KiB 	libopencv-viz4.5d             	computer vision 3D data visualization library
             774 KiB 	libopenexr-dev                	development files for the OpenEXR image library
            2912 KiB 	libopenexr25                  	runtime files for the OpenEXR image library
              22 KiB 	libopengl-dev                 	Vendor neutral GL dispatch library -- OpenGL development files
             412 KiB 	libopengl0                    	Vendor neutral GL dispatch library -- OpenGL support
             903 KiB 	libopenh264-6                 	OpenH264 Video Codec
             383 KiB 	libopenjp2-7                  	JPEG 2000 image compression/decompression library
            8817 KiB 	libopenmpi3                   	high performance message passing library -- shared library
            1331 KiB 	libopenmpt0                   	module music library based on OpenMPT -- shared library
            1467 KiB 	libopenni2-0                  	framework for sensor-based 'Natural Interaction'
             123 KiB 	libopenobex2                  	OBEX protocol library
             347 KiB 	libopus0                      	Opus codec runtime library
            1068 KiB 	liborc-0.4-0                  	Library of Optimized Inner Loops Runtime Compiler
            1384 KiB 	liborc-0.4-dev                	Library of Optimized Inner Loops Runtime Compiler (development headers)
            1075 KiB 	liborc-0.4-dev-bin            	Library of Optimized Inner Loops Runtime Compiler (development tools)
            1152 KiB 	liborcus-0.17-0               	library for processing spreadsheet documents
             296 KiB 	liborcus-parser-0.17-0        	library for processing spreadsheet documents - parser library
            1292 KiB 	libp11-kit0                   	library for loading and coordinating access to PKCS#11 modules - runtime
             455 KiB 	libpackagekit-glib2-18        	Library for accessing PackageKit using GLib
             148 KiB 	libpagemaker-0.0-0            	Library for importing and converting PageMaker Documents
              50 KiB 	libpam-fprintd                	PAM module for fingerprint authentication through fprintd
              67 KiB 	libpam-gnome-keyring          	PAM module to unlock the GNOME keyring upon login
             936 KiB 	libpam-modules                	Pluggable Authentication Modules for PAM
             221 KiB 	libpam-modules-bin            	Pluggable Authentication Modules for PAM - helper binaries
              36 KiB 	libpam-pwquality              	PAM module to check password strength
             312 KiB 	libpam-runtime                	Runtime support for the PAM library
             121 KiB 	libpam-sss                    	Pam module for the System Security Services Daemon
             650 KiB 	libpam-systemd                	system and service manager - PAM module
             220 KiB 	libpam0g                      	Pluggable Authentication Modules library
             555 KiB 	libpango-1.0-0                	Layout and rendering of internationalized text
             146 KiB 	libpangocairo-1.0-0           	Layout and rendering of internationalized text
             189 KiB 	libpangoft2-1.0-0             	Layout and rendering of internationalized text
             219 KiB 	libpangomm-1.4-1v5            	C++ Wrapper for pango (shared libraries)
             125 KiB 	libpangoxft-1.0-0             	Layout and rendering of internationalized text
              39 KiB 	libpaper-utils                	library for handling paper characteristics (utilities)
              60 KiB 	libpaper1                     	library for handling paper characteristics
              32 KiB 	libpaps0                      	UTF-8 to PostScript converter library using Pango
             139 KiB 	libparted-fs-resize0          	disk partition manipulator - shared FS resizing library
             454 KiB 	libparted2                    	disk partition manipulator - shared library
              33 KiB 	libpath-utils1                	Filesystem Path Utilities
             333 KiB 	libpcap0.8                    	system interface for user-level packet capture
              33 KiB 	libpcaudio0                   	C API to different audio devices - shared library
              82 KiB 	libpci3                       	PCI utilities (shared library)
             100 KiB 	libpciaccess-dev              	Generic PCI access library for X - development files
              57 KiB 	libpciaccess0                 	Generic PCI access library for X
             498 KiB 	libpcre16-3                   	Old Perl 5 Compatible Regular Expression Library - 16 bit runtime files
             492 KiB 	libpcre2-16-0                 	New Perl Compatible Regular Expression Library - 16 bit runtime files
             476 KiB 	libpcre2-32-0                 	New Perl Compatible Regular Expression Library - 32 bit runtime files
             541 KiB 	libpcre2-8-0                  	New Perl Compatible Regular Expression Library- 8 bit runtime files
            2066 KiB 	libpcre2-dev                  	New Perl Compatible Regular Expression Library - development files
              30 KiB 	libpcre2-posix3               	New Perl Compatible Regular Expression Library - posix-compatible runtime files
             617 KiB 	libpcre3                      	Old Perl 5 Compatible Regular Expression Library - runtime files
            1891 KiB 	libpcre3-dev                  	Old Perl 5 Compatible Regular Expression Library - development files
             486 KiB 	libpcre32-3                   	Old Perl 5 Compatible Regular Expression Library - 32 bit runtime files
             188 KiB 	libpcrecpp0v5                 	Old Perl 5 Compatible Regular Expression Library - C++ runtime files
              62 KiB 	libpcsclite1                  	Middleware to access a smart card using PC/SC (library)
             216 KiB 	libpeas-1.0-0                 	Application plugin library
             108 KiB 	libpeas-common                	Application plugin library (common files)
           27963 KiB 	libperl5.34                   	shared Perl library
             321 KiB 	libpgm-5.3-0                  	OpenPGM shared library
             669 KiB 	libphonenumber8               	parsing/formatting/validating phone numbers
              64 KiB 	libpipeline1                  	Unix process pipeline manipulation library
             917 KiB 	libpipewire-0.3-0             	libraries for the PipeWire multimedia server
              52 KiB 	libpipewire-0.3-common        	libraries for the PipeWire multimedia server - common files
            2237 KiB 	libpipewire-0.3-modules       	libraries for the PipeWire multimedia server - modules
             431 KiB 	libpixman-1-0                 	pixel-manipulation library for X and cairo
             623 KiB 	libpixman-1-dev               	pixel-manipulation library for X and cairo (development files)
             145 KiB 	libpkcs11-helper1             	library that simplifies the interaction with PKCS#11
              87 KiB 	libplist3                     	Library for handling Apple binary and XML property lists
             383 KiB 	libplymouth5                  	graphical boot animation and logger - shared libraries
             101 KiB 	libpmem1                      	Persistent Memory low level support library, v1 runtime
             169 KiB 	libpmemblk1                   	Persistent Memory block array support library
             317 KiB 	libpmemobj1                   	Persistent Memory object store support library
            1868 KiB 	libpmix2                      	Process Management Interface (Exascale) library
             720 KiB 	libpng-dev                    	PNG library - development (version 1.6)
             332 KiB 	libpng16-16                   	PNG library - runtime (version 1.6)
             298 KiB 	libpocketsphinx3              	Speech recognition tool - front-end library
              72 KiB 	libpolkit-agent-1-0           	PolicyKit Authentication Agent API
             154 KiB 	libpolkit-gobject-1-0         	PolicyKit Authorization API
             460 KiB 	libpoppler-glib8              	PDF rendering library (GLib-based shared library)
            3366 KiB 	libpoppler118                 	PDF rendering library
             146 KiB 	libpopt-dev                   	lib for parsing cmdline parameters - development files
             120 KiB 	libpopt0                      	lib for parsing cmdline parameters
             121 KiB 	libpostproc55                 	FFmpeg library for post processing - runtime files
             396 KiB 	libpq5                        	PostgreSQL C client library
             126 KiB 	libprocps8                    	library for accessing process information from /proc
            3329 KiB 	libproj22                     	Cartographic projection library
            2647 KiB 	libprotobuf23                 	protocol buffers C++ library
              68 KiB 	libproxy1-plugin-gsettings    	automatic proxy configuration management library (GSettings plugin)
              32 KiB 	libproxy1-plugin-networkmanage	automatic proxy configuration management library (Network Manager plugin)
             129 KiB 	libproxy1v5                   	automatic proxy configuration management library (shared)
              91 KiB 	libpsl5                       	Library for Public Suffix List (shared libraries)
              18 KiB 	libpthread-stubs0-dev         	pthread stubs not provided by native libc, development files
             134 KiB 	libpulse-mainloop-glib0       	PulseAudio client libraries (glib support)
             956 KiB 	libpulse0                     	PulseAudio client libraries
             157 KiB 	libpulsedsp                   	PulseAudio OSS pre-load library
              68 KiB 	libpwquality-common           	library for password quality checking and generation (data files)
              40 KiB 	libpwquality1                 	library for password quality checking and generation
              38 KiB 	libpython2-stdlib             	interactive high-level object-oriented language (Python2)
            3426 KiB 	libpython2.7                  	Shared Python runtime library (version 2.7)
            2784 KiB 	libpython2.7-minimal          	Minimal subset of the Python language (version 2.7)
            8679 KiB 	libpython2.7-stdlib           	Interactive high-level object-oriented language (standard library, version 2.7)
              49 KiB 	libpython3-dev                	header files and a static library for Python (default)
              39 KiB 	libpython3-stdlib             	interactive high-level object-oriented language (default python3 version)
            5697 KiB 	libpython3.10                 	Shared Python runtime library (version 3.10)
           18689 KiB 	libpython3.10-dev             	Header files and a static library for Python (v3.10)
            5097 KiB 	libpython3.10-minimal         	Minimal subset of the Python language (version 3.10)
            7870 KiB 	libpython3.10-stdlib          	Interactive high-level object-oriented language (standard library, version 3.10)
             504 KiB 	libqhull-r8.0                 	calculate convex hulls and related structures (reentrant shared library)
            3763 KiB 	libqmi-glib5                  	Support library to use the Qualcomm MSM Interface (QMI) protocol
              32 KiB 	libqmi-proxy                  	Proxy to communicate with QMI ports
              53 KiB 	libqqwing2v5                  	tool for generating and solving Sudoku puzzles (library)
              66 KiB 	libqrencode4                  	QR Code encoding library
             107 KiB 	librabbitmq4                  	AMQP client library written in C
           13195 KiB 	librados2                     	RADOS distributed object store client library
             416 KiB 	libraptor2-0                  	Raptor 2 RDF syntax library
              34 KiB 	libraqm0                      	Library for complex text layout
             513 KiB 	librasqal3                    	Rasqal RDF query library
              82 KiB 	libraw1394-11                 	library for direct access to IEEE 1394 bus (aka FireWire)
             179 KiB 	libraw1394-dev                	library for direct access to IEEE 1394 bus - development files
            2135 KiB 	libraw20                      	raw image decoder library
           13568 KiB 	librbd1                       	RADOS block device client library
             279 KiB 	librdf0                       	Redland Resource Description Framework (RDF) library
            1627 KiB 	librdkafka1                   	library implementing the Apache Kafka protocol
             187 KiB 	librdmacm1                    	Library for managing RDMA connections
             456 KiB 	libreadline8                  	GNU readline and history libraries, run-time libraries
              28 KiB 	libref-array1                 	refcounted array for C
            3285 KiB 	libreoffice-base-core         	office productivity suite -- shared library
           31493 KiB 	libreoffice-calc              	office productivity suite -- spreadsheet
           57699 KiB 	libreoffice-common            	office productivity suite -- arch-independent files
          127122 KiB 	libreoffice-core              	office productivity suite -- arch-dependent files
           14313 KiB 	libreoffice-draw              	office productivity suite -- drawing
             451 KiB 	libreoffice-gnome             	office productivity suite -- GNOME integration
            2305 KiB 	libreoffice-gtk3              	office productivity suite -- GTK+ 3 integration
            9909 KiB 	libreoffice-impress           	office productivity suite -- presentation
            2337 KiB 	libreoffice-math              	office productivity suite -- equation editor
             242 KiB 	libreoffice-pdfimport         	transitional package for PDF Import component for LibreOffice
            7128 KiB 	libreoffice-style-breeze      	office productivity suite -- Breeze symbol style
            2995 KiB 	libreoffice-style-colibre     	office productivity suite -- colibre symbol style
            9797 KiB 	libreoffice-style-elementary  	office productivity suite -- Elementary symbol style
            8875 KiB 	libreoffice-style-yaru        	office productivity suite -- Yaru symbol style
           38701 KiB 	libreoffice-writer            	office productivity suite -- word processor
             116 KiB 	librest-0.7-0                 	REST service access library
             682 KiB 	librevenge-0.0-0              	Base Library for writing document interface filters
            1584 KiB 	librhythmbox-core10           	support library for the rhythmbox music player
            9888 KiB 	librsvg2-2                    	SAX-based renderer library for SVG files (runtime)
              84 KiB 	librsvg2-common               	SAX-based renderer library for SVG files (extra runtime)
              94 KiB 	librsync2                     	rsync remote-delta algorithm library
             132 KiB 	librtmp1                      	toolkit for RTMP streams (shared library)
             483 KiB 	librttopo1                    	Tuscany Region topology library
             216 KiB 	librubberband2                	audio time-stretching and pitch-shifting library
             380 KiB 	librygel-core-2.6-2           	GNOME UPnP/DLNA services - core library
              88 KiB 	librygel-db-2.6-2             	GNOME UPnP/DLNA services - db library
             180 KiB 	librygel-renderer-2.6-2       	GNOME UPnP/DLNA services - renderer library
             668 KiB 	librygel-server-2.6-2         	GNOME UPnP/DLNA services - server library
            1480 KiB 	libsamplerate0                	Audio sample rate conversion library
            4804 KiB 	libsane-common                	API library for scanners -- documentation and support files
            1553 KiB 	libsane-hpaio                 	HP SANE backend for multi-function peripherals
           11581 KiB 	libsane1                      	API library for scanners
             166 KiB 	libsasl2-2                    	Cyrus SASL - authentication abstraction library
             292 KiB 	libsasl2-modules              	Cyrus SASL - pluggable authentication modules
              88 KiB 	libsasl2-modules-db           	Cyrus SASL - pluggable authentication modules (DB)
             136 KiB 	libsasl2-modules-gssapi-mit   	Cyrus SASL - pluggable authentication modules (GSSAPI)
              64 KiB 	libsbc1                       	Sub Band CODEC library - runtime
              35 KiB 	libsctp1                      	user-space access to Linux kernel SCTP - shared library
            1633 KiB 	libsdl2-2.0-0                 	Simple DirectMedia Layer
              78 KiB 	libseat1                      	flexible user, seat and session management library
             137 KiB 	libseccomp2                   	high level interface to Linux seccomp filter
             424 KiB 	libsecret-1-0                 	Secret store
              48 KiB 	libsecret-common              	Secret store (common files)
             203 KiB 	libselinux1                   	SELinux runtime shared libraries
             726 KiB 	libselinux1-dev               	SELinux development headers
              37 KiB 	libsemanage-common            	Common files for SELinux policy management libraries
             279 KiB 	libsemanage2                  	SELinux policy management library
              42 KiB 	libsensors-config             	lm-sensors configuration files
              92 KiB 	libsensors5                   	library to read temperature/voltage/fan sensors
            1767 KiB 	libsepol-dev                  	SELinux binary policy manipulation library and development files
             699 KiB 	libsepol2                     	SELinux library for manipulating binary security policies
             110 KiB 	libserd-0-0                   	lightweight RDF syntax library
             281 KiB 	libsgutils2-2                 	utilities for devices using the SCSI command set (shared libraries)
              55 KiB 	libshine3                     	Fixed-point MP3 encoding library - runtime files
             146 KiB 	libshout3                     	MP3/Ogg Vorbis broadcast streaming library
             246 KiB 	libsidplay1v5                 	SID (MOS 6581) emulation library
              54 KiB 	libsigc++-2.0-0v5             	type-safe Signal Framework for C++ - runtime
              45 KiB 	libsigsegv2                   	Library for handling page faults in a portable way
            1715 KiB 	libslang2                     	S-Lang programming library - runtime version
              47 KiB 	libsm6                        	X11 Session Management library
             208 KiB 	libsmartcols1                 	smart column output alignment library
             326 KiB 	libsmbclient                  	shared library for communication with SMB/CIFS servers
             377 KiB 	libsnapd-glib1                	GLib snapd library
              48 KiB 	libsnappy1v5                  	fast compression/decompression library
             516 KiB 	libsndfile1                   	Library for reading/writing audio files
              84 KiB 	libsndio7.0                   	Small audio and MIDI framework from OpenBSD, runtime libraries
             678 KiB 	libsnmp-base                  	SNMP configuration script, MIBs and documentation
            3743 KiB 	libsnmp40                     	SNMP (Simple Network Management Protocol) library
             476 KiB 	libsocket++1                  	lightweight convenience library to handle low level BSD sockets in C++ - libs
             278 KiB 	libsodium23                   	Network communication, cryptography and signaturing library
              34 KiB 	libsonic0                     	Simple library to speed up or slow down speech
              61 KiB 	libsord-0-0                   	library for storing RDF data in memory
              97 KiB 	libsoundtouch1                	Sound stretching library
              45 KiB 	libsoup-gnome2.4-1            	HTTP library implementation in C -- GNOME support library
             735 KiB 	libsoup2.4-1                  	HTTP library implementation in C -- Shared library
              56 KiB 	libsoup2.4-common             	HTTP library implementation in C -- Common files
             307 KiB 	libsource-highlight-common    	architecture-independent files for source highlighting library
             562 KiB 	libsource-highlight4v5        	source highlighting library
              57 KiB 	libsox-fmt-alsa               	SoX alsa format I/O library
             322 KiB 	libsox-fmt-base               	Minimal set of SoX format libraries
             549 KiB 	libsox3                       	SoX library of audio effects and processing
             133 KiB 	libsoxr0                      	High quality 1D sample-rate conversion library
            2036 KiB 	libspa-0.2-modules            	libraries for the PipeWire multimedia server Simple Plugin API - modules
             819 KiB 	libspandsp2                   	Telephony signal processing library
            7800 KiB 	libspatialite7                	Geospatial extension for SQLite - libraries
              82 KiB 	libspectre1                   	Library for rendering PostScript documents
              72 KiB 	libspeechd2                   	Speech Dispatcher: Shared libraries
             117 KiB 	libspeex1                     	The Speex codec runtime library
              87 KiB 	libspeexdsp1                  	The Speex extended runtime library
             303 KiB 	libsphinxbase3                	Speech recognition tool - shared library
            1579 KiB 	libsqlite3-0                  	SQLite 3 shared library
              52 KiB 	libsratom-0-0                 	library for serialising LV2 atoms to/from Turtle
             695 KiB 	libsrt1.4-gnutls              	Secure Reliable Transport UDP streaming library (GnuTLS flavour)
             119 KiB 	libsrtp2-1                    	Secure RTP (SRTP) and UST Reference Implementations - shared library
             112 KiB 	libss2                        	command-line interface parsing library
             474 KiB 	libssh-4                      	tiny C SSH library (OpenSSL flavor)
             585 KiB 	libssh-gcrypt-4               	tiny C SSH library (gcrypt flavor)
            5345 KiB 	libssl3                       	Secure Sockets Layer toolkit - shared libraries
             108 KiB 	libsss-certmap0               	Certificate mapping library for SSSD
              63 KiB 	libsss-idmap0                 	ID mapping library for SSSD
              79 KiB 	libsss-nss-idmap0             	SID based lookups library for SSSD
              63 KiB 	libstartup-notification0      	library for program launch feedback (shared library)
           18980 KiB 	libstdc++-11-dev              	GNU Standard C++ Library v3 (development files)
            2687 KiB 	libstdc++6                    	GNU Standard C++ Library v3
             899 KiB 	libstemmer0d                  	Snowball stemming algorithms for use in Information Retrieval
              50 KiB 	libsuitesparseconfig5         	configuration routines for all SuiteSparse modules
             407 KiB 	libsuperlu5                   	Direct solution of large, sparse systems of linear equations
             254 KiB 	libswresample-dev             	FFmpeg library for audio resampling, rematrixing etc. - development files
             170 KiB 	libswresample3                	FFmpeg library for audio resampling, rematrixing etc. - runtime files
             792 KiB 	libswscale-dev                	FFmpeg library for image scaling and various conversions - development files
             526 KiB 	libswscale5                   	FFmpeg library for image scaling and various conversions - runtime files
             184 KiB 	libsynctex2                   	TeX Live: SyncTeX parser library
            5757 KiB 	libsysmetrics1                	Report hardware and other collected metrics - shared lib
             997 KiB 	libsystemd0                   	systemd utility library
              24 KiB 	libsz2                        	Adaptive Entropy Coding library - SZIP
              52 KiB 	libtag1v5                     	audio meta-data library
            1057 KiB 	libtag1v5-vanilla             	audio meta-data library - vanilla flavour
              85 KiB 	libtalloc2                    	hierarchical pool based memory allocator
             124 KiB 	libtasn1-6                    	Manage ASN.1 structures (runtime)
            1423 KiB 	libtbb-dev                    	parallelism library for C++ - development files
             172 KiB 	libtbb12                      	parallelism library for C++ - runtime files
             199 KiB 	libtbb2                       	parallelism library for C++ - runtime files
             104 KiB 	libtbbmalloc2                 	parallelism helper library for C++ - runtime files
            4067 KiB 	libtcl8.6                     	Tcl (the Tool Command Language) v8.6 - run-time library files
             130 KiB 	libtdb1                       	Trivial Database - shared library
              41 KiB 	libteamdctl0                  	library for communication with `teamd` process
            2945 KiB 	libtesseract4                 	Tesseract OCR library
             115 KiB 	libtevent0                    	talloc-based event loop library - shared library
              48 KiB 	libtext-iconv-perl            	module to convert between character sets in Perl
             595 KiB 	libthai-data                  	Data files for Thai language support library
              94 KiB 	libthai0                      	Thai language support library
             531 KiB 	libtheora0                    	Theora Video Compression Codec
              33 KiB 	libtie-ixhash-perl            	Perl module to order associative arrays
            1063 KiB 	libtiff-dev                   	Tag Image File Format library (TIFF), development files
             556 KiB 	libtiff5                      	Tag Image File Format (TIFF) library
              42 KiB 	libtiffxx5                    	Tag Image File Format (TIFF) library -- C++ interface
             123 KiB 	libtimedate-perl              	collection of modules to manipulate date/time information
             532 KiB 	libtinfo5                     	shared low-level terminfo library (legacy version)
             546 KiB 	libtinfo6                     	shared low-level terminfo library for terminal handling
              32 KiB 	libtirpc-common               	transport-independent RPC library - common files
             751 KiB 	libtirpc-dev                  	transport-independent RPC library - development files
             215 KiB 	libtirpc3                     	transport-independent RPC library
            2340 KiB 	libtk8.6                      	Tk toolkit for Tcl and X11 v8.6 - run-time files
            1198 KiB 	libtool                       	Generic library support script
              44 KiB 	libtotem-plparser-common      	Totem Playlist Parser library - common files
             180 KiB 	libtotem-plparser18           	Totem Playlist Parser library - runtime files
             515 KiB 	libtotem0                     	Main library for the Totem media player
            1251 KiB 	libtracker-sparql-3.0-0       	metadata database, indexer and search tool - library
              48 KiB 	libtry-tiny-perl              	module providing minimalistic try/catch
            7383 KiB 	libtsan0                      	ThreadSanitizer -- a Valgrind-based detector of data races (runtime)
             575 KiB 	libtss2-esys-3.0.2-0          	TPM2 Software stack library - TSS and TCTI libraries
             316 KiB 	libtss2-mu0                   	TPM2 Software stack library - TSS and TCTI libraries
              52 KiB 	libtss2-rc0                   	TPM2 Software stack library - TSS and TCTI libraries
             165 KiB 	libtss2-sys1                  	TPM2 Software stack library - TSS and TCTI libraries
              53 KiB 	libtss2-tcti-cmd0             	TPM2 Software stack library - TSS and TCTI libraries
              48 KiB 	libtss2-tcti-device0          	TPM2 Software stack library - TSS and TCTI libraries
              52 KiB 	libtss2-tcti-mssim0           	TPM2 Software stack library - TSS and TCTI libraries
              52 KiB 	libtss2-tcti-swtpm0           	TPM2 Software stack library - TSS and TCTI libraries
              56 KiB 	libtss2-tctildr0              	TPM2 Software stack library - TSS and TCTI libraries
             140 KiB 	libtwolame0                   	MPEG Audio Layer 2 encoding library
              14 KiB 	libu2f-udev                   	Universal 2nd Factor (U2F) — transitional package
            2684 KiB 	libubsan1                     	UBSan -- undefined behaviour sanitizer (runtime)
             199 KiB 	libuchardet0                  	universal charset detection library - shared library
            2229 KiB 	libucx0                       	Unified Communication X libraries
             266 KiB 	libudev-dev                   	libudev development files
             344 KiB 	libudev1                      	libudev shared library
              51 KiB 	libudfread0                   	UDF reader library
             822 KiB 	libudisks2-0                  	GObject based library to access udisks2
            1713 KiB 	libunistring2                 	Unicode string library for C
             336 KiB 	libunity-protocol-private0    	binding to get places into the launcher - private library
              33 KiB 	libunity-scopes-json-def-deskt	binding to get places into the launcher - desktop def file
             780 KiB 	libunity9                     	binding to get places into the launcher - shared library
             431 KiB 	libuno-cppu3                  	LibreOffice UNO runtime environment -- CPPU public library
            1259 KiB 	libuno-cppuhelpergcc3-3       	LibreOffice UNO runtime environment -- CPPU helper library
             273 KiB 	libuno-purpenvhelpergcc3-3    	LibreOffice UNO runtime environment -- "purpose environment" helper
             672 KiB 	libuno-sal3                   	LibreOffice UNO runtime environment -- SAL public library
             285 KiB 	libuno-salhelpergcc3-3        	LibreOffice UNO runtime environment -- SAL helpers for C++ library
            5689 KiB 	libunwind-dev                 	library to determine the call-chain of a program - development
             168 KiB 	libunwind8                    	library to determine the call-chain of a program - runtime
             183 KiB 	libupower-glib3               	abstraction for power management - shared library
             222 KiB 	liburi-perl                   	module to manipulate and access URI strings
             109 KiB 	liburiparser1                 	URI parsing library compliant with RFC 3986
             140 KiB 	libusb-1.0-0                  	userspace USB programming library
              61 KiB 	libusbmuxd6                   	USB multiplexor daemon for iPhone and iPod Touch devices - library
              41 KiB 	libutempter0                  	privileged helper for utmp/wtmp updates (runtime)
             129 KiB 	libuuid1                      	Universally Unique ID library
             244 KiB 	libuv1                        	asynchronous event notification library - runtime library
             221 KiB 	libv4l-0                      	Collection of video4linux support libraries
             280 KiB 	libv4lconvert0                	Video4linux frame format conversion library
              42 KiB 	libva-drm2                    	Video Acceleration (VA) API for Linux -- DRM runtime
              54 KiB 	libva-x11-2                   	Video Acceleration (VA) API for Linux -- X11 runtime
             221 KiB 	libva2                        	Video Acceleration (VA) API for Linux -- runtime
              97 KiB 	libvdpau1                     	Video Decode and Presentation API for Unix (libraries)
              84 KiB 	libvidstab1.1                 	video stabilization library (shared library)
             590 KiB 	libvisio-0.1-1                	library for parsing the visio file structure
             364 KiB 	libvisual-0.4-0               	audio visualization framework
             189 KiB 	libvncclient1                 	API to write one's own VNC server - client library
             326 KiB 	libvncserver1                 	API to write one's own VNC server
             125 KiB 	libvo-aacenc0                 	VisualOn AAC encoder library
             121 KiB 	libvo-amrwbenc0               	VisualOn AMR-WB encoder library
             176 KiB 	libvolume-key1                	Library for manipulating storage encryption keys and passphrases
             193 KiB 	libvorbis0a                   	decoder library for Vorbis General Audio Compression Codec
             663 KiB 	libvorbisenc2                 	encoder library for Vorbis General Audio Compression Codec
              59 KiB 	libvorbisfile3                	high-level API for Vorbis General Audio Compression Codec
            2152 KiB 	libvpx7                       	VP8 and VP9 video codec (shared library)
             517 KiB 	libvte-2.91-0                 	Terminal emulator widget for GTK+ 3.0 - runtime files
             144 KiB 	libvte-2.91-common            	Terminal emulator widget for GTK+ 3.0 - common files
           99726 KiB 	libvtk9.1                     	VTK libraries
           16266 KiB 	libvulkan-dev                 	Vulkan loader library -- development files
             530 KiB 	libvulkan1                    	Vulkan loader library
              57 KiB 	libwacom-bin                  	Wacom model feature query library -- binaries
             805 KiB 	libwacom-common               	Wacom model feature query library (common files)
              66 KiB 	libwacom9                     	Wacom model feature query library
             177 KiB 	libwavpack1                   	audio codec (lossy and lossless) - library
              57 KiB 	libwayland-bin                	wayland compositor infrastructure - binary utilities
              76 KiB 	libwayland-client0            	wayland compositor infrastructure - client library
              50 KiB 	libwayland-cursor0            	wayland compositor infrastructure - cursor library
             574 KiB 	libwayland-dev                	wayland compositor infrastructure - development files
              25 KiB 	libwayland-egl1               	wayland compositor infrastructure - EGL library
              99 KiB 	libwayland-server0            	wayland compositor infrastructure - server library
             792 KiB 	libwbclient0                  	Samba winbind client library
           71616 KiB 	libwebkit2gtk-4.0-37          	Web content engine library for GTK
             323 KiB 	libwebp7                      	Lossy compression of digital photographic images
              34 KiB 	libwebpdemux2                 	Lossy compression of digital photographic images.
              51 KiB 	libwebpmux3                   	Lossy compression of digital photographic images
             636 KiB 	libwebrtc-audio-processing1   	AudioProcessing module from the WebRTC project.
              56 KiB 	libwhoopsie-preferences0      	Ubuntu error tracker submission settings - shared library
              45 KiB 	libwhoopsie0                  	Ubuntu error tracker submission - shared library
             154 KiB 	libwildmidi2                  	software MIDI player library
            1248 KiB 	libwinpr2-2                   	Windows Portable Runtime library
             345 KiB 	libwmf-0.2-7                  	Windows metafile conversion library
              68 KiB 	libwmf-0.2-7-gtk              	Windows metafile conversion GTK pixbuf plugin
              53 KiB 	libwmf0.2-7-gtk               	Windows metafile conversion GTK pixbuf plugin - transitional package
             179 KiB 	libwmflite-0.2-7              	Windows metafile conversion lite library
             313 KiB 	libwnck-3-0                   	Window Navigator Construction Kit - runtime files
              68 KiB 	libwnck-3-common              	Window Navigator Construction Kit - common files
             110 KiB 	libwoff1                      	library for converting fonts to WOFF 2.0
             725 KiB 	libwpd-0.10-10                	Library for handling WordPerfect documents (shared library)
              64 KiB 	libwpe-1.0-1                  	Base library for the WPE WebKit port
             106 KiB 	libwpebackend-fdo-1.0-1       	WPE backend for FreeDesktop.org
             164 KiB 	libwpg-0.3-3                  	WordPerfect graphics import/convert library (shared library)
            1734 KiB 	libwps-0.4-4                  	Works text file format import filter library (shared library)
             105 KiB 	libwrap0                      	Wietse Venema's TCP wrappers library
             380 KiB 	libwww-perl                   	simple and consistent interface to the world-wide web
              35 KiB 	libwww-robotrules-perl        	database of robots.txt-derived permissions
            1358 KiB 	libx11-6                      	X11 client-side library
            1430 KiB 	libx11-data                   	X11 client-side library
            2487 KiB 	libx11-dev                    	X11 client-side library (development headers)
             366 KiB 	libx11-protocol-perl          	Perl module for the X Window System Protocol, version 11
              82 KiB 	libx11-xcb-dev                	Xlib/XCB interface library (development headers)
              77 KiB 	libx11-xcb1                   	Xlib/XCB interface library
            1326 KiB 	libx264-163                   	x264 video coding library
            2847 KiB 	libx265-199                   	H.265/HEVC video stream encoder (shared library)
              54 KiB 	libxau-dev                    	X11 authorisation library (development headers)
              31 KiB 	libxau6                       	X11 authorisation library
             469 KiB 	libxaw7                       	X11 Athena Widget library
              41 KiB 	libxcb-dri2-0                 	X C Binding, dri2 extension
              37 KiB 	libxcb-dri3-0                 	X C Binding, dri3 extension
             149 KiB 	libxcb-glx0                   	X C Binding, glx extension
              53 KiB 	libxcb-icccm4                 	utility libraries for X C Binding -- icccm
              36 KiB 	libxcb-image0                 	utility libraries for X C Binding -- image
              37 KiB 	libxcb-keysyms1               	utility libraries for X C Binding -- keysyms
              31 KiB 	libxcb-present0               	X C Binding, present extension
              97 KiB 	libxcb-randr0                 	X C Binding, randr extension
              47 KiB 	libxcb-render-util0           	utility libraries for X C Binding -- render-util
              82 KiB 	libxcb-render0                	X C Binding, render extension
              37 KiB 	libxcb-res0                   	X C Binding, res extension
              36 KiB 	libxcb-shape0                 	X C Binding, shape extension
              31 KiB 	libxcb-shm0                   	X C Binding, shm extension
              50 KiB 	libxcb-sync1                  	X C Binding, sync extension
              40 KiB 	libxcb-util1                  	utility libraries for X C Binding -- atom, aux and event
              55 KiB 	libxcb-xfixes0                	X C Binding, xfixes extension
             145 KiB 	libxcb-xkb1                   	X C Binding, XKEYBOARD extension
              51 KiB 	libxcb-xv0                    	X C Binding, xv extension
             202 KiB 	libxcb1                       	X C Binding
             714 KiB 	libxcb1-dev                   	X C Binding, development files
              27 KiB 	libxcomposite1                	X11 Composite extension library
              59 KiB 	libxcursor1                   	X cursor management library
              22 KiB 	libxcvt0                      	VESA CVT standard timing modelines generator -- shared library
              26 KiB 	libxdamage1                   	X11 damaged region extension library
              67 KiB 	libxdmcp-dev                  	X11 authorisation library (development headers)
              38 KiB 	libxdmcp6                     	X11 Display Manager Control Protocol library
            3262 KiB 	libxerces-c3.2                	validating XML parser library for C++
             106 KiB 	libxext6                      	X11 miscellaneous extension library
              42 KiB 	libxfixes3                    	X11 miscellaneous 'fixes' extension library
             193 KiB 	libxfont2                     	X11 font rasterisation library
             110 KiB 	libxft2                       	FreeType-based font drawing library for X
              92 KiB 	libxi6                        	X11 Input extension library
              29 KiB 	libxinerama1                  	X11 Xinerama extension library
              51 KiB 	libxkbcommon-x11-0            	library to create keymaps with the XKB X11 protocol
             294 KiB 	libxkbcommon0                 	library interface to the XKB compiler - shared library
             170 KiB 	libxkbfile1                   	X11 keyboard file manipulation library
              53 KiB 	libxkbregistry0               	library to query available RMLVO
             132 KiB 	libxklavier16                 	X Keyboard Extension high-level API
             678 KiB 	libxml-parser-perl            	Perl module for parsing XML files
             552 KiB 	libxml-twig-perl              	Perl module for processing huge XML documents in tree mode
             127 KiB 	libxml-xpathengine-perl       	re-usable XPath engine for DOM-like trees
            2060 KiB 	libxml2                       	GNOME XML library
            3352 KiB 	libxml2-dev                   	GNOME XML library - development files
             193 KiB 	libxmlb2                      	Binary XML library
             435 KiB 	libxmlsec1                    	XML security library
             227 KiB 	libxmlsec1-nss                	Nss engine for the XML security library
             123 KiB 	libxmu6                       	X11 miscellaneous utility library
              37 KiB 	libxmuu1                      	X11 miscellaneous micro-utility library
              61 KiB 	libxnvctrl0                   	NV-CONTROL X extension (runtime library)
              86 KiB 	libxpm4                       	X11 pixmap library
              65 KiB 	libxrandr2                    	X11 RandR extension library
              60 KiB 	libxrender1                   	X Rendering Extension client library
              35 KiB 	libxres1                      	X11 Resource extension library
              25 KiB 	libxshmfence1                 	X shared memory fences - shared library
            1354 KiB 	libxsimd-dev                  	C++ wrappers for SIMD intrinsics
             482 KiB 	libxslt1.1                    	XSLT 1.0 processing library - runtime library
              33 KiB 	libxss1                       	X11 Screen Saver extension library
             450 KiB 	libxt6                        	X11 toolkit intrinsics library
             105 KiB 	libxtables12                  	netfilter xtables library
              48 KiB 	libxtst6                      	X11 Testing -- Record extension library
              36 KiB 	libxv1                        	X11 Video extension library
             464 KiB 	libxvidcore4                  	Open source MPEG-4 video codec (library)
              43 KiB 	libxxf86dga1                  	X11 Direct Graphics Access extension library
              39 KiB 	libxxf86vm1                   	X11 XFree86 video mode extension library
              56 KiB 	libxxhash0                    	shared library for xxhash
              60 KiB 	libyajl2                      	Yet Another JSON Library
             128 KiB 	libyaml-0-2                   	Fast YAML 1.1 parser and emitter library
             317 KiB 	libyelp0                      	Library for the GNOME help browser
             245 KiB 	libzbar0                      	QR code / bar code scanner and decoder (library)
             291 KiB 	libzimg2                      	scaling, colorspace, depth conversion library (shared library)
             611 KiB 	libzmq5                       	lightweight messaging kernel (shared library)
             737 KiB 	libzstd1                      	fast lossless compression algorithm
             142 KiB 	libzvbi-common                	Vertical Blanking Interval decoder (VBI) - common files
             677 KiB 	libzvbi0                      	Vertical Blanking Interval decoder (VBI) - runtime files
            1045 KiB 	libzxingcore1                 	C++ port of ZXing library (library files)
              63 KiB 	linux-base                    	Linux image base package
         1036263 KiB 	linux-firmware                	Firmware for Linux kernel drivers
            6738 KiB 	linux-libc-dev                	Linux Kernel Headers for development
              69 KiB 	linux-sound-base              	base package for ALSA and OSS sound systems
           17068 KiB 	locales                       	GNU C Library: National Language (locale) data [support]
             860 KiB 	login                         	system login tools
              92 KiB 	logsave                       	save the output of a command in a log file
             675 KiB 	lp-solve                      	Solve (mixed integer) linear programming problems
             352 KiB 	lpr                           	BSD lpr/lpd line printer spooling system
              58 KiB 	lsb-base                      	Linux Standard Base init script functionality
              66 KiB 	lsb-release                   	Linux Standard Base version reporting utility
             812 KiB 	lshw                          	information about hardware configuration
             443 KiB 	lsof                          	utility to list open files
             334 KiB 	m4                            	macro processing language
              88 KiB 	mailcap                       	Debian's mailcap system, and support programs
             408 KiB 	make                          	utility for directing compilation
            2744 KiB 	man-db                        	tools for reading manual pages
             221 KiB 	mawk                          	Pattern scanning and text processing language
             370 KiB 	media-player-info             	Media player identification files
              97 KiB 	media-types                   	List of standard media types and their usual file extension
              17 KiB 	mime-support                  	transitional package
             525 KiB 	mobile-broadband-provider-info	database of mobile broadband service providers
            4416 KiB 	modemmanager                  	D-Bus service for managing modems
             547 KiB 	mono-4.0-gac                  	Mono GAC tool (for CLI 4.0)
              99 KiB 	mono-gac                      	Mono GAC tool
              90 KiB 	mono-runtime                  	Mono runtime - default version
            3025 KiB 	mono-runtime-common           	Mono runtime - common files
            4638 KiB 	mono-runtime-sgen             	Mono runtime - SGen
             361 KiB 	mount                         	tools for mounting and manipulating filesystems
             204 KiB 	mousetweaks                   	mouse accessibility enhancements for the GNOME desktop
              37 KiB 	mscompress                    	Microsoft "compress.exe/expand.exe" compatible (de)compressor
            1094 KiB 	mtd-utils                     	Memory Technology Device Utilities
             196 KiB 	mutter-common                 	shared files for the Mutter window manager
              34 KiB 	mysql-common                  	MySQL database common files, e.g. /etc/mysql/my.cnf
            1903 KiB 	nautilus                      	file manager and graphical shell for GNOME
             164 KiB 	nautilus-data                 	data files for nautilus
             118 KiB 	nautilus-extension-gnome-termi	GNOME terminal emulator application - Nautilus extension
             100 KiB 	nautilus-sendto               	easily send files via email from within Nautilus
             136 KiB 	nautilus-share                	Nautilus extension to share folder using Samba
             393 KiB 	ncurses-base                  	basic terminal type definitions
             606 KiB 	ncurses-bin                   	terminal-related programs and man pages
            4249 KiB 	ncurses-term                  	additional terminal type definitions
             756 KiB 	net-tools                     	NET-3 networking toolkit
              41 KiB 	netbase                       	Basic TCP/IP networking system
             102 KiB 	netcat-openbsd                	TCP/IP swiss army knife
            6936 KiB 	network-manager               	network management framework (daemon and userspace tools)
              53 KiB 	network-manager-config-connect	NetworkManager configuration to enable connectivity checking
            2088 KiB 	network-manager-gnome         	network management framework (GNOME frontend)
             256 KiB 	network-manager-openvpn       	network management framework (OpenVPN plugin core)
             283 KiB 	network-manager-openvpn-gnome 	network management framework (OpenVPN plugin GNOME GUI)
             192 KiB 	network-manager-pptp          	network management framework (PPTP plugin core)
             110 KiB 	network-manager-pptp-gnome    	network management framework (PPTP plugin GNOME GUI)
              69 KiB 	networkd-dispatcher           	Dispatcher service for systemd-networkd connection status changes
             169 KiB 	nftables                      	Program to control packet filtering rules by Netfilter project
             758 KiB 	notify-osd                    	daemon that displays passive pop-up notifications
            1159 KiB 	ntfs-3g                       	read/write NTFS driver for FUSE
             116 KiB 	numactl                       	NUMA scheduling and memory placement tool
          238154 KiB 	nvidia-l4t-3d-core            	NVIDIA GL EGL Package
              47 KiB 	nvidia-l4t-apt-source         	NVIDIA L4T apt source list debian package
          118123 KiB 	nvidia-l4t-bootloader         	NVIDIA Bootloader Package
           22560 KiB 	nvidia-l4t-camera             	NVIDIA Camera Package
            1514 KiB 	nvidia-l4t-configs            	NVIDIA configs debian package
            9937 KiB 	nvidia-l4t-core               	NVIDIA Core Package
           29174 KiB 	nvidia-l4t-cuda               	NVIDIA CUDA Package
            4573 KiB 	nvidia-l4t-display-kernel     	NVIDIA Display Kernel Modules Package
           20499 KiB 	nvidia-l4t-firmware           	NVIDIA Firmware Package
              98 KiB 	nvidia-l4t-gbm                	NVIDIA GBM Package
           70276 KiB 	nvidia-l4t-graphics-demos     	NVIDIA graphics demo applications
           16837 KiB 	nvidia-l4t-init               	NVIDIA Init debian package
           10817 KiB 	nvidia-l4t-initrd             	NVIDIA initrd debian package
             159 KiB 	nvidia-l4t-jetson-io          	NVIDIA Jetson.IO debian package
             178 KiB 	nvidia-l4t-jetsonpower-gui-too	NVIDIA Jetson Power GUI Tools debian package
          205419 KiB 	nvidia-l4t-kernel             	NVIDIA Kernel Package
            4224 KiB 	nvidia-l4t-kernel-dtbs        	NVIDIA Kernel DTB Package
           69072 KiB 	nvidia-l4t-kernel-headers     	NVIDIA Linux Tegra Kernel Headers Package
            1956 KiB 	nvidia-l4t-kernel-oot-headers 	NVIDIA OOT Kernel Module Headers Package
           18725 KiB 	nvidia-l4t-kernel-oot-modules 	NVIDIA OOT Kernel Module Drivers Package
           32099 KiB 	nvidia-l4t-multimedia         	NVIDIA Multimedia Package
             799 KiB 	nvidia-l4t-multimedia-utils   	NVIDIA Multimedia Package
             134 KiB 	nvidia-l4t-nvfancontrol       	NVIDIA Nvfancontrol debian package
            2328 KiB 	nvidia-l4t-nvml               	NVIDIA NVML Package
             286 KiB 	nvidia-l4t-nvpmodel           	NVIDIA Nvpmodel debian package
             103 KiB 	nvidia-l4t-nvpmodel-gui-tools 	NVIDIA Nvpmodel GUI Tools debian package
            1189 KiB 	nvidia-l4t-nvsci              	NVIDIA NvSci Package
             133 KiB 	nvidia-l4t-oem-config         	NVIDIA OEM-Config Package
             260 KiB 	nvidia-l4t-openwfd            	NVIDIA OpenWFD Package
            9960 KiB 	nvidia-l4t-optee              	OP-TEE userspace daemons, test programs and libraries
             112 KiB 	nvidia-l4t-pva                	NVIDIA PVA Package
           15068 KiB 	nvidia-l4t-tools              	NVIDIA Public Test Tools Package
            1800 KiB 	nvidia-l4t-vulkan-sc          	NVIDIA Vulkan SC run-time package
           30907 KiB 	nvidia-l4t-vulkan-sc-dev      	NVIDIA Vulkan SC Dev package
            2457 KiB 	nvidia-l4t-vulkan-sc-samples  	NVIDIA Vulkan SC samples package
           31494 KiB 	nvidia-l4t-vulkan-sc-sdk      	NVIDIA Vulkan SC SDK package
             103 KiB 	nvidia-l4t-wayland            	NVIDIA Wayland Package
            5314 KiB 	nvidia-l4t-weston             	NVIDIA Weston Package
             240 KiB 	nvidia-l4t-x11                	NVIDIA X11 Package
             319 KiB 	nvidia-l4t-xusb-firmware      	NVIDIA USB Firmware Package
              77 KiB 	obexftp                       	file transfer utility for devices that use the OBEX protocol
             142 KiB 	obexpushd                     	program for receiving files via Bluetooth or IRDA
             132 KiB 	ocl-icd-libopencl1            	Generic OpenCL ICD Loader
             246 KiB 	oem-config                    	Perform end-user configuration after initial OEM installation
             210 KiB 	oem-config-gtk                	GTK+ frontend for end-user post-OEM-install configuration
            1899 KiB 	onboard                       	Simple On-screen Keyboard
            3322 KiB 	onboard-common                	Simple On-screen Keyboard (common files)
            6927 KiB 	openprinting-ppds             	OpenPrinting printer support - PostScript PPD files
            2871 KiB 	openssh-client                	secure shell (SSH) client, for secure access to remote machines
            1437 KiB 	openssh-server                	secure shell (SSH) server, for secure access from remote machines
              93 KiB 	openssh-sftp-server           	secure shell (SSH) sftp server module, for SFTP access from remote machines
            1981 KiB 	openssl                       	Secure Sockets Layer toolkit - cryptographic utility
            1568 KiB 	openvpn                       	virtual private network daemon
            5256 KiB 	orca                          	Scriptable screen reader
             384 KiB 	p11-kit                       	p11-glue utilities
            1195 KiB 	p11-kit-modules               	p11-glue proxy and trust modules
            1500 KiB 	packagekit                    	Provides a package management service
             111 KiB 	packagekit-tools              	Provides PackageKit command-line tools
              47 KiB 	paps                          	UTF-8 to PostScript converter using Pango
             159 KiB 	parted                        	disk partition manipulator
            2193 KiB 	passwd                        	change and administer password and group data
             209 KiB 	patch                         	Apply a diff file to an original
            1282 KiB 	pci.ids                       	PCI ID Repository
             155 KiB 	pciutils                      	PCI utilities
              89 KiB 	pcmciautils                   	PCMCIA utilities for Linux 2.6
             717 KiB 	perl                          	Larry Wall's Practical Extraction and Report Language
            7504 KiB 	perl-base                     	minimal Perl system
           17671 KiB 	perl-modules-5.34             	Core Perl modules
              27 KiB 	perl-openssl-defaults         	version compatibility baseline for Perl OpenSSL packages
              84 KiB 	pinentry-curses               	curses-based PIN or pass-phrase entry dialog for GnuPG
              93 KiB 	pinentry-gnome3               	GNOME 3 PIN or pass-phrase entry dialog for GnuPG
              28 KiB 	pipewire                      	audio and video processing engine multimedia server
            1327 KiB 	pipewire-bin                  	PipeWire multimedia server - programs
             496 KiB 	pipewire-media-session        	example session manager for PipeWire
              61 KiB 	pkexec                        	run commands as another user with polkit authorization
             127 KiB 	pkg-config                    	manage compile and link flags for libraries
             848 KiB 	plymouth                      	boot animation, logger and I/O multiplexer
              65 KiB 	plymouth-label                	boot animation, logger and I/O multiplexer - label control
             391 KiB 	plymouth-theme-spinner        	boot animation, logger and I/O multiplexer - spinner theme
              29 KiB 	policykit-1                   	transitional package for polkitd and pkexec
              17 KiB 	policykit-desktop-privileges  	run common desktop actions without password
             496 KiB 	polkitd                       	framework for managing administrative policies and privileges
           13089 KiB 	poppler-data                  	encoding data for the poppler PDF rendering library
             592 KiB 	poppler-utils                 	PDF utilities (based on Poppler)
              99 KiB 	power-profiles-daemon         	Makes power profiles handling available over D-Bus.
            1022 KiB 	ppp                           	Point-to-Point Protocol (PPP) - daemon
             101 KiB 	pptp-linux                    	Point-to-Point Tunneling Protocol (PPTP) Client
              66 KiB 	printer-driver-brlaser        	printer driver for (some) Brother laser printers
             120 KiB 	printer-driver-c2esp          	printer driver for Kodak ESP AiO color inkjet Series
             637 KiB 	printer-driver-foo2zjs        	printer driver for ZjStream-based printers
            2509 KiB 	printer-driver-foo2zjs-common 	printer driver for ZjStream-based printers - common files
            1461 KiB 	printer-driver-m2300w         	printer driver for Minolta magicolor 2300W/2400W color laser printers
              93 KiB 	printer-driver-min12xxw       	printer driver for KonicaMinolta PagePro 1[234]xxW
            1857 KiB 	printer-driver-pnm2ppa        	printer driver for HP-GDI printers
              61 KiB 	printer-driver-ptouch         	printer driver Brother P-touch label printers
              39 KiB 	printer-driver-sag-gdi        	printer driver for Ricoh Aficio SP 1000s/SP 1100s
            1324 KiB 	procps                        	/proc file system utilities
           25326 KiB 	proj-data                     	Cartographic projection filter and library (datum package)
             424 KiB 	psmisc                        	utilities that use the proc file system
            4080 KiB 	pulseaudio                    	PulseAudio sound server
             374 KiB 	pulseaudio-utils              	Command line tools for the PulseAudio sound server
             184 KiB 	python-apt-common             	Python interface to libapt-pkg (locales)
              13 KiB 	python-is-python3             	symlinks /usr/bin/python to python3
             127 KiB 	python-jetson-gpio            	Jetson GPIO library package (Python 2)
            9059 KiB 	python-matplotlib-data        	Python based plotting system (data package)
              69 KiB 	python2                       	interactive high-level object-oriented language (Python2 version)
             105 KiB 	python2-minimal               	minimal subset of the Python2 language
             383 KiB 	python2.7                     	Interactive high-level object-oriented language (version 2.7)
            3588 KiB 	python2.7-minimal             	Minimal subset of the Python language (version 2.7)
              90 KiB 	python3                       	interactive high-level object-oriented language (default python3 version)
              57 KiB 	python3-appdirs               	determining appropriate platform-specific directories (Python 3)
             598 KiB 	python3-apport                	Python 3 library for Apport crash report handling
             689 KiB 	python3-apt                   	Python 3 interface to libapt-pkg
             500 KiB 	python3-aptdaemon             	Python 3 module for the server and client of aptdaemon
              92 KiB 	python3-aptdaemon.gtk3widgets 	Python 3 GTK+ 3 widgets to run an aptdaemon client
             207 KiB 	python3-attr                  	Attributes without boilerplate (Python 3)
              78 KiB 	python3-bcrypt                	password hashing library for Python 3
              55 KiB 	python3-beniget               	collection of compile-time Python AST analyzers
              55 KiB 	python3-blinker               	fast, simple object-to-object and broadcast signaling library
             343 KiB 	python3-brlapi                	Braille display access via BRLTTY - Python3 bindings
             725 KiB 	python3-brotli                	lossless compression algorithm and format (Python 3 version)
             322 KiB 	python3-cairo                 	Python3 bindings for the Cairo vector graphics library
             324 KiB 	python3-certifi               	root certificates for validating SSL certs and verifying TLS hosts (python3)
             222 KiB 	python3-cffi-backend          	Foreign Function Interface for Python 3 calling C code - runtime
            1068 KiB 	python3-chardet               	universal character encoding detector for Python3
             366 KiB 	python3-click                 	Wrapper around optparse for command line utilities - Python 3.x
              91 KiB 	python3-colorama              	Cross-platform colored terminal text in Python - Python 3.x
             129 KiB 	python3-cpuset                	manipluation of cpusets and provides higher level fun - Python 3.x
            1605 KiB 	python3-cryptography          	Python library exposing cryptographic recipes and primitives (Python 3)
             221 KiB 	python3-cups                  	Python3 bindings for CUPS
             164 KiB 	python3-cupshelpers           	Python utility modules around the CUPS printing system
              33 KiB 	python3-cycler                	composable kwarg iterator (Python 3)
             322 KiB 	python3-dateutil              	powerful extensions to the standard Python 3 datetime module
             412 KiB 	python3-dbus                  	simple interprocess messaging system (Python 3 interface)
             434 KiB 	python3-dbusmock              	mock D-Bus objects for tests
              18 KiB 	python3-debconf               	interact with debconf from Python 3
             553 KiB 	python3-debian                	Python 3 modules to work with Debian-related data formats
              43 KiB 	python3-decorator             	simplify usage of Python decorators by programmers
              50 KiB 	python3-defer                 	Small framework for asynchronous programming (Python 3)
             145 KiB 	python3-dev                   	header files and a static library for Python (default)
              77 KiB 	python3-distro                	Linux OS platform information API
              35 KiB 	python3-distro-info           	information about distributions' releases (Python 3 module)
             639 KiB 	python3-distupgrade           	manage release upgrades
             757 KiB 	python3-distutils             	distutils package for Python 3.x
              78 KiB 	python3-fasteners             	provides useful locks - Python 3.x
            4082 KiB 	python3-fonttools             	Converts OpenType and TrueType fonts to and from XML (Python 3 Library)
             512 KiB 	python3-fs                    	Python filesystem abstraction
            1666 KiB 	python3-future                	Clean single-source support for Python 3 and 2 - Python 3.x
              68 KiB 	python3-gast                  	compatibility layer for the AST of various Python versions (Python3 version)
             746 KiB 	python3-gi                    	Python 3 bindings for gobject-introspection libraries
              50 KiB 	python3-gi-cairo              	Python 3 Cairo bindings for the GObject library
             131 KiB 	python3-httplib2              	comprehensive HTTP client library written for Python3
              52 KiB 	python3-ibus-1.0              	Intelligent Input Bus - introspection overrides for Python (Python 3)
             299 KiB 	python3-idna                  	Python IDNA2008 (RFC 5891) handling (Python 3)
              67 KiB 	python3-importlib-metadata    	library to access the metadata for a Python package - Python 3.x
             186 KiB 	python3-jeepney               	pure Python D-Bus interface
             127 KiB 	python3-jetson-gpio           	Jetson GPIO library package (Python 3)
              82 KiB 	python3-jwt                   	Python 3 implementation of JSON Web Token
             154 KiB 	python3-keyring               	store and access your passwords safely
             132 KiB 	python3-kiwisolver            	fast implementation of the Cassowary constraint solver - Python 3.X
            1762 KiB 	python3-launchpadlib          	Launchpad web services client library (Python 3)
             183 KiB 	python3-lazr.restfulclient    	client for lazr.restful-based web services (Python 3)
              75 KiB 	python3-lazr.uri              	library for parsing, manipulating, and generating URIs
             169 KiB 	python3-ldb                   	Python 3 bindings for LDB
             388 KiB 	python3-lib2to3               	Interactive high-level object-oriented language (lib2to3)
              64 KiB 	python3-lockfile              	file locking library for Python — Python 3 library
              45 KiB 	python3-louis                 	Python bindings for liblouis
            3862 KiB 	python3-lxml                  	pythonic binding for the libxml2 and libxslt libraries
             155 KiB 	python3-lz4                   	Python interface to the lz4 compression library (Python 3)
             397 KiB 	python3-macaroonbakery        	Higher-level macaroon operations for Python 3
             322 KiB 	python3-mako                  	fast and lightweight templating for the Python 3 platform
              50 KiB 	python3-markupsafe            	HTML/XHTML/XML string library
           18350 KiB 	python3-matplotlib            	Python based plotting system in a style similar to Matlab (Python 3)
             122 KiB 	python3-minimal               	minimal subset of the Python language (default python3 version)
              26 KiB 	python3-monotonic             	implementation of time.monotonic() - Python 3.x
             226 KiB 	python3-more-itertools        	library with routines for operating on iterables, beyond itertools (Python 3)
            1965 KiB 	python3-mpmath                	library for arbitrary-precision floating-point arithmetic (Python3)
             406 KiB 	python3-nacl                  	Python bindings to libsodium (Python 3)
           22295 KiB 	python3-numpy                 	Fast array facility to the Python 3 language
             556 KiB 	python3-oauthlib              	generic, spec-compliant implementation of OAuth for Python3
             140 KiB 	python3-olefile               	Python module to read/write MS OLE2 files
            7222 KiB 	python3-opengl                	Python bindings to OpenGL (Python 3)
             135 KiB 	python3-packaging             	core utilities for python3 packages
           18694 KiB 	python3-pandas                	data structures for "relational" or "labeled" data
           15164 KiB 	python3-pandas-lib            	low-level implementations and bindings for pandas
             749 KiB 	python3-paramiko              	Make ssh v2 connections (Python 3)
             200 KiB 	python3-pexpect               	Python 3 module for automating interactive applications
            1609 KiB 	python3-pil                   	Python Imaging Library (Python3)
             103 KiB 	python3-pil.imagetk           	Python Imaging Library - ImageTk Module (Python3)
             580 KiB 	python3-pkg-resources         	Package Discovery and Resource Access using pkg_resources
             251 KiB 	python3-ply                   	Lex and Yacc implementation for Python3
             182 KiB 	python3-problem-report        	Python 3 library to handle problem reports
            3363 KiB 	python3-protobuf              	Python 3 bindings for protocol buffers
              59 KiB 	python3-ptyprocess            	Run a subprocess in a pseudo terminal from Python 3
             219 KiB 	python3-pyatspi               	Assistive Technology Service Provider Interface - Python3 bindings
              83 KiB 	python3-pymacaroons           	Macaroon library for Python 3
             298 KiB 	python3-pyparsing             	alternative to creating and executing simple grammars - Python 3.x
            4170 KiB 	python3-pythran               	ahead of time compiler for Python
             229 KiB 	python3-requests              	elegant and simple HTTP library for Python3, built for human beings
              33 KiB 	python3-rfc3339               	parser and generator of RFC 3339-compliant timestamps (Python 3)
           51314 KiB 	python3-scipy                 	scientific tools for Python 3
              56 KiB 	python3-secretstorage         	Python module for storing secrets - Python 3.x version
              59 KiB 	python3-six                   	Python 2 and 3 compatibility library (Python 3 interface)
             175 KiB 	python3-software-properties   	manage the repositories that you install software from
             147 KiB 	python3-speechd               	Python interface to Speech Dispatcher
             197 KiB 	python3-sss                   	Python3 module for the System Security Services Daemon
           30893 KiB 	python3-sympy                 	Computer Algebra System (CAS) in Python (Python 3)
             173 KiB 	python3-systemd               	Python 3 bindings for systemd
              69 KiB 	python3-talloc                	hierarchical pool based memory allocator - Python3 bindings
             828 KiB 	python3-tk                    	Tkinter - Writing Tk applications with Python 3.x
             104 KiB 	python3-tz                    	Python3 version of the Olson timezone database
             174 KiB 	python3-ufolib2               	Unified Font Object (UFO) fonts library
            1216 KiB 	python3-unicodedata2          	Python unicodedata backport/updates
             660 KiB 	python3-uno                   	Python-UNO bridge
             261 KiB 	python3-update-manager        	python 3.x module for update-manager
             448 KiB 	python3-urllib3               	HTTP library with thread-safe connection pooling for Python3
             928 KiB 	python3-urwid                 	curses-based UI/widget library for Python 3
             365 KiB 	python3-wadllib               	Python 3 library for navigating WADL files
             184 KiB 	python3-xdg                   	Python 3 library to access freedesktop.org standards
             113 KiB 	python3-xkit                  	library for the manipulation of xorg.conf files (Python 3)
             501 KiB 	python3-yaml                  	YAML parser and emitter for Python3
              25 KiB 	python3-zipp                  	pathlib-compatible Zipfile object wrapper - Python 3.x
             633 KiB 	python3.10                    	Interactive high-level object-oriented language (version 3.10)
             510 KiB 	python3.10-dev                	Header files and a static library for Python (v3.10)
            5667 KiB 	python3.10-minimal            	Minimal subset of the Python language (version 3.10)
              42 KiB 	qemu-efi                      	transitional dummy package
          264247 KiB 	qemu-efi-aarch64              	UEFI firmware for 64-bit ARM virtual machines
              80 KiB 	readline-common               	GNU readline and history libraries, common files
             905 KiB 	remmina                       	GTK+ Remote Desktop Client
            1624 KiB 	remmina-common                	Common files for Remmina
             162 KiB 	remmina-plugin-rdp            	RDP plugin for Remmina
              36 KiB 	remmina-plugin-secret         	Secret plugin for Remmina
              73 KiB 	remmina-plugin-vnc            	VNC plugin for Remmina
             198 KiB 	resolvconf                    	name server information handler
             132 KiB 	rfkill                        	tool for enabling and disabling wireless devices
             295 KiB 	rhythmbox                     	music player and organizer for GNOME
             880 KiB 	rhythmbox-data                	data files for rhythmbox
             436 KiB 	rhythmbox-plugin-alternative-t	Enhanced play controls and interface for Rhythmbox
            1585 KiB 	rhythmbox-plugins             	plugins for rhythmbox music player
             140 KiB 	rpcbind                       	converts RPC program numbers into universal addresses
             241 KiB 	rpcsvc-proto                  	RPC protocol compiler and definitions
             781 KiB 	rsync                         	fast, versatile, remote (and local) file-copying tool
            1600 KiB 	rsyslog                       	reliable system and kernel logging daemon
             131 KiB 	rtkit                         	Realtime Policy and Watchdog Daemon
            1368 KiB 	rygel                         	GNOME UPnP/DLNA services
           24093 KiB 	samba-libs                    	Samba core libraries
             386 KiB 	sane-airscan                  	SANE backend for AirScan (eSCL) and WSD document scanner
             562 KiB 	sane-utils                    	API library for scanners -- utilities
             193 KiB 	sbsigntool                    	Tools to manipulate signatures on UEFI binaries and drivers
            2320 KiB 	seahorse                      	GNOME front end for GnuPG
              88 KiB 	seatd                         	minimal user, seat and session management daemon
              29 KiB 	secureboot-db                 	Secure Boot updates for DB and DBX
             316 KiB 	sed                           	GNU stream editor for filtering/transforming text
              59 KiB 	sensible-utils                	Utilities for sensible alternative selection
              41 KiB 	session-migration             	Tool to migrate in user session settings
              70 KiB 	sgml-base                     	SGML infrastructure and SGML catalog file support
            1354 KiB 	sgml-data                     	common SGML and XML data
            2740 KiB 	shared-mime-info              	FreeDesktop.org shared MIME database and spec
            6737 KiB 	shotwell                      	digital photo organizer
             808 KiB 	shotwell-common               	digital photo organizer - common files
            1304 KiB 	simple-scan                   	Simple Scanning Utility
           93224 KiB 	snapd                         	Daemon and tooling that enable snap packages
             220 KiB 	software-properties-common    	manage the repositories that you install software from (common)
             491 KiB 	software-properties-gtk       	manage the repositories that you install software from (gtk)
             723 KiB 	sound-icons                   	Sounds for speech enabled applications
             537 KiB 	sound-theme-freedesktop       	freedesktop.org sound theme
             188 KiB 	sox                           	Swiss army knife of sound processing
           23484 KiB 	speech-dispatcher             	Common interface to speech synthesizers
             113 KiB 	speech-dispatcher-audio-plugin	Speech Dispatcher: Audio output plugins
              88 KiB 	speech-dispatcher-espeak-ng   	Speech Dispatcher: Espeak-ng output module
             189 KiB 	spice-vdagent                 	Spice agent for Linux
             398 KiB 	squashfs-tools                	Tool to create and append to squashfs filesystems
             115 KiB 	sshfs                         	filesystem client based on SSH File Transfer Protocol
              64 KiB 	ssl-cert                      	simple debconf wrapper for OpenSSL
              31 KiB 	sssd                          	System Security Services Daemon -- metapackage
             381 KiB 	sssd-ad                       	System Security Services Daemon -- Active Directory back end
             254 KiB 	sssd-ad-common                	System Security Services Daemon -- PAC responder
            4712 KiB 	sssd-common                   	System Security Services Daemon -- common files
             669 KiB 	sssd-ipa                      	System Security Services Daemon -- IPA back end
              53 KiB 	sssd-krb5                     	System Security Services Daemon -- Kerberos back end
             279 KiB 	sssd-krb5-common              	System Security Services Daemon -- Kerberos helpers
              80 KiB 	sssd-ldap                     	System Security Services Daemon -- LDAP back end
             143 KiB 	sssd-proxy                    	System Security Services Daemon -- proxy back end
              46 KiB 	stress                        	tool to impose load on and stress test a computer system
            2336 KiB 	sudo                          	Provide limited super user privileges to specific users
              87 KiB 	switcheroo-control            	D-Bus service to check the availability of dual-GPU
             916 KiB 	system-config-printer         	graphical interface to configure the printing system
             888 KiB 	system-config-printer-common  	backend and the translation files for system-config-printer
              68 KiB 	system-config-printer-udev    	Utilities to detect and configure printers automatically
           15740 KiB 	systemd                       	system and service manager
             280 KiB 	systemd-oomd                  	Userspace out-of-memory (OOM) killer
             198 KiB 	systemd-sysv                  	system and service manager - SysV links
             260 KiB 	systemd-timesyncd             	minimalistic service to synchronize local time with NTP servers
              59 KiB 	sysvinit-utils                	System-V-like utilities
           11034 KiB 	tango-icon-theme              	Tango icon library
             928 KiB 	tar                           	GNU version of the tar archiving utility
              22 KiB 	tcl                           	Tool Command Language (default version) - shell
              40 KiB 	tcl8.6                        	Tcl (the Tool Command Language) v8.6 - shell
          226091 KiB 	thunderbird                   	Email, RSS and newsgroup client with integrated spam filter
             125 KiB 	thunderbird-gnome-support     	Email, RSS and newsgroup client - GNOME support
            6073 KiB 	timgm6mb-soundfont            	TimGM6mb SoundFont from MuseScore 1.3
            1938 KiB 	tk8.6-blt2.5                  	graphics extension library for Tcl/Tk - library
             214 KiB 	totem                         	Simple media player for the GNOME desktop based on GStreamer
            1568 KiB 	totem-common                  	Data files for the Totem media player
             687 KiB 	totem-plugins                 	Plugins for the Totem media player
              18 KiB 	tpm-udev                      	udev rules for TPM modules
            1391 KiB 	tpm2-tools                    	TPM 2.0 utilities
             892 KiB 	tracker                       	metadata database, indexer and search tool
            1976 KiB 	tracker-extract               	metadata database, indexer and search tool - metadata extractors
             264 KiB 	tracker-miner-fs              	metadata database, indexer and search tool - filesystem indexer
             876 KiB 	transmission-common           	lightweight BitTorrent client (common files)
            1056 KiB 	transmission-gtk              	lightweight BitTorrent client (GTK+ interface)
            3900 KiB 	tzdata                        	time zone and daylight-saving time data
              85 KiB 	ubuntu-advantage-desktop-daemo	Daemon to allow access to ubuntu-advantage via D-Bus
            1121 KiB 	ubuntu-advantage-tools        	management tools for Ubuntu Pro
              53 KiB 	ubuntu-desktop                	The Ubuntu desktop system
              53 KiB 	ubuntu-desktop-minimal        	The Ubuntu desktop minimal system
            1813 KiB 	ubuntu-docs                   	Ubuntu Desktop Guide
             203 KiB 	ubuntu-drivers-common         	Detect and install additional Ubuntu driver packages
              41 KiB 	ubuntu-keyring                	GnuPG keys of the Ubuntu archive
            5587 KiB 	ubuntu-mono                   	Ubuntu Mono Icon theme
             340 KiB 	ubuntu-release-upgrader-core  	manage release upgrades
             212 KiB 	ubuntu-release-upgrader-gtk   	manage release upgrades
            6150 KiB 	ubuntu-report                 	Report hardware and other collected metrics
              80 KiB 	ubuntu-session                	Ubuntu session with GNOME Shell
              40 KiB 	ubuntu-settings               	default settings for the Ubuntu desktop
            2188 KiB 	ubuntu-wallpapers             	Ubuntu Wallpapers
           23556 KiB 	ubuntu-wallpapers-jammy       	Ubuntu 22.04 Wallpapers
             232 KiB 	ucf                           	Update Configuration File(s): preserve user changes to config files
            9454 KiB 	udev                          	/dev/ and hotplug management daemon
            1148 KiB 	udisks2                       	D-Bus service to access and manipulate storage devices
           37368 KiB 	unicode-data                  	Property data for the Unicode character set
              35 KiB 	unixodbc-common               	Common ODBC configuration files
             846 KiB 	uno-libs-private              	LibreOffice UNO runtime environment -- private libraries used by public ones
             353 KiB 	unzip                         	De-archiver for .zip files
              82 KiB 	update-inetd                  	inetd configuration file updater
            1045 KiB 	update-manager                	GNOME application that manages apt updates
             192 KiB 	update-manager-core           	manage release upgrades
             270 KiB 	update-notifier               	Daemon which notifies about package updates
            1469 KiB 	update-notifier-common        	Files shared between update-notifier and other packages
             412 KiB 	upower                        	abstraction for power management
            3828 KiB 	ure                           	LibreOffice UNO runtime environment
             131 KiB 	usb-modeswitch                	mode switching tool for controlling "flip flop" USB devices
              94 KiB 	usb-modeswitch-data           	mode switching data for usb-modeswitch
             715 KiB 	usb.ids                       	USB ID Repository
             117 KiB 	usbmuxd                       	USB multiplexor daemon for iPhone and iPod Touch devices
             309 KiB 	usbutils                      	Linux USB utilities
             200 KiB 	usrmerge                      	Convert the system to the merged /usr directories scheme
              41 KiB 	ussp-push                     	Client for OBEX PUSH
             916 KiB 	uthash-dev                    	hash table and linked list for C structures
            3055 KiB 	util-linux                    	miscellaneous system utilities
             173 KiB 	uuid-dev                      	Universally Unique ID library - headers and static libraries
            3811 KiB 	vim                           	Vi IMproved - enhanced vi editor
             382 KiB 	vim-common                    	Vi IMproved - Common files
           32783 KiB 	vim-runtime                   	Vi IMproved - Runtime files
            1090 KiB 	vulkan-tools                  	Miscellaneous Vulkan utilities
            1004 KiB 	wamerican                     	American English dictionary words for /usr/share/dict
             956 KiB 	wget                          	retrieves files from the web
              67 KiB 	whiptail                      	Displays user-friendly dialog boxes from shell scripts
              41 KiB 	whoopsie-preferences          	System preferences for error reporting
              34 KiB 	wireless-regdb                	wireless regulatory database
             283 KiB 	wireless-tools                	Tools for manipulating Linux Wireless Extensions
            3625 KiB 	wpasupplicant                 	client support for WPA and WPA2 (IEEE 802.11i)
            2292 KiB 	x11-apps                      	X applications
             311 KiB 	x11-common                    	X Window System (X.Org) infrastructure
             217 KiB 	x11-session-utils             	X session utilities
             625 KiB 	x11-utils                     	X11 utilities
             434 KiB 	x11-xkb-utils                 	X11 XKB utilities
             506 KiB 	x11-xserver-utils             	X server utilities
            1680 KiB 	x11proto-dev                  	X11 extension protocols and auxiliary headers
              73 KiB 	xauth                         	X authentication utility
             242 KiB 	xbitmaps                      	Base X bitmaps
             304 KiB 	xbrlapi                       	Access software for a blind person using a braille display - xbrlapi
            3695 KiB 	xcursor-themes                	Base X cursor themes
              24 KiB 	xcvt                          	VESA CVT standard timing modelines generator
              63 KiB 	xdg-dbus-proxy                	filtering D-Bus proxy
            1060 KiB 	xdg-desktop-portal            	desktop integration portal for Flatpak and Snap
             480 KiB 	xdg-desktop-portal-gnome      	GNOME portal backend for xdg-desktop-portal
             428 KiB 	xdg-desktop-portal-gtk        	GTK+/GNOME portal backend for xdg-desktop-portal
             538 KiB 	xdg-user-dirs                 	tool to manage well known user directories
              92 KiB 	xdg-user-dirs-gtk             	tool to manage well known user directories (Gtk extension)
             323 KiB 	xdg-utils                     	desktop integration utilities from freedesktop.org
            7166 KiB 	xfonts-base                   	standard fonts for X
             664 KiB 	xfonts-encodings              	Encodings for X.Org fonts
             467 KiB 	xfonts-scalable               	scalable fonts for X
             407 KiB 	xfonts-utils                  	X Window System font utility programs
              58 KiB 	xinit                         	X server initialisation tool
              74 KiB 	xinput                        	Runtime configuration and test of XInput devices
            4236 KiB 	xkb-data                      	X Keyboard Extension (XKB) configuration data
             249 KiB 	xloadimage                    	Graphics file viewer under X11
             118 KiB 	xml-core                      	XML infrastructure and XML catalog file support
              53 KiB 	xorg                          	X.Org X Window System
              69 KiB 	xorg-docs-core                	Core documentation for the X.org X Window System
              78 KiB 	xorg-sgml-doctools            	Common tools for building X.Org SGML documentation
             242 KiB 	xserver-common                	common files used by various X servers
            2604 KiB 	xserver-xephyr                	nested X server
             366 KiB 	xserver-xorg                  	X.Org X server
            3879 KiB 	xserver-xorg-core             	Xorg X server - core server
              47 KiB 	xserver-xorg-input-all        	X.Org X server -- input driver metapackage
             106 KiB 	xserver-xorg-input-libinput   	X.Org X server -- libinput input driver
             280 KiB 	xserver-xorg-input-wacom      	X.Org X server -- Wacom input driver
             268 KiB 	xserver-xorg-legacy           	setuid root Xorg server wrapper
              47 KiB 	xserver-xorg-video-all        	X.Org X server -- output driver metapackage
             171 KiB 	xserver-xorg-video-amdgpu     	X.Org X server -- AMDGPU display driver
              46 KiB 	xserver-xorg-video-ati        	X.Org X server -- AMD/ATI display driver wrapper
              46 KiB 	xserver-xorg-video-fbdev      	X.Org X server -- fbdev display driver
             243 KiB 	xserver-xorg-video-nouveau    	X.Org X server -- Nouveau display driver
             513 KiB 	xserver-xorg-video-radeon     	X.Org X server -- AMD/ATI Radeon display driver
              53 KiB 	xserver-xorg-video-vesa       	X.Org X server -- VESA display driver
            2355 KiB 	xterm                         	X terminal emulator
             302 KiB 	xtrans-dev                    	X transport library (development files)
            2224 KiB 	xwayland                      	X server for running X clients under Wayland
             280 KiB 	xxd                           	tool to make (or reverse) a hex dump
             360 KiB 	xz-utils                      	XZ-format compression utilities
            9692 KiB 	yaru-theme-gnome-shell        	Yaru GNOME Shell desktop theme from the Ubuntu Community
           33178 KiB 	yaru-theme-gtk                	Yaru GTK theme from the Ubuntu Community
          108981 KiB 	yaru-theme-icon               	Yaru icon theme from the Ubuntu Community
             791 KiB 	yaru-theme-sound              	Yaru sound theme from the Ubuntu Community
            2116 KiB 	yelp                          	Help browser for GNOME
            1436 KiB 	yelp-xsl                      	XSL stylesheets for the yelp help browser
             170 KiB 	zenity                        	Display graphical dialog boxes from shell scripts
            1640 KiB 	zenity-common                 	Display graphical dialog boxes from shell scripts (common files)
             511 KiB 	zip                           	Archiver for .zip files
             160 KiB 	zlib1g                        	compression library - runtime
             589 KiB 	zlib1g-dev                    	compression library - development
            1447 KiB 	zstd                          	fast lossless compression algorithm -- CLI tool
        
        ```


    === ":material-numeric-5-box-multiple: JetPack 5.0.2"

        Jetson AGX Orin Developer Kit with JetPack 5.0.2 
        ```
            624 KiB 	adduser                       	add and remove users and groups
           5135 KiB 	adwaita-icon-theme            	default icon theme of GNOME (small subset)
            338 KiB 	alsa-ucm-conf                 	ALSA Use Case Manager configuration files
           2348 KiB 	alsa-utils                    	Utilities for configuring and using ALSA
           1884 KiB 	apparmor                      	user-space parser utility for AppArmor
            792 KiB 	apport                        	automatically generate crash reports for debugging
             61 KiB 	apport-symptoms               	symptom scripts for apport
           4009 KiB 	apt                           	commandline package manager
            387 KiB 	base-files                    	Debian base system miscellaneous files
            229 KiB 	base-passwd                   	Debian base system master password and group files
           1680 KiB 	bash                          	GNU Bourne Again SHell
            218 KiB 	bc                            	GNU bc arbitrary precision calculator language
            228 KiB 	binfmt-support                	Support for extra binary formats
            107 KiB 	binutils                      	GNU assembler, linker and binary utilities
          13184 KiB 	binutils-aarch64-linux-gnu    	GNU binary utilities, for aarch64-linux-gnu target
            424 KiB 	binutils-common               	Common files for the GNU assembler, linker and binary utilities
           4782 KiB 	bluez                         	Bluetooth tools and daemons
            109 KiB 	bridge-utils                  	Utilities for configuring the Linux Ethernet bridge
            585 KiB 	bsdmainutils                  	collection of more utilities from FreeBSD
            284 KiB 	bsdutils                      	basic utilities from 4.4BSD-Lite
             95 KiB 	bubblewrap                    	setuid wrapper for unprivileged chroot and namespace manipulation
             21 KiB 	build-essential               	Informational list of build-essential packages
            175 KiB 	bzip2                         	high-quality block-sorting file compressor - utilities
            380 KiB 	ca-certificates               	Common CA certificates
            103 KiB 	ca-certificates-mono          	Common CA certificates (Mono keystore)
            517 KiB 	can-utils                     	SocketCAN userspace utilities and tools
            265 KiB 	cli-common                    	common files between all CLI packages
            428 KiB 	console-setup                 	console font and keymap setup program
           1766 KiB 	console-setup-linux           	Linux specific part of console-setup
         122369 KiB 	containerd                    	daemon to control runC
           6480 KiB 	coreutils                     	GNU core utilities
             64 KiB 	cpp                           	GNU C preprocessor (cpp)
          19215 KiB 	cpp-9                         	GNU C preprocessor
            269 KiB 	crda                          	wireless Central Regulatory Domain Agent
            512 KiB 	cryptsetup-bin                	disk encryption support - command line tools
          12351 KiB 	cuda-cccl-11-4                	CUDA CCCL
              7 KiB 	cuda-command-line-tools-11-4  	CUDA command-line tools
              7 KiB 	cuda-compiler-11-4            	CUDA compiler
            731 KiB 	cuda-cudart-11-4              	CUDA Runtime native Libraries
           4963 KiB 	cuda-cudart-dev-11-4          	CUDA Runtime native dev links, headers
            279 KiB 	cuda-cuobjdump-11-4           	CUDA cuobjdump
          21777 KiB 	cuda-cupti-11-4               	CUDA profiling tools runtime libs.
           1308 KiB 	cuda-cupti-dev-11-4           	CUDA profiling tools interface.
           1553 KiB 	cuda-cuxxfilt-11-4            	CUDA cuxxfilt
            378 KiB 	cuda-documentation-11-4       	CUDA documentation
            131 KiB 	cuda-driver-dev-11-4          	CUDA Driver native dev stub library
          13984 KiB 	cuda-gdb-11-4                 	CUDA-GDB
              7 KiB 	cuda-libraries-11-4           	CUDA Libraries 11.4 meta-package
              7 KiB 	cuda-libraries-dev-11-4       	CUDA Libraries 11.4 development meta-package
         100442 KiB 	cuda-nvcc-11-4                	CUDA nvcc
          32610 KiB 	cuda-nvdisasm-11-4            	CUDA disassembler
            559 KiB 	cuda-nvml-dev-11-4            	NVML native dev links, headers
             88 KiB 	cuda-nvprof-11-4              	CUDA Profiler tools
            154 KiB 	cuda-nvprune-11-4             	CUDA nvprune
          46801 KiB 	cuda-nvrtc-11-4               	NVRTC native runtime libraries
            117 KiB 	cuda-nvrtc-dev-11-4           	NVRTC native dev links, headers
            444 KiB 	cuda-nvtx-11-4                	NVIDIA Tools Extension
         161640 KiB 	cuda-samples-11-4             	CUDA example applications
          26027 KiB 	cuda-sanitizer-11-4           	CUDA Sanitizer
             14 KiB 	cuda-toolkit-11-4             	CUDA Toolkit 11.4 meta-package
             70 KiB 	cuda-toolkit-11-4-config-commo	Common config package for CUDA Toolkit 11.4.
             74 KiB 	cuda-toolkit-11-config-common 	Common config package for CUDA Toolkit 11.
             74 KiB 	cuda-toolkit-config-common    	Common config package for CUDA Toolkit.
              7 KiB 	cuda-tools-11-4               	CUDA Tools meta-package
             10 KiB 	cuda-visual-tools-11-4        	CUDA visual tools
            220 KiB 	dash                          	POSIX-compliant shell
            574 KiB 	dbus                          	simple interprocess messaging system (daemon and utilities)
            126 KiB 	dbus-user-session             	simple interprocess messaging system (systemd --user integration)
            152 KiB 	dbus-x11                      	simple interprocess messaging system (X11 deps)
             78 KiB 	dconf-gsettings-backend       	simple configuration storage system - GSettings back-end
            110 KiB 	dconf-service                 	simple configuration storage system - D-Bus service
            520 KiB 	debconf                       	Debian configuration management system
            217 KiB 	debianutils                   	Miscellaneous utilities specific to Debian
            446 KiB 	device-tree-compiler          	Device Tree Compiler for Flat Device Trees
            496 KiB 	diffutils                     	File comparison utilities
            872 KiB 	dirmngr                       	GNU privacy guard - network certificate management service
             17 KiB 	distro-info-data              	information about the distributions' releases (data files)
            277 KiB 	dmsetup                       	Linux Kernel Device Mapper userspace library
             18 KiB 	dns-root-data                 	DNS root data including root zone and DNSSEC key
            760 KiB 	dnsmasq-base                  	Small caching DNS proxy and DHCP/TFTP server
         131139 KiB 	docker.io                     	Linux container runtime
           6704 KiB 	dpkg                          	Debian package management system
           2075 KiB 	dpkg-dev                      	Debian package development tools
           1406 KiB 	e2fsprogs                     	ext2/ext3/ext4 file system utilities
            219 KiB 	fakeroot                      	tool for simulating superuser privileges
            486 KiB 	fdisk                         	collection of partitioning utilities
             82 KiB 	file                          	Recognize the type of data in a file using "magic" numbers
            648 KiB 	findutils                     	utilities for finding files--find, xargs
           2008 KiB 	fio                           	flexible I/O tester
            333 KiB 	fontconfig                    	generic font configuration library - support binaries
            170 KiB 	fontconfig-config             	generic font configuration library - configuration
           2954 KiB 	fonts-dejavu-core             	Vera font family derivate with additional characters
             99 KiB 	fuse                          	Filesystem in Userspace
             16 KiB 	g++                           	GNU C++ compiler
          20922 KiB 	g++-9                         	GNU C++ compiler
             50 KiB 	gcc                           	GNU C compiler
            265 KiB 	gcc-10-base                   	GCC, the GNU Compiler Collection (base package)
          22627 KiB 	gcc-9                         	GNU C compiler
            265 KiB 	gcc-9-base                    	GCC, the GNU Compiler Collection (base package)
           1893 KiB 	gdal-data                     	Geospatial Data Abstraction Library - Data files
            789 KiB 	gdbserver                     	GNU Debugger (remote server)
            804 KiB 	gdisk                         	GPT fdisk text-mode partitioning tool
            650 KiB 	gir1.2-glib-2.0               	Introspection data for GLib, GObject, Gio and GModule
            237 KiB 	gir1.2-gst-plugins-bad-1.0    	GObject introspection data for the GStreamer libraries from the "bad" set
            469 KiB 	gir1.2-gst-plugins-base-1.0   	GObject introspection data for the GStreamer Plugins Base library
           1427 KiB 	gir1.2-gstreamer-1.0          	GObject introspection data for the GStreamer library
          34904 KiB 	git                           	fast, scalable, distributed revision control system
           1779 KiB 	git-man                       	fast, scalable, distributed revision control system (manual pages)
            187 KiB 	glib-networking               	network-related giomodules for GLib
             52 KiB 	glib-networking-common        	network-related giomodules for GLib - data files
             47 KiB 	glib-networking-services      	network-related giomodules for GLib - D-Bus services
            413 KiB 	gnupg                         	GNU privacy guard - a free PGP replacement
            380 KiB 	gnupg-l10n                    	GNU privacy guard - localization files
           1485 KiB 	gnupg-utils                   	GNU privacy guard - utility programs
           1107 KiB 	gpg                           	GNU Privacy Guard -- minimalist public key operations
            878 KiB 	gpg-agent                     	GNU privacy guard - cryptographic agent
            275 KiB 	gpg-wks-client                	GNU privacy guard - Web Key Service client
            247 KiB 	gpg-wks-server                	GNU privacy guard - Web Key Service server
            389 KiB 	gpgconf                       	GNU privacy guard - core configuration utilities
            548 KiB 	gpgsm                         	GNU privacy guard - S/MIME version
            487 KiB 	gpgv                          	GNU privacy guard - signature verification tool
             81 KiB 	graphsurgeon-tf               	GraphSurgeon for TensorRT package
            472 KiB 	grep                          	GNU grep, egrep and fgrep
           3526 KiB 	groff-base                    	GNU troff text-formatting system (base system components)
            284 KiB 	gsettings-desktop-schemas     	GSettings desktop-wide schemas
            200 KiB 	gstreamer1.0-alsa             	GStreamer plugin for ALSA
            381 KiB 	gstreamer1.0-libav            	ffmpeg plugin for GStreamer
           6406 KiB 	gstreamer1.0-plugins-bad      	GStreamer plugins from the "bad" set
           2087 KiB 	gstreamer1.0-plugins-base     	GStreamer plugins from the "base" set
           5696 KiB 	gstreamer1.0-plugins-good     	GStreamer plugins from the "good" set
            828 KiB 	gstreamer1.0-plugins-ugly     	GStreamer plugins from the "ugly" set
           1234 KiB 	gstreamer1.0-tools            	Tools for use with GStreamer
            324 KiB 	gstreamer1.0-x                	GStreamer plugins for X11 and Pango
            146 KiB 	gtk-update-icon-cache         	icon theme caching utility
            244 KiB 	gzip                          	GNU compression utilities
             73 KiB 	haveged                       	Linux entropy source using the HAVEGE algorithm
            440 KiB 	hicolor-icon-theme            	default fallback theme for FreeDesktop.org icon themes
             46 KiB 	hostname                      	utility to set/show the host name or domain name
          20754 KiB 	humanity-icon-theme           	Humanity Icon theme
            272 KiB 	i2c-tools                     	heterogeneous set of I2C tools for Linux
            133 KiB 	init-system-helpers           	helper tools for all init systems
           2680 KiB 	iproute2                      	networking and traffic control tools
           2096 KiB 	iptables                      	administration tools for packet filtering and NAT
            108 KiB 	iputils-ping                  	Tools to test the reachability of network hosts
            722 KiB 	isc-dhcp-client               	DHCP client for automatically obtaining an IP address
           1479 KiB 	isc-dhcp-server               	ISC DHCP server for automatic IP address assignment
          19553 KiB 	iso-codes                     	ISO language, territory, currency, script codes and their translations
            275 KiB 	iw                            	tool for configuring Linux wireless devices
             52 KiB 	jetson-gpio-common            	Jetson GPIO library package (common files)
           1272 KiB 	kbd                           	Linux console font and keytable utilities
            827 KiB 	keyboard-configuration        	system-wide keyboard preferences
            247 KiB 	kmod                          	tools for managing Linux kernel modules
              9 KiB 	language-pack-en              	translation updates for language English
           3828 KiB 	language-pack-en-base         	translations for language English
            301 KiB 	less                          	pager program similar to more
             66 KiB 	liba52-0.7.4                  	library for decoding ATSC A/52 streams
            146 KiB 	libaa1                        	ASCII art library
             65 KiB 	libacl1                       	access control list - shared library
             49 KiB 	libaec0                       	Adaptive Entropy Coding library
             31 KiB 	libaio1                       	Linux kernel AIO access library - shared library
            106 KiB 	libalgorithm-diff-perl        	module to find differences between files
             42 KiB 	libalgorithm-diff-xs-perl     	module to find differences between files (XS accelerated)
             42 KiB 	libalgorithm-merge-perl       	Perl module for three-way merge of textual data
           2315 KiB 	libaom0                       	AV1 Video Codec Library
            159 KiB 	libapparmor1                  	changehat AppArmor library
           3107 KiB 	libapt-pkg6.0                 	package management runtime library
            808 KiB 	libarchive13                  	Multi-format archive and compression library (shared library)
             51 KiB 	libargon2-1                   	memory-hard hashing function - runtime library
            662 KiB 	libarmadillo9                 	streamlined C++ linear algebra library
            257 KiB 	libarpack2                    	Fortran77 subroutines to solve large scale eigenvalue problems
          14943 KiB 	libasan5                      	AddressSanitizer -- a fast memory error detector
            732 KiB 	libasn1-8-heimdal             	Heimdal Kerberos - ASN.1 library
           1098 KiB 	libasound2                    	shared library for ALSA applications
            215 KiB 	libasound2-data               	Configuration files and profiles for ALSA drivers
            167 KiB 	libass9                       	library for SSA/ASS subtitles rendering
            101 KiB 	libassuan0                    	IPC library for the GnuPG components
             39 KiB 	libasyncns0                   	Asynchronous name service query library
            230 KiB 	libatk-bridge2.0-0            	AT-SPI 2 toolkit bridge - shared library
            199 KiB 	libatk1.0-0                   	ATK accessibility toolkit
             44 KiB 	libatk1.0-data                	Common files for the ATK accessibility toolkit
             52 KiB 	libatomic1                    	support library providing __atomic built-in functions
            156 KiB 	libatopology2                 	shared library for handling ALSA topology definitions
            235 KiB 	libatspi2.0-0                 	Assistive Technology Service Provider Interface - shared library
             52 KiB 	libattr1                      	extended attribute handling - shared library
             24 KiB 	libaudit-common               	Dynamic library for security auditing - common files
            148 KiB 	libaudit1                     	Dynamic library for security auditing
            124 KiB 	libavahi-client3              	Avahi client library
            112 KiB 	libavahi-common-data          	Avahi common data files
            109 KiB 	libavahi-common3              	Avahi common library
             53 KiB 	libavc1394-0                  	control IEEE 1394 audio/video devices
          17329 KiB 	libavcodec-dev                	FFmpeg library with de/encoders for audio/video codecs - development files
          11696 KiB 	libavcodec58                  	FFmpeg library with de/encoders for audio/video codecs - runtime files
           3271 KiB 	libavfilter7                  	FFmpeg library containing media filters - runtime files
           5298 KiB 	libavformat-dev               	FFmpeg library with (de)muxers for multimedia containers - development files
           2513 KiB 	libavformat58                 	FFmpeg library with (de)muxers for multimedia containers - runtime files
            233 KiB 	libavresample-dev             	FFmpeg compatibility library for resampling - development files
            152 KiB 	libavresample4                	FFmpeg compatibility library for resampling - runtime files
           1634 KiB 	libavutil-dev                 	FFmpeg library with functions for simplifying programming - development files
            644 KiB 	libavutil56                   	FFmpeg library with functions for simplifying programming - runtime files
           2092 KiB 	libbinutils                   	GNU binary utilities (private shared library)
            375 KiB 	libblas3                      	Basic Linear Algebra Reference implementations, shared library
            977 KiB 	libblkid-dev                  	block device ID library - headers and static libraries
            443 KiB 	libblkid1                     	block device ID library
            213 KiB 	libbluetooth3                 	Library to use the BlueZ Linux Bluetooth stack
            344 KiB 	libbluray2                    	Blu-ray disc playback support library (shared library)
           2105 KiB 	libboost-iostreams1.71.0      	Boost.Iostreams Library
           2129 KiB 	libboost-thread1.71.0         	portable C++ multi-threading
            694 KiB 	libbrotli1                    	library implementing brotli encoder and decoder (shared libraries)
             36 KiB 	libbs2b0                      	Bauer stereophonic-to-binaural DSP library
            191 KiB 	libbsd0                       	utility functions from BSD systems - shared library
             94 KiB 	libbz2-1.0                    	high-quality block-sorting file compressor library - runtime
           3182 KiB 	libc-bin                      	GNU C Library: Binaries
            422 KiB 	libc-dev-bin                  	GNU C Library: Development binaries
          10447 KiB 	libc6                         	GNU C Library: Shared libraries
          15765 KiB 	libc6-dev                     	GNU C Library: Development Libraries and Header Files
           1025 KiB 	libcaca0                      	colour ASCII art library
             94 KiB 	libcairo-gobject2             	Cairo 2D vector graphics library (GObject library)
           1250 KiB 	libcairo2                     	Cairo 2D vector graphics library
            118 KiB 	libcanberra0                  	simple abstract interface for playing event sounds
             37 KiB 	libcap-ng0                    	An alternate POSIX capabilities library
             52 KiB 	libcap2                       	POSIX 1003.1e capabilities (library)
            100 KiB 	libcap2-bin                   	POSIX 1003.1e capabilities (utilities)
             78 KiB 	libcbor0.6                    	library for parsing and generating CBOR (RFC 7049)
            148 KiB 	libcc1-0                      	GCC cc1 plugin for GDB
            287 KiB 	libcdio18                     	library to read and control CD-ROM
            118 KiB 	libcdparanoia0                	audio extraction tool for sampling CDs (library)
           1375 KiB 	libcfitsio8                   	shared library for I/O with FITS format data files
            267 KiB 	libcharls2                    	Implementation of the JPEG-LS standard
             94 KiB 	libchromaprint1               	audio fingerprint library
          14180 KiB 	libcodec2-0.9                 	Codec2 runtime library
            600 KiB 	libcolord2                    	system service to manage device colour profiles -- runtime
             91 KiB 	libcom-err2                   	common error description library
            328 KiB 	libcrypt-dev                  	libcrypt development files
            221 KiB 	libcrypt1                     	libcrypt shared library
            479 KiB 	libcryptsetup12               	disk encryption support - shared library
            185 KiB 	libctf-nobfd0                 	Compact C Type Format library (runtime, no BFD dependency)
            121 KiB 	libctf0                       	Compact C Type Format library (runtime, BFD dependency)
         527675 KiB 	libcublas-11-4                	CUBLAS native runtime libraries
         699018 KiB 	libcublas-dev-11-4            	CUBLAS native dev links, headers
            232 KiB 	libcudla-11-4                 	CUDLA native runtime libraries
            111 KiB 	libcudla-dev-11-4             	CUDLA native dev links, headers
        1419681 KiB 	libcudnn8                     	cuDNN runtime libraries
        1718597 KiB 	libcudnn8-dev                 	cuDNN development libraries and headers
           2117 KiB 	libcudnn8-samples             	cuDNN samples
         171408 KiB 	libcufft-11-4                 	CUFFT native runtime libraries
         393703 KiB 	libcufft-dev-11-4             	CUFFT native dev links, headers
            757 KiB 	libcups2                      	Common UNIX Printing System(tm) - Core library
          79647 KiB 	libcurand-11-4                	CURAND native runtime libraries
          81676 KiB 	libcurand-dev-11-4            	CURAND native dev links, headers
            641 KiB 	libcurl3-gnutls               	easy-to-use client-side URL transfer library (GnuTLS flavour)
         466273 KiB 	libcusolver-11-4              	CUDA solver native runtime libraries
         223245 KiB 	libcusolver-dev-11-4          	CUDA solver native dev links, headers
         225282 KiB 	libcusparse-11-4              	CUSPARSE native runtime libraries
         251151 KiB 	libcusparse-dev-11-4          	CUSPARSE native dev links, headers
           1535 KiB 	libdap25                      	Open-source Project for a Network Data Access Protocol library
            270 KiB 	libdapclient6v5               	Client library for the Network Data Access Protocol
             57 KiB 	libdatrie1                    	Double-array trie library
           1613 KiB 	libdb5.3                      	Berkeley v5.3 Database Libraries [runtime]
            461 KiB 	libdbus-1-3                   	simple interprocess messaging system (library)
            233 KiB 	libdc1394-22                  	high level programming interface for IEEE 1394 digital cameras
            589 KiB 	libdc1394-22-dev              	high level programming interface for IEEE 1394 digital cameras - development
            181 KiB 	libdca0                       	decoding library for DTS Coherent Acoustics streams
            102 KiB 	libdconf1                     	simple configuration storage system - runtime library
            552 KiB 	libde265-0                    	Open H.265 video codec implementation
             69 KiB 	libdebconfclient0             	Debian Configuration Management System (C-implementation library)
            492 KiB 	libdevmapper1.02.1            	Linux Kernel Device Mapper userspace library
           2123 KiB 	libdns-export1109             	Exported DNS Shared Library
           2180 KiB 	libdpkg-perl                  	Dpkg perl modules
             80 KiB 	libdrm-amdgpu1                	Userspace interface to amdgpu-specific kernel DRM services -- runtime
             45 KiB 	libdrm-common                 	Userspace interface to kernel DRM services -- common files
            695 KiB 	libdrm-dev                    	Userspace interface to kernel DRM services -- development files
             62 KiB 	libdrm-etnaviv1               	Userspace interface to etnaviv-specific kernel DRM services -- runtime
             79 KiB 	libdrm-freedreno1             	Userspace interface to msm/kgsl kernel DRM services -- runtime
             74 KiB 	libdrm-nouveau2               	Userspace interface to nouveau-specific kernel DRM services -- runtime
             83 KiB 	libdrm-radeon1                	Userspace interface to radeon-specific kernel DRM services -- runtime
             49 KiB 	libdrm-tegra0                 	Userspace interface to tegra-specific kernel DRM services -- runtime
            116 KiB 	libdrm2                       	Userspace interface to kernel DRM services -- runtime
            143 KiB 	libdv4                        	software library for DV format digital video (runtime lib)
            116 KiB 	libdvdnav4                    	DVD navigation library
            143 KiB 	libdvdread7                   	library for reading DVDs
            242 KiB 	libedit2                      	BSD editline and history libraries
            117 KiB 	libegl-dev                    	Vendor neutral GL dispatch library -- EGL development files
            332 KiB 	libegl-mesa0                  	free implementation of the EGL API -- Mesa vendor library
            108 KiB 	libegl1                       	Vendor neutral GL dispatch library -- EGL support
             70 KiB 	libegl1-mesa                  	transitional dummy package
             79 KiB 	libegl1-mesa-dev              	free implementation of the EGL API -- development files
            192 KiB 	libelf1                       	library to read and write ELF files
           1448 KiB 	libepoxy0                     	OpenGL function pointer management library
            110 KiB 	libepsilon1                   	Library for wavelet image compression
             71 KiB 	liberror-perl                 	Perl module for error/exception handling in an OO-ish way
             25 KiB 	libestr0                      	Helper functions for handling strings (lib)
            131 KiB 	libevdev2                     	wrapper library for evdev devices
            392 KiB 	libevent-2.1-7                	Asynchronous event notification library
            262 KiB 	libevent-core-2.1-7           	Asynchronous event notification library (core)
             41 KiB 	libevent-pthreads-2.1-7       	Asynchronous event notification library (pthreads)
            508 KiB 	libexif-dev                   	library to parse EXIF files (development files)
            360 KiB 	libexif12                     	library to parse EXIF files
            354 KiB 	libexpat1                     	XML parsing C library - runtime library
            535 KiB 	libext2fs2                    	ext2/ext3/ext4 file system libraries
            497 KiB 	libfaad2                      	freeware Advanced Audio Decoder - runtime files
            161 KiB 	libfakeroot                   	tool for simulating superuser privileges - shared libraries
             57 KiB 	libfastjson4                  	fast json library for C
            549 KiB 	libfdisk1                     	fdisk partitioning library
             58 KiB 	libfdt1                       	Flat Device Trees manipulation library
            271 KiB 	libffi-dev                    	Foreign Function Interface library (development files)
             57 KiB 	libffi7                       	Foreign Function Interface library runtime
            830 KiB 	libfftw3-double3              	Library for computing Fast Fourier Transforms - Double precision
           1382 KiB 	libfftw3-single3              	Library for computing Fast Fourier Transforms - Single precision
            160 KiB 	libfido2-1                    	library for generating and verifying FIDO 2.0 objects
            248 KiB 	libflac8                      	Free Lossless Audio Codec - runtime C library
          26566 KiB 	libflite1                     	Small run-time speech synthesis engine - shared libraries
            502 KiB 	libfluidsynth2                	Real-time MIDI software synthesizer (runtime library)
            313 KiB 	libfontconfig1                	generic font configuration library - runtime
             42 KiB 	libfontenc1                   	X11 font encoding library
            780 KiB 	libfreetype6                  	FreeType 2 font engine, shared library files
             90 KiB 	libfreexl1                    	library for direct reading of Microsoft Excel spreadsheets
            135 KiB 	libfribidi0                   	Free Implementation of the Unicode BiDi algorithm
            300 KiB 	libfuse2                      	Filesystem in Userspace (library)
            293 KiB 	libfyba0                      	FYBA library to read and write Norwegian geodata standard format SOSI
            456 KiB 	libgail-common                	GNOME Accessibility Implementation Library -- common modules
             97 KiB 	libgail18                     	GNOME Accessibility Implementation Library -- shared libraries
            139 KiB 	libgbm1                       	generic buffer management API -- runtime
           9948 KiB 	libgcc-9-dev                  	GCC support library (development files)
             95 KiB 	libgcc-s1                     	GCC support library
             95 KiB 	libgcc1                       	GCC support library (dependency package)
            835 KiB 	libgcrypt20                   	LGPL Crypto library - runtime library
            436 KiB 	libgd3                        	GD Graphics Library
          18671 KiB 	libgdal26                     	Geospatial Data Abstraction Library
             40 KiB 	libgdbm-compat4               	GNU dbm database routines (legacy support runtime version) 
             82 KiB 	libgdbm6                      	GNU dbm database routines (runtime version) 
           2973 KiB 	libgdcm-dev                   	Grassroots DICOM development libraries and headers
          10912 KiB 	libgdcm3.0                    	Grassroots DICOM runtime libraries
            540 KiB 	libgdk-pixbuf2.0-0            	GDK Pixbuf library
             52 KiB 	libgdk-pixbuf2.0-common       	GDK Pixbuf library - data files
           2055 KiB 	libgeos-3.8.0                 	Geometry engine for Geographic Information Systems - C++ Library
            294 KiB 	libgeos-c1v5                  	Geometry engine for Geographic Information Systems - C Library
            246 KiB 	libgeotiff5                   	GeoTIFF (geografic enabled TIFF) library -- run-time files
            221 KiB 	libgfapi0                     	GlusterFS gfapi shared library
           1513 KiB 	libgfortran5                  	Runtime library for GNU Fortran applications
            289 KiB 	libgfrpc0                     	GlusterFS libgfrpc shared library
            140 KiB 	libgfxdr0                     	GlusterFS libgfxdr shared library
             68 KiB 	libgif7                       	library for GIF images (library)
            249 KiB 	libgirepository-1.0-1         	Library for handling GObject introspection data (runtime library)
           1356 KiB 	libgl-dev                     	Vendor neutral GL dispatch library -- GL development files
           1041 KiB 	libgl1                        	Vendor neutral GL dispatch library -- legacy GL support
             70 KiB 	libgl1-mesa-dev               	transitional dummy package
         893647 KiB 	libgl1-mesa-dri               	free implementation of the OpenGL API -- DRI modules
             87 KiB 	libgl2ps1.4                   	Lib providing high quality vector output for OpenGL application
            501 KiB 	libglapi-mesa                 	free implementation of the GL API -- shared library
            701 KiB 	libgles-dev                   	Vendor neutral GL dispatch library -- GLES development files
            170 KiB 	libgles1                      	Vendor neutral GL dispatch library -- GLESv1 support
            182 KiB 	libgles2                      	Vendor neutral GL dispatch library -- GLESv2 support
             70 KiB 	libgles2-mesa                 	transitional dummy package
             70 KiB 	libgles2-mesa-dev             	transitional dummy package
           4042 KiB 	libglib2.0-0                  	GLib library of C routines
            306 KiB 	libglib2.0-bin                	Programs for the GLib library
            283 KiB 	libglib2.0-cil                	CLI binding for the GLib utility library 2.12
            150 KiB 	libglib2.0-cil-dev            	CLI binding for the GLib utility library 2.12
            104 KiB 	libglib2.0-data               	Common files for GLib library
          10542 KiB 	libglib2.0-dev                	Development files for the GLib library
            611 KiB 	libglib2.0-dev-bin            	Development utilities for the GLib library
          21460 KiB 	libglib2.0-doc                	Documentation files for the GLib library
           8779 KiB 	libglib2.0-tests              	GLib library of C routines - installed tests
            415 KiB 	libglu1-mesa                  	Mesa OpenGL utility library (GLU)
           1104 KiB 	libglusterfs0                 	GlusterFS shared library
             65 KiB 	libglvnd-dev                  	Vendor neutral GL dispatch library -- development files
           1509 KiB 	libglvnd0                     	Vendor neutral GL dispatch library
             89 KiB 	libglx-dev                    	Vendor neutral GL dispatch library -- GLX development files
            623 KiB 	libglx-mesa0                  	free implementation of the OpenGL API -- GLX vendor library
            159 KiB 	libglx0                       	Vendor neutral GL dispatch library -- GLX support
            289 KiB 	libgme0                       	Playback library for video game music files - shared library
            519 KiB 	libgmp10                      	Multiprecision arithmetic library
           2240 KiB 	libgnutls30                   	GNU TLS library - main runtime library
            274 KiB 	libgomp1                      	GCC OpenMP (GOMP) support library
            168 KiB 	libgpg-error0                 	GnuPG development runtime library
           3144 KiB 	libgphoto2-6                  	gphoto2 digital camera library
           3596 KiB 	libgphoto2-dev                	gphoto2 digital camera library (development files)
            308 KiB 	libgphoto2-port12             	gphoto2 digital camera port library
             59 KiB 	libgpm2                       	General Purpose Mouse - shared library
            163 KiB 	libgraphite2-3                	Font rendering engine for Complex Scripts -- library
             67 KiB 	libgsm1                       	Shared libraries for GSM speech compressor
            410 KiB 	libgssapi-krb5-2              	MIT Kerberos runtime libraries - krb5 GSS-API Mechanism
            300 KiB 	libgssapi3-heimdal            	Heimdal Kerberos - GSSAPI support library
            111 KiB 	libgssdp-1.2-0                	GObject-based library for SSDP
            588 KiB 	libgstreamer-gl1.0-0          	GStreamer GL libraries
            165 KiB 	libgstreamer-opencv1.0-0      	GStreamer OpenCV libraries
           1026 KiB 	libgstreamer-plugins-bad1.0-0 	GStreamer libraries from the "bad" set
           1142 KiB 	libgstreamer-plugins-bad1.0-de	GStreamer development files for libraries from the "bad" set
           2456 KiB 	libgstreamer-plugins-base1.0-0	GStreamer libraries from the "base" set
           4926 KiB 	libgstreamer-plugins-base1.0-d	GStreamer development files for libraries from the "base" set
            195 KiB 	libgstreamer-plugins-good1.0-0	GStreamer development files for libraries from the "good" set
            184 KiB 	libgstreamer-plugins-good1.0-d	GStreamer development files for libraries from the "good" set
           3856 KiB 	libgstreamer1.0-0             	Core GStreamer libraries and elements
           4936 KiB 	libgstreamer1.0-0-dbg         	Core GStreamer libraries and elements
           6671 KiB 	libgstreamer1.0-dev           	GStreamer core development files
           9816 KiB 	libgtk-3-0                    	GTK graphical user interface library
            420 KiB 	libgtk-3-common               	common files for the GTK graphical user interface library
           5840 KiB 	libgtk2.0-0                   	GTK graphical user interface library - old version
             70 KiB 	libgtk2.0-bin                 	programs for the GTK graphical user interface library
            268 KiB 	libgtk2.0-common              	common files for the GTK graphical user interface library
             60 KiB 	libgudev-1.0-0                	GObject-based wrapper library for libudev
            244 KiB 	libgupnp-1.2-0                	GObject-based library for UPnP
             51 KiB 	libgupnp-igd-1.0-4            	library to handle UPnP IGD port mapping
            991 KiB 	libharfbuzz0b                 	OpenType text shaping engine (shared library)
            121 KiB 	libhavege1                    	entropy source using the HAVEGE algorithm - shared library
            274 KiB 	libhcrypto4-heimdal           	Heimdal Kerberos - crypto library
            724 KiB 	libhdf4-0-alt                 	Hierarchical Data Format library (without NetCDF)
           4536 KiB 	libhdf5-103                   	Hierarchical Data Format 5 (HDF5) - runtime files - serial version
           4658 KiB 	libhdf5-openmpi-103           	Hierarchical Data Format 5 (HDF5) - runtime files - OpenMPI version
            104 KiB 	libheimbase1-heimdal          	Heimdal Kerberos - Base library
             81 KiB 	libheimntlm0-heimdal          	Heimdal Kerberos - NTLM support library
            237 KiB 	libhogweed5                   	low level cryptographic library (public-key cryptos)
             70 KiB 	libhwloc-plugins              	Hierarchical view of the machine - plugins
            312 KiB 	libhwloc15                    	Hierarchical view of the machine - shared libs
            348 KiB 	libhx509-5-heimdal            	Heimdal Kerberos - X509 support library
             28 KiB 	libi2c0                       	userspace I2C programming library
            159 KiB 	libibverbs1                   	Library for direct userspace use of RDMA (InfiniBand/iWARP)
            108 KiB 	libice6                       	X11 Inter-Client Exchange library
          32597 KiB 	libicu66                      	International Components for Unicode
            239 KiB 	libidn11                      	GNU Libidn library, implementation of IETF IDN specifications
            208 KiB 	libidn2-0                     	Internationalized domain names (IDNA2008/TR46) library
             74 KiB 	libiec61883-0                 	partial implementation of IEC 61883 (shared lib)
            587 KiB 	libilmbase-dev                	development files for IlmBase
            523 KiB 	libilmbase24                  	several utility libraries from ILM used by OpenEXR
            110 KiB 	libinput-bin                  	input device management and event handling library - udev quirks
            312 KiB 	libinput10                    	input device management and event handling library - shared library
            816 KiB 	libinstpatch-1.0-2            	MIDI instrument editing library
             78 KiB 	libip4tc2                     	netfilter libip4tc library
             78 KiB 	libip6tc2                     	netfilter libip6tc library
             86 KiB 	libirs-export161              	Exported IRS Shared Library
            497 KiB 	libisc-export1105             	Exported ISC Shared Library
            215 KiB 	libisccfg-export163           	Exported ISC CFG Shared Library
           1946 KiB 	libisl22                      	manipulating sets and relations of integer points bounded by linear constraints
            110 KiB 	libitm1                       	GNU Transactional Memory Library
             56 KiB 	libiw30                       	Wireless tools - library
           1098 KiB 	libjack-jackd2-0              	JACK Audio Connection Kit (libraries)
             79 KiB 	libjansson4                   	C library for encoding, decoding and manipulating JSON data
             80 KiB 	libjbig-dev                   	JBIGkit development files
             69 KiB 	libjbig0                      	JBIGkit libraries
             26 KiB 	libjpeg-dev                   	Independent JPEG Group's JPEG runtime library (dependency package)
            286 KiB 	libjpeg-turbo8                	IJG JPEG compliant runtime library.
            582 KiB 	libjpeg-turbo8-dev            	Development files for the IJG JPEG library
             26 KiB 	libjpeg8                      	Independent JPEG Group's JPEG runtime library (dependency package)
             26 KiB 	libjpeg8-dev                  	Independent JPEG Group's JPEG runtime library (dependency package)
            729 KiB 	libjs-jquery                  	JavaScript library for dynamic web applications
             88 KiB 	libjson-c4                    	JSON manipulation library - shared library
            190 KiB 	libjson-glib-1.0-0            	GLib JSON manipulation library
             40 KiB 	libjson-glib-1.0-common       	GLib JSON manipulation library (common files)
            221 KiB 	libjsoncpp1                   	library for reading and writing JSON for C++
            291 KiB 	libk5crypto3                  	MIT Kerberos runtime libraries - Crypto Library
            104 KiB 	libkate1                      	Codec for karaoke and text encapsulation
             42 KiB 	libkeyutils1                  	Linux Key Management Utilities (library)
            143 KiB 	libkmlbase1                   	Library to manipulate KML 2.2 OGC standard files - libkmlbase
            721 KiB 	libkmldom1                    	Library to manipulate KML 2.2 OGC standard files - libkmldom
            264 KiB 	libkmlengine1                 	Library to manipulate KML 2.2 OGC standard files - libkmlengine
            129 KiB 	libkmod2                      	libkmod shared library
            644 KiB 	libkrb5-26-heimdal            	Heimdal Kerberos - libraries
           1097 KiB 	libkrb5-3                     	MIT Kerberos runtime libraries
            163 KiB 	libkrb5support0               	MIT Kerberos runtime libraries - Support library
            226 KiB 	libksba8                      	X.509 and CMS support library
           5335 KiB 	liblapack3                    	Library of linear algebra routines 3 - shared version
            377 KiB 	liblcms2-2                    	Little CMS 2 color management library
            511 KiB 	libldap-2.4-2                 	OpenLDAP libraries
            102 KiB 	libldap-common                	OpenLDAP common files for libraries
           2663 KiB 	liblept5                      	image processing library
            126 KiB 	liblilv-0-0                   	library for simple use of LV2 plugins
          81948 KiB 	libllvm12                     	Modular compiler and toolchain technologies, runtime library
             54 KiB 	liblocale-gettext-perl        	module using libc functions for internationalization in Perl
           3199 KiB 	liblsan0                      	LeakSanitizer -- a memory leak detector (runtime)
            418 KiB 	libltdl7                      	System independent dlopen wrapper for GNU libtool
            140 KiB 	liblz4-1                      	Fast LZ compression algorithm library - runtime
            575 KiB 	liblzma-dev                   	XZ-format compression library - development files
            251 KiB 	liblzma5                      	XZ-format compression library
            150 KiB 	liblzo2-2                     	data compression library
           5723 KiB 	libmagic-mgc                  	File type determination library using "magic" numbers (compiled magic file)
            208 KiB 	libmagic1                     	Recognize the type of data in a file using "magic" numbers - library
            401 KiB 	libmbim-glib4                 	Support library to use the MBIM protocol
             32 KiB 	libmbim-proxy                 	Proxy to communicate with MBIM ports
             55 KiB 	libminizip1                   	compression library - minizip library
             69 KiB 	libmjpegutils-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
           1037 KiB 	libmm-glib0                   	D-Bus service for managing modems - shared libraries
             74 KiB 	libmms0                       	MMS stream protocol library - shared library
             42 KiB 	libmnl0                       	minimalistic Netlink communication library
            307 KiB 	libmodplug1                   	shared libraries for mod music based on ModPlug
            111 KiB 	libmono-btls-interface4.0-cil 	Mono Mono.Btls.Interface library (for CLI 4.0)
           4780 KiB 	libmono-corlib4.5-cil         	Mono core library (for CLI 4.5)
            153 KiB 	libmono-i18n-west4.0-cil      	Mono I18N.West library (for CLI 4.0)
            122 KiB 	libmono-i18n4.0-cil           	Mono I18N base library (for CLI 4.0)
            339 KiB 	libmono-security4.0-cil       	Mono Security library (for CLI 4.0)
            210 KiB 	libmono-system-configuration4.	Mono System.Configuration library (for CLI 4.0)
           1225 KiB 	libmono-system-core4.0-cil    	Mono System.Core library (for CLI 4.0)
            208 KiB 	libmono-system-numerics4.0-cil	Mono System.Numerics library (for CLI 4.0)
            408 KiB 	libmono-system-security4.0-cil	Mono System.Security library (for CLI 4.0)
           3371 KiB 	libmono-system-xml4.0-cil     	Mono System.Xml library (for CLI 4.0)
           2791 KiB 	libmono-system4.0-cil         	Mono System libraries (for CLI 4.0)
           1006 KiB 	libmount-dev                  	device mounting library - headers and static libraries
            478 KiB 	libmount1                     	device mounting library
            301 KiB 	libmp3lame0                   	MP3 encoding library
            109 KiB 	libmpc3                       	multiple precision complex floating-point library
             80 KiB 	libmpcdec6                    	MusePack decoder - library
            235 KiB 	libmpdec2                     	library for decimal floating point arithmetic (runtime library)
            134 KiB 	libmpeg2-4                    	MPEG1 and MPEG2 video decoder library
            173 KiB 	libmpeg2encpp-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
           1044 KiB 	libmpfr6                      	multiple precision floating-point computation
            292 KiB 	libmpg123-0                   	MPEG layer 1/2/3 audio decoder (shared library)
            129 KiB 	libmplex2-2.1-0               	MJPEG capture/editing/replay and MPEG encoding toolset (library)
             54 KiB 	libmtdev1                     	Multitouch Protocol Translation Library - shared library
            109 KiB 	libmysofa1                    	library to read HRTFs stored in the AES69-2015 SOFA format
           7308 KiB 	libmysqlclient21              	MySQL database client library
            308 KiB 	libncurses6                   	shared libraries for terminal handling
            392 KiB 	libncursesw6                  	shared libraries for terminal handling (wide character support)
             40 KiB 	libndp0                       	Library for Neighbor Discovery Protocol
            153 KiB 	libnetcdf-c++4                	legacy NetCDF C++ interface
           1278 KiB 	libnetcdf15                   	Interface for scientific data access to large binary data
            134 KiB 	libnetfilter-conntrack3       	Netfilter netlink-conntrack library
            384 KiB 	libnettle7                    	low level cryptographic library (symmetric and one-way cryptos)
            188 KiB 	libnewt0.52                   	Not Erik's Windowing Toolkit - text mode windowing with slang
             40 KiB 	libnfnetlink0                 	Netfilter netlink library
            216 KiB 	libnftnl11                    	Netfilter nftables userspace API library
            208 KiB 	libnghttp2-14                 	library implementing HTTP/2 protocol (shared library)
            362 KiB 	libnice10                     	ICE library (shared library)
            176 KiB 	libnl-3-200                   	library for dealing with netlink sockets
             52 KiB 	libnl-genl-3-200              	library for dealing with netlink sockets - generic netlink
            531 KiB 	libnl-route-3-200             	library for dealing with netlink sockets - route interface
           1394 KiB 	libnm0                        	GObject-based client library for NetworkManager
            666 KiB 	libnorm1                      	NACK-Oriented Reliable Multicast (NORM) library
         207464 KiB 	libnpp-11-4                   	NPP native runtime libraries
         219342 KiB 	libnpp-dev-11-4               	NPP native dev links, headers
             32 KiB 	libnpth0                      	replacement for GNU Pth using system threads
            310 KiB 	libnspr4                      	NetScape Portable Runtime Library
            403 KiB 	libnss-systemd                	nss module providing dynamic user and group name resolution
           3653 KiB 	libnss3                       	Network Security Service libraries
             68 KiB 	libnuma1                      	Libraries for controlling NUMA policy
             67 KiB 	libnvidia-container-tools     	NVIDIA container runtime library (command-line tools)
            163 KiB 	libnvidia-container0          	NVIDIA container runtime library
           3082 KiB 	libnvidia-container1          	NVIDIA container runtime library
            458 KiB 	libnvinfer-bin                	TensorRT binaries
        1157390 KiB 	libnvinfer-dev                	TensorRT development libraries and headers
          15924 KiB 	libnvinfer-doc                	TensorRT documentation
          29878 KiB 	libnvinfer-plugin-dev         	TensorRT plugin libraries
          27016 KiB 	libnvinfer-plugin8            	TensorRT plugin libraries
         536874 KiB 	libnvinfer-samples            	TensorRT samples
         694687 KiB 	libnvinfer8                   	TensorRT runtime libraries
           2759 KiB 	libnvonnxparsers-dev          	TensorRT ONNX libraries
           2760 KiB 	libnvonnxparsers8             	TensorRT ONNX libraries
           4730 KiB 	libnvparsers-dev              	TensorRT parsers libraries
           3374 KiB 	libnvparsers8                 	TensorRT parsers libraries
         131734 KiB 	libnvvpi2                     	NVIDIA Vision Programming Interface library
            569 KiB 	libodbc1                      	ODBC library for Unix
            155 KiB 	libofa0                       	library for acoustic fingerprinting
            568 KiB 	libogdi4.1                    	Open Geographic Datastore Interface Library -- library
             62 KiB 	libogg0                       	Ogg bitstream library
            206 KiB 	libopenal-data                	Software implementation of the OpenAL audio API (data files)
            930 KiB 	libopenal1                    	Software implementation of the OpenAL audio API (shared library)
            175 KiB 	libopencore-amrnb0            	Adaptive Multi Rate speech codec - shared library
             92 KiB 	libopencore-amrwb0            	Adaptive Multi-Rate - Wideband speech codec - shared library
          61984 KiB 	libopencv                     	Open Computer Vision Library
           1365 KiB 	libopencv-calib3d4.2          	computer vision Camera Calibration library
           8383 KiB 	libopencv-contrib4.2          	computer vision contrlib library
           2693 KiB 	libopencv-core4.2             	computer vision core library
           6336 KiB 	libopencv-dev                 	Open Computer Vision Library
           2855 KiB 	libopencv-dnn4.2              	computer vision Deep neural network module
            665 KiB 	libopencv-features2d4.2       	computer vision Feature Detection and Descriptor Extraction library
            369 KiB 	libopencv-flann4.2            	computer vision Clustering and Search in Multi-Dimensional spaces library
            120 KiB 	libopencv-highgui4.2          	computer vision High-level GUI and Media I/O library
            333 KiB 	libopencv-imgcodecs4.2        	computer vision Image Codecs library
           3000 KiB 	libopencv-imgproc4.2          	computer vision Image Processing library
            636 KiB 	libopencv-ml4.2               	computer vision Machine Learning library
            381 KiB 	libopencv-objdetect4.2        	computer vision Object Detection library
            668 KiB 	libopencv-photo4.2            	computer vision computational photography library
          11731 KiB 	libopencv-python              	Open Computer Vision Library
           1065 KiB 	libopencv-samples             	Open Computer Vision Library
            188 KiB 	libopencv-shape4.2            	computer vision shape descriptors and matchers library
            669 KiB 	libopencv-stitching4.2        	computer vision image stitching library
            180 KiB 	libopencv-superres4.2         	computer vision Super Resolution library
            417 KiB 	libopencv-video4.2            	computer vision Video analysis library
            445 KiB 	libopencv-videoio4.2          	computer vision Video I/O library
            324 KiB 	libopencv-videostab4.2        	computer vision video stabilization library
            408 KiB 	libopencv-viz4.2              	computer vision 3D data visualization library
            958 KiB 	libopencv4.2-java             	Java bindings for the computer vision library
           1806 KiB 	libopencv4.2-jni              	Java jni library for the computer vision library
           5608 KiB 	libopenexr-dev                	development files for the OpenEXR image library
           2974 KiB 	libopenexr24                  	runtime files for the OpenEXR image library
             22 KiB 	libopengl-dev                 	Vendor neutral GL dispatch library -- OpenGL development files
            416 KiB 	libopengl0                    	Vendor neutral GL dispatch library -- OpenGL support
            379 KiB 	libopenjp2-7                  	JPEG 2000 image compression/decompression library
           6946 KiB 	libopenmpi3                   	high performance message passing library -- shared library
           1528 KiB 	libopenmpt0                   	module music library based on OpenMPT -- shared library
            343 KiB 	libopus0                      	Opus codec runtime library
           1053 KiB 	liborc-0.4-0                  	Library of Optimized Inner Loops Runtime Compiler
           1337 KiB 	liborc-0.4-dev                	Library of Optimized Inner Loops Runtime Compiler (development headers)
           1056 KiB 	liborc-0.4-dev-bin            	Library of Optimized Inner Loops Runtime Compiler (development tools)
           1299 KiB 	libp11-kit0                   	library for loading and coordinating access to PKCS#11 modules - runtime
            941 KiB 	libpam-modules                	Pluggable Authentication Modules for PAM
            290 KiB 	libpam-modules-bin            	Pluggable Authentication Modules for PAM - helper binaries
            304 KiB 	libpam-runtime                	Runtime support for the PAM library
            624 KiB 	libpam-systemd                	system and service manager - PAM module
            219 KiB 	libpam0g                      	Pluggable Authentication Modules library
            409 KiB 	libpango-1.0-0                	Layout and rendering of internationalized text
            103 KiB 	libpangocairo-1.0-0           	Layout and rendering of internationalized text
            133 KiB 	libpangoft2-1.0-0             	Layout and rendering of internationalized text
            445 KiB 	libparted2                    	disk partition manipulator - shared library
            325 KiB 	libpcap0.8                    	system interface for user-level packet capture
            105 KiB 	libpci3                       	PCI utilities (shared library)
             57 KiB 	libpciaccess0                 	Generic PCI access library for X
            490 KiB 	libpcre16-3                   	Old Perl 5 Compatible Regular Expression Library - 16 bit runtime files
            487 KiB 	libpcre2-16-0                 	New Perl Compatible Regular Expression Library - 16 bit runtime files
            455 KiB 	libpcre2-32-0                 	New Perl Compatible Regular Expression Library - 32 bit runtime files
            524 KiB 	libpcre2-8-0                  	New Perl Compatible Regular Expression Library- 8 bit runtime files
           2007 KiB 	libpcre2-dev                  	New Perl Compatible Regular Expression Library - development files
             29 KiB 	libpcre2-posix2               	New Perl Compatible Regular Expression Library - posix-compatible runtime files
            601 KiB 	libpcre3                      	Old Perl 5 Compatible Regular Expression Library - runtime files
           1807 KiB 	libpcre3-dev                  	Old Perl 5 Compatible Regular Expression Library - development files
            466 KiB 	libpcre32-3                   	Old Perl 5 Compatible Regular Expression Library - 32 bit runtime files
            189 KiB 	libpcrecpp0v5                 	Old Perl 5 Compatible Regular Expression Library - C++ runtime files
             71 KiB 	libpcsclite1                  	Middleware to access a smart card using PC/SC (library)
          26547 KiB 	libperl5.30                   	shared Perl library
            313 KiB 	libpgm-5.2-0                  	OpenPGM shared library
             76 KiB 	libpipeline1                  	Unix process pipeline manipulation library
            407 KiB 	libpixman-1-0                 	pixel-manipulation library for X and cairo
           1571 KiB 	libpmix2                      	Process Management Interface (Exascale) library
            699 KiB 	libpng-dev                    	PNG library - development (version 1.6)
            328 KiB 	libpng16-16                   	PNG library - runtime (version 1.6)
             71 KiB 	libpolkit-agent-1-0           	PolicyKit Authentication Agent API
            153 KiB 	libpolkit-gobject-1-0         	PolicyKit Authorization API
           3280 KiB 	libpoppler97                  	PDF rendering library
            120 KiB 	libpopt0                      	lib for parsing cmdline parameters
            119 KiB 	libpostproc55                 	FFmpeg library for post processing - runtime files
            392 KiB 	libpq5                        	PostgreSQL C client library
            123 KiB 	libprocps8                    	library for accessing process information from /proc
           3023 KiB 	libproj15                     	Cartographic projection library
           2794 KiB 	libprotobuf17                 	protocol buffers C++ library
            140 KiB 	libproxy1v5                   	automatic proxy configuration management library (shared)
             87 KiB 	libpsl5                       	Library for Public Suffix List (shared libraries)
             18 KiB 	libpthread-stubs0-dev         	pthread stubs not provided by native libc, development files
            928 KiB 	libpulse0                     	PulseAudio client libraries
             38 KiB 	libpython2-stdlib             	interactive high-level object-oriented language (Python2)
           3470 KiB 	libpython2.7                  	Shared Python runtime library (version 2.7)
           2782 KiB 	libpython2.7-minimal          	Minimal subset of the Python language (version 2.7)
           8735 KiB 	libpython2.7-stdlib           	Interactive high-level object-oriented language (standard library, version 2.7)
             38 KiB 	libpython3-stdlib             	interactive high-level object-oriented language (default python3 version)
           5357 KiB 	libpython3.8                  	Shared Python runtime library (version 3.8)
           4785 KiB 	libpython3.8-minimal          	Minimal subset of the Python language (version 3.8)
           7654 KiB 	libpython3.8-stdlib           	Interactive high-level object-oriented language (standard library, version 3.8)
           4955 KiB 	libpython3.9-minimal          	Minimal subset of the Python language (version 3.9)
           7868 KiB 	libpython3.9-stdlib           	Interactive high-level object-oriented language (standard library, version 3.9)
            368 KiB 	libqhull7                     	calculate convex hulls and related structures (shared library)
           3315 KiB 	libqmi-glib5                  	Support library to use the Qualcomm MSM Interface (QMI) protocol
             33 KiB 	libqmi-proxy                  	Proxy to communicate with QMI ports
          12878 KiB 	librados2                     	RADOS distributed object store client library
             80 KiB 	libraw1394-11                 	library for direct access to IEEE 1394 bus (aka FireWire)
            174 KiB 	libraw1394-dev                	library for direct access to IEEE 1394 bus - development files
           5331 KiB 	librbd1                       	RADOS block device client library
           1110 KiB 	librdkafka1                   	library implementing the Apache Kafka protocol
            186 KiB 	librdmacm1                    	Library for managing RDMA connections
            428 KiB 	libreadline8                  	GNU readline and history libraries, run-time libraries
            115 KiB 	librest-0.7-0                 	REST service access library
            136 KiB 	libroken18-heimdal            	Heimdal Kerberos - roken support library
           8428 KiB 	librsvg2-2                    	SAX-based renderer library for SVG files (runtime)
             58 KiB 	librsvg2-common               	SAX-based renderer library for SVG files (extra runtime)
            131 KiB 	librtmp1                      	toolkit for RTMP streams (shared library)
            240 KiB 	librubberband2                	audio time-stretching and pitch-shifting library
           1468 KiB 	libsamplerate0                	Audio sample rate conversion library
            148 KiB 	libsasl2-2                    	Cyrus SASL - authentication abstraction library
             61 KiB 	libsasl2-modules-db           	Cyrus SASL - pluggable authentication modules (DB)
             76 KiB 	libsbc1                       	Sub Band CODEC library - runtime
           1289 KiB 	libsdl2-2.0-0                 	Simple DirectMedia Layer
            140 KiB 	libseccomp2                   	high level interface to Linux seccomp filter
            194 KiB 	libselinux1                   	SELinux runtime shared libraries
            777 KiB 	libselinux1-dev               	SELinux development headers
             36 KiB 	libsemanage-common            	Common files for SELinux policy management libraries
            289 KiB 	libsemanage1                  	SELinux policy management library
             42 KiB 	libsensors-config             	lm-sensors configuration files
             96 KiB 	libsensors5                   	library to read temperature/voltage/fan sensors
            726 KiB 	libsepol1                     	SELinux library for manipulating binary security policies
           1834 KiB 	libsepol1-dev                 	SELinux binary policy manipulation library and development files
            130 KiB 	libserd-0-0                   	lightweight RDF syntax library
             55 KiB 	libshine3                     	Fixed-point MP3 encoding library - runtime files
            146 KiB 	libshout3                     	MP3/Ogg Vorbis broadcast streaming library
            246 KiB 	libsidplay1v5                 	SID (MOS 6581) emulation library
           1731 KiB 	libslang2                     	S-Lang programming library - runtime version
             47 KiB 	libsm6                        	X11 Session Management library
            342 KiB 	libsmartcols1                 	smart column output alignment library
             52 KiB 	libsnappy1v5                  	fast compression/decompression library
            499 KiB 	libsndfile1                   	Library for reading/writing audio files
             74 KiB 	libsndio7.0                   	Small audio and MIDI framework from OpenBSD, runtime libraries
            150 KiB 	libsocket++1                  	lightweight convenience library to handle low level BSD sockets in C++ - libs
            278 KiB 	libsodium23                   	Network communication, cryptography and signaturing library
             56 KiB 	libsord-0-0                   	library for storing RDF data in memory
             86 KiB 	libsoundtouch1                	Sound stretching library
             44 KiB 	libsoup-gnome2.4-1            	HTTP library implementation in C -- GNOME support library
            725 KiB 	libsoup2.4-1                  	HTTP library implementation in C -- Shared library
            149 KiB 	libsoxr0                      	High quality 1D sample-rate conversion library
            819 KiB 	libspandsp2                   	Telephony signal processing library
           5371 KiB 	libspatialite7                	Geospatial extension for SQLite - libraries
            113 KiB 	libspeex1                     	The Speex codec runtime library
           1296 KiB 	libsqlite3-0                  	SQLite 3 shared library
             52 KiB 	libsratom-0-0                 	library for serialising LV2 atoms to/from Turtle
            589 KiB 	libsrt1                       	Secure Reliable Transport UDP streaming library
            155 KiB 	libsrtp2-1                    	Secure RTP (SRTP) and UST Reference Implementations - shared library
            103 KiB 	libss2                        	command-line interface parsing library
            479 KiB 	libssh-4                      	tiny C SSH library (OpenSSL flavor)
            594 KiB 	libssh-gcrypt-4               	tiny C SSH library (gcrypt flavor)
           3613 KiB 	libssl1.1                     	Secure Sockets Layer toolkit - shared libraries
          17672 KiB 	libstdc++-9-dev               	GNU Standard C++ Library v3 (development files)
           2389 KiB 	libstdc++6                    	GNU Standard C++ Library v3
            402 KiB 	libsuperlu5                   	Direct solution of large, sparse systems of linear equations
            247 KiB 	libswresample-dev             	FFmpeg library for audio resampling, rematrixing etc. - development files
            168 KiB 	libswresample3                	FFmpeg library for audio resampling, rematrixing etc. - runtime files
            738 KiB 	libswscale-dev                	FFmpeg library for image scaling and various conversions - development files
            492 KiB 	libswscale5                   	FFmpeg library for image scaling and various conversions - runtime files
            869 KiB 	libsystemd0                   	systemd utility library
             24 KiB 	libsz2                        	Adaptive Entropy Coding library - SZIP
             50 KiB 	libtag1v5                     	audio meta-data library
           1101 KiB 	libtag1v5-vanilla             	audio meta-data library - vanilla flavour
            116 KiB 	libtasn1-6                    	Manage ASN.1 structures (runtime)
           1972 KiB 	libtbb-dev                    	parallelism library for C++ - development files
            285 KiB 	libtbb2                       	parallelism library for C++ - runtime files
            134 KiB 	libtdb1                       	Trivial Database - shared library
             41 KiB 	libteamdctl0                  	library for communication with `teamd` process
           3081 KiB 	libtesseract4                 	Tesseract OCR library
            586 KiB 	libthai-data                  	Data files for Thai language support library
             91 KiB 	libthai0                      	Thai language support library
            587 KiB 	libtheora0                    	Theora Video Compression Codec
           1015 KiB 	libtiff-dev                   	Tag Image File Format library (TIFF), development files
            524 KiB 	libtiff5                      	Tag Image File Format (TIFF) library
             42 KiB 	libtiffxx5                    	Tag Image File Format (TIFF) library -- C++ interface
            522 KiB 	libtinfo5                     	shared low-level terminfo library (legacy version)
            529 KiB 	libtinfo6                     	shared low-level terminfo library for terminal handling
             30 KiB 	libtirpc-common               	transport-independent RPC library - common files
            221 KiB 	libtirpc3                     	transport-independent RPC library
           9081 KiB 	libtsan0                      	ThreadSanitizer -- a Valgrind-based detector of data races (runtime)
            139 KiB 	libtwolame0                   	MPEG Audio Layer 2 encoding library
           3021 KiB 	libubsan1                     	UBSan -- undefined behaviour sanitizer (runtime)
            179 KiB 	libuchardet0                  	universal charset detection library - shared library
            330 KiB 	libudev1                      	libudev shared library
           1549 KiB 	libunistring2                 	Unicode string library for C
            176 KiB 	libunwind8                    	library to determine the call-chain of a program - runtime
            119 KiB 	liburiparser1                 	URI parsing library compliant with RFC 3986
            132 KiB 	libusb-1.0-0                  	userspace USB programming library
            801 KiB 	libusrsctp1                   	portable SCTP userland stack - shared library
             42 KiB 	libutempter0                  	privileged helper for utmp/wtmp updates (runtime)
            118 KiB 	libuuid1                      	Universally Unique ID library
            209 KiB 	libv4l-0                      	Collection of video4linux support libraries
            270 KiB 	libv4lconvert0                	Video4linux frame format conversion library
             40 KiB 	libva-drm2                    	Video Acceleration (VA) API for Linux -- DRM runtime
             52 KiB 	libva-x11-2                   	Video Acceleration (VA) API for Linux -- X11 runtime
            182 KiB 	libva2                        	Video Acceleration (VA) API for Linux -- runtime
             97 KiB 	libvdpau1                     	Video Decode and Presentation API for Unix (libraries)
             84 KiB 	libvidstab1.1                 	video stabilization library (shared library)
            360 KiB 	libvisual-0.4-0               	audio visualization framework
            125 KiB 	libvo-aacenc0                 	VisualOn AAC encoder library
            121 KiB 	libvo-amrwbenc0               	VisualOn AMR-WB encoder library
            193 KiB 	libvorbis0a                   	decoder library for Vorbis General Audio Compression Codec
            663 KiB 	libvorbisenc2                 	encoder library for Vorbis General Audio Compression Codec
             59 KiB 	libvorbisfile3                	high-level API for Vorbis General Audio Compression Codec
           1822 KiB 	libvpx6                       	VP8 and VP9 video codec (shared library)
          64931 KiB 	libvtk6.3                     	VTK libraries
            381 KiB 	libvulkan1                    	Vulkan loader library
             26 KiB 	libwacom-bin                  	Wacom model feature query library -- binaries
            722 KiB 	libwacom-common               	Wacom model feature query library (common files)
             62 KiB 	libwacom2                     	Wacom model feature query library
            177 KiB 	libwavpack1                   	audio codec (lossy and lossless) - library
             80 KiB 	libwayland-client0            	wayland compositor infrastructure - client library
             49 KiB 	libwayland-cursor0            	wayland compositor infrastructure - cursor library
             24 KiB 	libwayland-egl1               	wayland compositor infrastructure - EGL library
            102 KiB 	libwayland-server0            	wayland compositor infrastructure - server library
            334 KiB 	libwebp6                      	Lossy compression of digital photographic images.
             53 KiB 	libwebpmux3                   	Lossy compression of digital photographic images.
            636 KiB 	libwebrtc-audio-processing1   	AudioProcessing module from the WebRTC project.
            154 KiB 	libwildmidi2                  	software MIDI player library
            204 KiB 	libwind0-heimdal              	Heimdal Kerberos - stringprep implementation
            105 KiB 	libwrap0                      	Wietse Venema's TCP wrappers library
           1345 KiB 	libx11-6                      	X11 client-side library
           1506 KiB 	libx11-data                   	X11 client-side library
           2495 KiB 	libx11-dev                    	X11 client-side library (development headers)
             81 KiB 	libx11-xcb-dev                	Xlib/XCB interface library (development headers)
             76 KiB 	libx11-xcb1                   	Xlib/XCB interface library
           1343 KiB 	libx264-155                   	x264 video coding library
           2853 KiB 	libx265-179                   	H.265/HEVC video stream encoder (shared library)
             55 KiB 	libxau-dev                    	X11 authorisation library (development headers)
             31 KiB 	libxau6                       	X11 authorisation library
            417 KiB 	libxaw7                       	X11 Athena Widget library
             41 KiB 	libxcb-dri2-0                 	X C Binding, dri2 extension
             37 KiB 	libxcb-dri3-0                 	X C Binding, dri3 extension
            145 KiB 	libxcb-glx0                   	X C Binding, glx extension
             53 KiB 	libxcb-icccm4                 	utility libraries for X C Binding -- icccm
             46 KiB 	libxcb-image0                 	utility libraries for X C Binding -- image
             37 KiB 	libxcb-keysyms1               	utility libraries for X C Binding -- keysyms
             31 KiB 	libxcb-present0               	X C Binding, present extension
             97 KiB 	libxcb-randr0                 	X C Binding, randr extension
             43 KiB 	libxcb-render-util0           	utility libraries for X C Binding -- render-util
             86 KiB 	libxcb-render0                	X C Binding, render extension
             36 KiB 	libxcb-shape0                 	X C Binding, shape extension
             31 KiB 	libxcb-shm0                   	X C Binding, shm extension
             50 KiB 	libxcb-sync1                  	X C Binding, sync extension
             56 KiB 	libxcb-util1                  	utility libraries for X C Binding -- atom, aux and event
             55 KiB 	libxcb-xfixes0                	X C Binding, xfixes extension
             32 KiB 	libxcb-xinerama0              	X C Binding, xinerama extension
            147 KiB 	libxcb-xinput0                	X C Binding, xinput extension
            145 KiB 	libxcb-xkb1                   	X C Binding, XKEYBOARD extension
            198 KiB 	libxcb1                       	X C Binding
            701 KiB 	libxcb1-dev                   	X C Binding, development files
             27 KiB 	libxcomposite1                	X11 Composite extension library
             59 KiB 	libxcursor1                   	X cursor management library
             26 KiB 	libxdamage1                   	X11 damaged region extension library
             68 KiB 	libxdmcp-dev                  	X11 authorisation library (development headers)
             38 KiB 	libxdmcp6                     	X11 Display Manager Control Protocol library
           3506 KiB 	libxerces-c3.2                	validating XML parser library for C++
            106 KiB 	libxext6                      	X11 miscellaneous extension library
             42 KiB 	libxfixes3                    	X11 miscellaneous 'fixes' extension library
            184 KiB 	libxfont2                     	X11 font rasterisation library
            106 KiB 	libxft2                       	FreeType-based font drawing library for X
             88 KiB 	libxi6                        	X11 Input extension library
             29 KiB 	libxinerama1                  	X11 Xinerama extension library
             50 KiB 	libxkbcommon-x11-0            	library to create keymaps with the XKB X11 protocol
            273 KiB 	libxkbcommon0                 	library interface to the XKB compiler - shared library
            166 KiB 	libxkbfile1                   	X11 keyboard file manipulation library
           1854 KiB 	libxml2                       	GNOME XML library
            119 KiB 	libxmu6                       	X11 miscellaneous utility library
             37 KiB 	libxmuu1                      	X11 miscellaneous micro-utility library
             60 KiB 	libxnvctrl0                   	NV-CONTROL X extension (runtime library)
             77 KiB 	libxpm4                       	X11 pixmap library
             65 KiB 	libxrandr2                    	X11 RandR extension library
             56 KiB 	libxrender1                   	X Rendering Extension client library
             25 KiB 	libxshmfence1                 	X shared memory fences - shared library
             32 KiB 	libxss1                       	X11 Screen Saver extension library
            394 KiB 	libxt6                        	X11 toolkit intrinsics library
            104 KiB 	libxtables12                  	netfilter xtables library
             44 KiB 	libxtst6                      	X11 Testing -- Record extension library
             36 KiB 	libxv1                        	X11 Video extension library
            464 KiB 	libxvidcore4                  	Open source MPEG-4 video codec (library)
             43 KiB 	libxxf86dga1                  	X11 Direct Graphics Access extension library
             39 KiB 	libxxf86vm1                   	X11 XFree86 video mode extension library
            128 KiB 	libyaml-0-2                   	Fast YAML 1.1 parser and emitter library
            256 KiB 	libzbar0                      	QR code / bar code scanner and decoder (library)
            659 KiB 	libzmq5                       	lightweight messaging kernel (shared library)
            607 KiB 	libzstd1                      	fast lossless compression algorithm
            141 KiB 	libzvbi-common                	Vertical Blanking Interval decoder (VBI) - common files
            660 KiB 	libzvbi0                      	Vertical Blanking Interval decoder (VBI) - runtime files
           5941 KiB 	linux-libc-dev                	Linux Kernel Headers for development
          17196 KiB 	locales                       	GNU C Library: National Language (locale) data [support]
            908 KiB 	login                         	system login tools
             91 KiB 	logsave                       	save the output of a command in a log file
             58 KiB 	lsb-base                      	Linux Standard Base init script functionality
             66 KiB 	lsb-release                   	Linux Standard Base version reporting utility
            380 KiB 	make                          	utility for directing compilation
           2744 KiB 	man-db                        	tools for reading manual pages
            225 KiB 	mawk                          	Pattern scanning and text processing language
            114 KiB 	mime-support                  	MIME files 'mime.types' & 'mailcap', and support programs
           3664 KiB 	modemmanager                  	D-Bus service for managing modems
            546 KiB 	mono-4.0-gac                  	Mono GAC tool (for CLI 4.0)
             98 KiB 	mono-gac                      	Mono GAC tool
             89 KiB 	mono-runtime                  	Mono runtime - default version
           3316 KiB 	mono-runtime-common           	Mono runtime - common files
           4433 KiB 	mono-runtime-sgen             	Mono runtime - SGen
            406 KiB 	mount                         	tools for mounting and manipulating filesystems
           1142 KiB 	mtd-utils                     	Memory Technology Device Utilities
             34 KiB 	mysql-common                  	MySQL database common files, e.g. /etc/mysql/my.cnf
            381 KiB 	ncurses-base                  	basic terminal type definitions
            606 KiB 	ncurses-bin                   	terminal-related programs and man pages
            808 KiB 	net-tools                     	NET-3 networking toolkit
             43 KiB 	netbase                       	Basic TCP/IP networking system
             15 KiB 	netcat                        	TCP/IP swiss army knife -- transitional package
            104 KiB 	netcat-openbsd                	TCP/IP swiss army knife
           7212 KiB 	network-manager               	network management framework (daemon and userspace tools)
            212 KiB 	network-manager-pptp          	network management framework (PPTP plugin core)
             66 KiB 	networkd-dispatcher           	Dispatcher service for systemd-networkd connection status changes
                KiB 	nsight-systems-2022.2.3       	Nsight Systems is a statistical sampling profiler with tracing features.
            194 KiB 	nvidia-container              	NVIDIA Container Meta Package
             21 KiB 	nvidia-container-runtime      	NVIDIA container runtime
           4224 KiB 	nvidia-container-toolkit      	NVIDIA container runtime hook
            224 KiB 	nvidia-cuda                   	NVIDIA CUDA Meta Package
            175 KiB 	nvidia-cudnn8                 	NVIDIA CUDNN8 Meta Package
             27 KiB 	nvidia-docker2                	nvidia-docker CLI wrapper
            194 KiB 	nvidia-jetpack                	NVIDIA Jetpack Meta Package
         159907 KiB 	nvidia-l4t-3d-core            	NVIDIA GL EGL Package
             31 KiB 	nvidia-l4t-apt-source         	NVIDIA L4T apt source list debian package
         196453 KiB 	nvidia-l4t-bootloader         	NVIDIA Bootloader Package
          20657 KiB 	nvidia-l4t-camera             	NVIDIA Camera Package
           1506 KiB 	nvidia-l4t-configs            	NVIDIA configs debian package
           9392 KiB 	nvidia-l4t-core               	NVIDIA Core Package
          22694 KiB 	nvidia-l4t-cuda               	NVIDIA CUDA Package
           4479 KiB 	nvidia-l4t-display-kernel     	NVIDIA Display Kernel Modules Package
          14546 KiB 	nvidia-l4t-firmware           	NVIDIA Firmware Package
             38 KiB 	nvidia-l4t-gputools           	NVIDIA dgpu helper Package
          69520 KiB 	nvidia-l4t-graphics-demos     	NVIDIA graphics demo applications
           3698 KiB 	nvidia-l4t-gstreamer          	NVIDIA GST Application files
          16722 KiB 	nvidia-l4t-init               	NVIDIA Init debian package
          16419 KiB 	nvidia-l4t-initrd             	NVIDIA initrd debian package
            134 KiB 	nvidia-l4t-jetson-io          	NVIDIA Jetson.IO debian package
          93611 KiB 	nvidia-l4t-jetson-multimedia-a	NVIDIA Jetson Multimedia API is a collection of lower-level APIs that support flexible application development.
            159 KiB 	nvidia-l4t-jetsonpower-gui-too	NVIDIA Jetson Power GUI Tools debian package
         234499 KiB 	nvidia-l4t-kernel             	NVIDIA Kernel Package
           2941 KiB 	nvidia-l4t-kernel-dtbs        	NVIDIA Kernel DTB Package
          70435 KiB 	nvidia-l4t-kernel-headers     	NVIDIA Linux Tegra Kernel Headers Package
            596 KiB 	nvidia-l4t-libvulkan          	NVIDIA Vulkan Loader Package
          29841 KiB 	nvidia-l4t-multimedia         	NVIDIA Multimedia Package
            742 KiB 	nvidia-l4t-multimedia-utils   	NVIDIA Multimedia Package
             59 KiB 	nvidia-l4t-nvfancontrol       	NVIDIA Nvfancontrol debian package
            198 KiB 	nvidia-l4t-nvpmodel           	NVIDIA Nvpmodel debian package
             86 KiB 	nvidia-l4t-nvpmodel-gui-tools 	NVIDIA Nvpmodel GUI Tools debian package
            903 KiB 	nvidia-l4t-nvsci              	NVIDIA NvSci Package
            110 KiB 	nvidia-l4t-oem-config         	NVIDIA OEM-Config Package
           6290 KiB 	nvidia-l4t-optee              	OP-TEE userspace daemons, test programs and libraries
             81 KiB 	nvidia-l4t-pva                	NVIDIA PVA Package
           3289 KiB 	nvidia-l4t-tools              	NVIDIA Public Test Tools Package
             77 KiB 	nvidia-l4t-wayland            	NVIDIA Wayland Package
           4682 KiB 	nvidia-l4t-weston             	NVIDIA Weston Package
            226 KiB 	nvidia-l4t-x11                	NVIDIA X11 Package
            602 KiB 	nvidia-l4t-xusb-firmware      	NVIDIA USB Firmware Package
            194 KiB 	nvidia-nsight-sys             	NVIDIA Nsight System Meta Package
            194 KiB 	nvidia-opencv                 	NVIDIA OpenCV Meta Package
            200 KiB 	nvidia-tensorrt               	NVIDIA TensorRT Meta Package
            194 KiB 	nvidia-vpi                    	NVIDIA Vpi Meta Package
            105 KiB 	ocl-icd-libopencl1            	Generic OpenCL ICD Loader
             55 KiB 	odbcinst                      	Helper program for accessing odbc ini files
            210 KiB 	odbcinst1debian2              	Support library for accessing odbc ini files
             58 KiB 	opencv-licenses               	Open Computer Vision Library
           3965 KiB 	openssh-client                	secure shell (SSH) client, for secure access to remote machines
           1471 KiB 	openssh-server                	secure shell (SSH) server, for secure access from remote machines
            137 KiB 	openssh-sftp-server           	secure shell (SSH) sftp server module, for SFTP access from remote machines
           1213 KiB 	openssl                       	Secure Sockets Layer toolkit - cryptographic utility
            159 KiB 	parted                        	disk partition manipulator
           2536 KiB 	passwd                        	change and administer password and group data
            224 KiB 	patch                         	Apply a diff file to an original
           1193 KiB 	pci.ids                       	PCI ID Repository
            175 KiB 	pciutils                      	PCI utilities
            745 KiB 	perl                          	Larry Wall's Practical Extraction and Report Language
          10407 KiB 	perl-base                     	minimal Perl system
          17226 KiB 	perl-modules-5.30             	Core Perl modules
            229 KiB 	pigz                          	Parallel Implementation of GZip
             92 KiB 	pinentry-curses               	curses-based PIN or pass-phrase entry dialog for GnuPG
            182 KiB 	pkg-config                    	manage compile and link flags for libraries
            524 KiB 	policykit-1                   	framework for managing administrative policies and privileges
            961 KiB 	ppp                           	Point-to-Point Protocol (PPP) - daemon
            109 KiB 	pptp-linux                    	Point-to-Point Tunneling Protocol (PPTP) Client
            803 KiB 	procps                        	/proc file system utilities
          23574 KiB 	proj-data                     	Cartographic projection filter and library (datum package)
            268 KiB 	python-apt-common             	Python interface to libapt-pkg (locales)
             10 KiB 	python-is-python3             	symlinks /usr/bin/python to python3
            105 KiB 	python-jetson-gpio            	Jetson GPIO library package (Python 2)
            136 KiB 	python2                       	interactive high-level object-oriented language (Python2 version)
            144 KiB 	python2-minimal               	minimal subset of the Python2 language
            382 KiB 	python2.7                     	Interactive high-level object-oriented language (version 2.7)
           3642 KiB 	python2.7-minimal             	Minimal subset of the Python language (version 2.7)
            189 KiB 	python3                       	interactive high-level object-oriented language (default python3 version)
            588 KiB 	python3-apport                	Python 3 library for Apport crash report handling
            699 KiB 	python3-apt                   	Python 3 interface to libapt-pkg
             55 KiB 	python3-blinker               	fast, simple object-to-object and broadcast signaling library
            319 KiB 	python3-certifi               	root certificates for validating SSL certs and verifying TLS hosts (python3)
            213 KiB 	python3-cffi-backend          	Foreign Function Interface for Python 3 calling C code - runtime
            411 KiB 	python3-chardet               	universal character encoding detector for Python3
           1379 KiB 	python3-crypto                	cryptographic algorithms and protocols for Python 3
           1597 KiB 	python3-cryptography          	Python library exposing cryptographic recipes and primitives (Python 3)
            411 KiB 	python3-dbus                  	simple interprocess messaging system (Python 3 interface)
            365 KiB 	python3-dbusmock              	mock D-Bus objects for tests
             69 KiB 	python3-distro                	Linux OS platform information API
           1363 KiB 	python3-distutils             	distutils package for Python 3.x
             23 KiB 	python3-entrypoints           	Discover and load entry points from installed packages (Python 3)
            692 KiB 	python3-gi                    	Python 3 bindings for gobject-introspection libraries
            130 KiB 	python3-httplib2              	comprehensive HTTP client library written for Python3
            289 KiB 	python3-idna                  	Python IDNA2008 (RFC 5891) handling (Python 3)
            105 KiB 	python3-jetson-gpio           	Jetson GPIO library package (Python 3)
             85 KiB 	python3-jwt                   	Python 3 implementation of JSON Web Token
            155 KiB 	python3-keyring               	store and access your passwords safely - Python 3 version of the package
            243 KiB 	python3-launchpadlib          	Launchpad web services client library (Python 3)
            185 KiB 	python3-lazr.restfulclient    	client for lazr.restful-based web services (Python 3)
             74 KiB 	python3-lazr.uri              	library for parsing, manipulating, and generating URIs
            702 KiB 	python3-lib2to3               	Interactive high-level object-oriented language (lib2to3)
           3205 KiB 	python3-libnvinfer            	Python 3 bindings for TensorRT
             10 KiB 	python3-libnvinfer-dev        	Python 3 development package for TensorRT
            120 KiB 	python3-minimal               	minimal subset of the Python language (default python3 version)
            540 KiB 	python3-oauthlib              	generic, spec-compliant implementation of OAuth for Python3
            567 KiB 	python3-pkg-resources         	Package Discovery and Resource Access using pkg_resources
            177 KiB 	python3-problem-report        	Python 3 library to handle problem reports
            298 KiB 	python3-pyparsing             	alternative to creating and executing simple grammars - Python 3.x
            228 KiB 	python3-requests              	elegant and simple HTTP library for Python3, built for human beings
             34 KiB 	python3-requests-unixsocket   	Use requests to talk HTTP via a UNIX domain socket - Python 3.x
             53 KiB 	python3-secretstorage         	Python module for storing secrets - Python 3.x version
            242 KiB 	python3-simplejson            	simple, fast, extensible JSON encoder/decoder for Python 3.x
             58 KiB 	python3-six                   	Python 2 and 3 compatibility library (Python 3 interface)
            173 KiB 	python3-systemd               	Python 3 bindings for systemd
            414 KiB 	python3-urllib3               	HTTP library with thread-safe connection pooling for Python3
            372 KiB 	python3-wadllib               	Python 3 library for navigating WADL files
            509 KiB 	python3.8                     	Interactive high-level object-oriented language (version 3.8)
           5240 KiB 	python3.8-minimal             	Minimal subset of the Python language (version 3.8)
           3109 KiB 	python3.8-vpi2                	NVIDIA VPI python 3.8 bindings
            547 KiB 	python3.9                     	Interactive high-level object-oriented language (version 3.9)
           5503 KiB 	python3.9-minimal             	Minimal subset of the Python language (version 3.9)
           3113 KiB 	python3.9-vpi2                	NVIDIA VPI python 3.9 bindings
             79 KiB 	readline-common               	GNU readline and history libraries, common files
            195 KiB 	resolvconf                    	name server information handler
            137 KiB 	rfkill                        	tool for enabling and disabling wireless devices
            672 KiB 	rsync                         	fast, versatile, remote (and local) file-copying tool
           1520 KiB 	rsyslog                       	reliable system and kernel logging daemon
          17761 KiB 	runc                          	Open Container Project - runtime
            328 KiB 	sed                           	GNU stream editor for filtering/transforming text
             62 KiB 	sensible-utils                	Utilities for sensible alternative selection
           2648 KiB 	shared-mime-info              	FreeDesktop.org shared MIME database and spec
            537 KiB 	sound-theme-freedesktop       	freedesktop.org sound theme
           2124 KiB 	sudo                          	Provide limited super user privileges to specific users
          14688 KiB 	systemd                       	system and service manager
            176 KiB 	systemd-sysv                  	system and service manager - SysV links
            234 KiB 	systemd-timesyncd             	minimalistic service to synchronize local time with NTP servers
             62 KiB 	sysvinit-utils                	System-V-like utilities
            880 KiB 	tar                           	GNU version of the tar archiving utility
             11 KiB 	tensorrt                      	Meta package of TensorRT
           6071 KiB 	timgm6mb-soundfont            	TimGM6mb SoundFont from MuseScore 1.3
            112 KiB 	tree                          	displays an indented directory tree, in color
           3935 KiB 	tzdata                        	time zone and daylight-saving time data
            146 KiB 	ubuntu-fan                    	Ubuntu FAN network support enablement
             46 KiB 	ubuntu-keyring                	GnuPG keys of the Ubuntu archive
           5591 KiB 	ubuntu-mono                   	Ubuntu Mono Icon theme
            188 KiB 	ucf                           	Update Configuration File(s): preserve user changes to config files
           9071 KiB 	udev                          	/dev/ and hotplug management daemon
            217 KiB 	uff-converter-tf              	UFF converter for TensorRT package
            158 KiB 	usb-modeswitch                	mode switching tool for controlling "flip flop" USB devices
             97 KiB 	usb-modeswitch-data           	mode switching data for usb-modeswitch
           4181 KiB 	util-linux                    	miscellaneous system utilities
            168 KiB 	uuid-dev                      	Universally Unique ID library - headers and static libraries
           3069 KiB 	vim                           	Vi IMproved - enhanced vi editor
            376 KiB 	vim-common                    	Vi IMproved - Common files
          30766 KiB 	vim-runtime                   	Vi IMproved - Runtime files
          35913 KiB 	vpi2-demos                    	NVIDIA VPI GUI demo applications
            654 KiB 	vpi2-dev                      	NVIDIA VPI C/C++ development library and headers
          15169 KiB 	vpi2-samples                  	NVIDIA VPI command-line sample applications
            913 KiB 	vulkan-tools                  	Miscellaneous Vulkan utilities
              9 KiB 	vulkan-utils                  	transitional package
            964 KiB 	wget                          	retrieves files from the web
             33 KiB 	wireless-regdb                	wireless regulatory database
            287 KiB 	wireless-tools                	Tools for manipulating Linux Wireless Extensions
           3255 KiB 	wpasupplicant                 	client support for WPA and WPA2 (IEEE 802.11i)
           2260 KiB 	x11-apps                      	X applications
            313 KiB 	x11-common                    	X Window System (X.Org) infrastructure
            657 KiB 	x11-utils                     	X11 utilities
            458 KiB 	x11-xkb-utils                 	X11 XKB utilities
            485 KiB 	x11-xserver-utils             	X server utilities
             11 KiB 	x11proto-core-dev             	transitional dummy package
           1654 KiB 	x11proto-dev                  	X11 extension protocols and auxiliary headers
             73 KiB 	xauth                         	X authentication utility
            223 KiB 	xbitmaps                      	Base X bitmaps
           1276 KiB 	xdg-desktop-portal            	desktop integration portal for Flatpak and Snap
            537 KiB 	xdg-user-dirs                 	tool to manage well known user directories
           7166 KiB 	xfonts-base                   	standard fonts for X
            664 KiB 	xfonts-encodings              	Encodings for X.Org fonts
            406 KiB 	xfonts-utils                  	X Window System font utility programs
             57 KiB 	xinit                         	X server initialisation tool
           4020 KiB 	xkb-data                      	X Keyboard Extension (XKB) configuration data
            101 KiB 	xorg-sgml-doctools            	Common tools for building X.Org SGML documentation
            240 KiB 	xserver-common                	common files used by various X servers
            411 KiB 	xserver-xorg                  	X.Org X server
           3858 KiB 	xserver-xorg-core             	Xorg X server - core server
             50 KiB 	xserver-xorg-input-all        	X.Org X server -- input driver metapackage
            102 KiB 	xserver-xorg-input-libinput   	X.Org X server -- libinput input driver
            300 KiB 	xserver-xorg-input-wacom      	X.Org X server -- Wacom input driver
            266 KiB 	xserver-xorg-legacy           	setuid root Xorg server wrapper
             50 KiB 	xserver-xorg-video-all        	X.Org X server -- output driver metapackage
            177 KiB 	xserver-xorg-video-amdgpu     	X.Org X server -- AMDGPU display driver
             45 KiB 	xserver-xorg-video-ati        	X.Org X server -- AMD/ATI display driver wrapper
             46 KiB 	xserver-xorg-video-fbdev      	X.Org X server -- fbdev display driver
            257 KiB 	xserver-xorg-video-nouveau    	X.Org X server -- Nouveau display driver
            560 KiB 	xserver-xorg-video-radeon     	X.Org X server -- AMD/ATI Radeon display driver
             49 KiB 	xserver-xorg-video-vesa       	X.Org X server -- VESA display driver
           2250 KiB 	xterm                         	X terminal emulator
            302 KiB 	xtrans-dev                    	X transport library (development files)
            202 KiB 	xxd                           	tool to make (or reverse) a hex dump
            344 KiB 	xz-utils                      	XZ-format compression utilities
            159 KiB 	zlib1g                        	compression library - runtime
            588 KiB 	zlib1g-dev                    	compression library - development
        ```

    === ":material-numeric-4-box-multiple-outline: JetPack 4.6.x"

        ```

        ```

#### `dpkg-query` sorted by package size 

!!! note "For listing all the installed packages in ascending order sorted by size:"

    ```
    dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | sort -n -t$'\t' -k 1,1
    ```

### `dpkg-query` to list NVIDIA packages

```
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${Maintainer}\n' | grep nvidia 
```

??? info ":material-numeric-5-box-multiple:  Example output of the `dpkg-query` command to list NVIDIA packages on Jetson AGX Orin Developer Kit with JetPack 5.0.2 (Full JetPack components):"

    ```
          7 KiB    cuda-11-4                       cudatools <cudatools@nvidia.com>
      12351 KiB    cuda-cccl-11-4                  cudatools <cudatools@nvidia.com>
          7 KiB    cuda-command-line-tools-11-4    cudatools <cudatools@nvidia.com>
          7 KiB    cuda-compiler-11-4              cudatools <cudatools@nvidia.com>
        731 KiB    cuda-cudart-11-4                cudatools <cudatools@nvidia.com>
       4963 KiB    cuda-cudart-dev-11-4            cudatools <cudatools@nvidia.com>
        279 KiB    cuda-cuobjdump-11-4             cudatools <cudatools@nvidia.com>
      21778 KiB    cuda-cupti-11-4                 cudatools <cudatools@nvidia.com>
       1308 KiB    cuda-cupti-dev-11-4             cudatools <cudatools@nvidia.com>
       1553 KiB    cuda-cuxxfilt-11-4              cudatools <cudatools@nvidia.com>
        378 KiB    cuda-documentation-11-4         cudatools <cudatools@nvidia.com>
        131 KiB    cuda-driver-dev-11-4            cudatools <cudatools@nvidia.com>
      14045 KiB    cuda-gdb-11-4                   cudatools <cudatools@nvidia.com>
          7 KiB    cuda-libraries-11-4             cudatools <cudatools@nvidia.com>
          7 KiB    cuda-libraries-dev-11-4         cudatools <cudatools@nvidia.com>
     100439 KiB    cuda-nvcc-11-4                  cudatools <cudatools@nvidia.com>
      32610 KiB    cuda-nvdisasm-11-4              cudatools <cudatools@nvidia.com>
        559 KiB    cuda-nvml-dev-11-4              cudatools <cudatools@nvidia.com>
        154 KiB    cuda-nvprune-11-4               cudatools <cudatools@nvidia.com>
      46801 KiB    cuda-nvrtc-11-4                 cudatools <cudatools@nvidia.com>
        117 KiB    cuda-nvrtc-dev-11-4             cudatools <cudatools@nvidia.com>
        444 KiB    cuda-nvtx-11-4                  cudatools <cudatools@nvidia.com>
         88 KiB    cuda-profiler-api-11-4          cudatools <cudatools@nvidia.com>
          7 KiB    cuda-runtime-11-4               cudatools <cudatools@nvidia.com>
     161686 KiB    cuda-samples-11-4               cudatools <cudatools@nvidia.com>
      26027 KiB    cuda-sanitizer-11-4             cudatools <cudatools@nvidia.com>
         14 KiB    cuda-toolkit-11-4               cudatools <cudatools@nvidia.com>
         70 KiB    cuda-toolkit-11-4-config-commo  cudatools <cudatools@nvidia.com>
         74 KiB    cuda-toolkit-11-config-common   cudatools <cudatools@nvidia.com>
         74 KiB    cuda-toolkit-config-common      cudatools <cudatools@nvidia.com>
          7 KiB    cuda-tools-11-4                 cudatools <cudatools@nvidia.com>
         10 KiB    cuda-visual-tools-11-4          cudatools <cudatools@nvidia.com>
         81 KiB    graphsurgeon-tf                 cudatools <cudatools@nvidia.com>
         52 KiB    jetson-gpio-common              NVIDIA Corporation <linux-tegra-bugs@nvidia.com>
     527663 KiB    libcublas-11-4                  cudatools <cudatools@nvidia.com>
     699018 KiB    libcublas-dev-11-4              cudatools <cudatools@nvidia.com>
        244 KiB    libcudla-11-4                   cudatools <cudatools@nvidia.com>
        116 KiB    libcudla-dev-11-4               cudatools <cudatools@nvidia.com>
    1347830 KiB    libcudnn8                       cudatools <cudatools@nvidia.com>
    1646629 KiB    libcudnn8-dev                   cudatools <cudatools@nvidia.com>
       2118 KiB    libcudnn8-samples               cudatools <cudatools@nvidia.com>
     171408 KiB    libcufft-11-4                   cudatools <cudatools@nvidia.com>
     393703 KiB    libcufft-dev-11-4               cudatools <cudatools@nvidia.com>
      76039 KiB    libcurand-11-4                  cudatools <cudatools@nvidia.com>
      78070 KiB    libcurand-dev-11-4              cudatools <cudatools@nvidia.com>
     466285 KiB    libcusolver-11-4                cudatools <cudatools@nvidia.com>
     223245 KiB    libcusolver-dev-11-4            cudatools <cudatools@nvidia.com>
     225282 KiB    libcusparse-11-4                cudatools <cudatools@nvidia.com>
     251151 KiB    libcusparse-dev-11-4            cudatools <cudatools@nvidia.com>
     207464 KiB    libnpp-11-4                     cudatools <cudatools@nvidia.com>
     219340 KiB    libnpp-dev-11-4                 cudatools <cudatools@nvidia.com>
         67 KiB    libnvidia-container-tools       NVIDIA CORPORATION <cudatools@nvidia.com>
        163 KiB    libnvidia-container0            NVIDIA CORPORATION <cudatools@nvidia.com>
       3086 KiB    libnvidia-container1            NVIDIA CORPORATION <cudatools@nvidia.com>
        489 KiB    libnvinfer-bin                  cudatools <cudatools@nvidia.com>
     814296 KiB    libnvinfer-dev                  cudatools <cudatools@nvidia.com>
      31479 KiB    libnvinfer-plugin-dev           cudatools <cudatools@nvidia.com>
      27850 KiB    libnvinfer-plugin8              cudatools <cudatools@nvidia.com>
     536945 KiB    libnvinfer-samples              cudatools <cudatools@nvidia.com>
     490082 KiB    libnvinfer8                     cudatools <cudatools@nvidia.com>
       2736 KiB    libnvonnxparsers-dev            cudatools <cudatools@nvidia.com>
       2788 KiB    libnvonnxparsers8               cudatools <cudatools@nvidia.com>
      21048 KiB    libnvparsers-dev                cudatools <cudatools@nvidia.com>
       3482 KiB    libnvparsers8                   cudatools <cudatools@nvidia.com>
     285363 KiB    libnvvpi2                       VPI Support <vpi-support@nvidia.com>
            KiB    nsight-systems-2022.3.3         Feedback <nsight-systems@nvidia.com>
        194 KiB    nvidia-container                NVIDIA Corporation
         21 KiB    nvidia-container-runtime        NVIDIA CORPORATION <cudatools@nvidia.com>
       9361 KiB    nvidia-container-toolkit        NVIDIA CORPORATION <cudatools@nvidia.com>
        224 KiB    nvidia-cuda                     NVIDIA Corporation
        224 KiB    nvidia-cuda-dev                 NVIDIA Corporation
        175 KiB    nvidia-cudnn8                   NVIDIA Corporation
        175 KiB    nvidia-cudnn8-dev               NVIDIA Corporation
         27 KiB    nvidia-docker2                  NVIDIA CORPORATION <cudatools@nvidia.com>
        194 KiB    nvidia-jetpack                  NVIDIA Corporation
        194 KiB    nvidia-jetpack-dev              NVIDIA Corporation
        194 KiB    nvidia-jetpack-runtime          NVIDIA Corporation
     160854 KiB    nvidia-l4t-3d-core              NVIDIA Corporation
         31 KiB    nvidia-l4t-apt-source           NVIDIA Corporation
     198666 KiB    nvidia-l4t-bootloader           NVIDIA Corporation
      20839 KiB    nvidia-l4t-camera               NVIDIA Corporation
       1504 KiB    nvidia-l4t-configs              NVIDIA Corporation
      10422 KiB    nvidia-l4t-core                 NVIDIA Corporation
      22790 KiB    nvidia-l4t-cuda                 NVIDIA Corporation
       4094 KiB    nvidia-l4t-display-kernel       NVIDIA Corporation
      16487 KiB    nvidia-l4t-firmware             NVIDIA Corporation
         77 KiB    nvidia-l4t-gbm                  NVIDIA Corporation
         38 KiB    nvidia-l4t-gputools             NVIDIA Corporation
      69598 KiB    nvidia-l4t-graphics-demos       NVIDIA Corporation
       5135 KiB    nvidia-l4t-gstreamer            NVIDIA Corporation
      16737 KiB    nvidia-l4t-init                 NVIDIA Corporation
      16421 KiB    nvidia-l4t-initrd               NVIDIA Corporation
        134 KiB    nvidia-l4t-jetson-io            NVIDIA Corporation
      93617 KiB    nvidia-l4t-jetson-multimedia-a  NVIDIA Corporation
        159 KiB    nvidia-l4t-jetsonpower-gui-too  NVIDIA Corporation
     237542 KiB    nvidia-l4t-kernel               NVIDIA Corporation
       4772 KiB    nvidia-l4t-kernel-dtbs          NVIDIA Corporation
      70953 KiB    nvidia-l4t-kernel-headers       NVIDIA Corporation
        596 KiB    nvidia-l4t-libvulkan            NVIDIA Corporation
      31183 KiB    nvidia-l4t-multimedia           NVIDIA Corporation
        742 KiB    nvidia-l4t-multimedia-utils     NVIDIA Corporation
         65 KiB    nvidia-l4t-nvfancontrol         NVIDIA Corporation
        205 KiB    nvidia-l4t-nvpmodel             NVIDIA Corporation
         86 KiB    nvidia-l4t-nvpmodel-gui-tools   NVIDIA Corporation
        999 KiB    nvidia-l4t-nvsci                NVIDIA Corporation
        110 KiB    nvidia-l4t-oem-config           NVIDIA Corporation
        235 KiB    nvidia-l4t-openwfd              NVIDIA Corporation
       8212 KiB    nvidia-l4t-optee                NVIDIA Corporation
         85 KiB    nvidia-l4t-pva                  NVIDIA Corporation
       3336 KiB    nvidia-l4t-tools                NVIDIA Corporation
       6922 KiB    nvidia-l4t-vulkan-sc            NVIDIA Corporation
      19617 KiB    nvidia-l4t-vulkan-sc-dev        NVIDIA Corporation
      14000 KiB    nvidia-l4t-vulkan-sc-samples    NVIDIA Corporation
      83151 KiB    nvidia-l4t-vulkan-sc-sdk        NVIDIA Corporation
         77 KiB    nvidia-l4t-wayland              NVIDIA Corporation
       4749 KiB    nvidia-l4t-weston               NVIDIA Corporation
        226 KiB    nvidia-l4t-x11                  NVIDIA Corporation
        602 KiB    nvidia-l4t-xusb-firmware        NVIDIA Corporation
        194 KiB    nvidia-nsight-sys               NVIDIA Corporation
        194 KiB    nvidia-opencv                   NVIDIA Corporation
        194 KiB    nvidia-opencv-dev               NVIDIA Corporation
        200 KiB    nvidia-tensorrt                 NVIDIA Corporation
        200 KiB    nvidia-tensorrt-dev             NVIDIA Corporation
        194 KiB    nvidia-vpi                      NVIDIA Corporation
        194 KiB    nvidia-vpi-dev                  NVIDIA Corporation
        105 KiB    python-jetson-gpio              NVIDIA Corporation <linux-tegra-bugs@nvidia.com>
        105 KiB    python3-jetson-gpio             NVIDIA Corporation <linux-tegra-bugs@nvidia.com>
       3228 KiB    python3-libnvinfer              cudatools <cudatools@nvidia.com>
         10 KiB    python3-libnvinfer-dev          cudatools <cudatools@nvidia.com>
       3157 KiB    python3.8-vpi2                  VPI Support <vpi-support@nvidia.com>
       3161 KiB    python3.9-vpi2                  VPI Support <vpi-support@nvidia.com>
         11 KiB    tensorrt                        cudatools <cudatools@nvidia.com>
        217 KiB    uff-converter-tf                cudatools <cudatools@nvidia.com>
      35917 KiB    vpi2-demos                      VPI Support <vpi-support@nvidia.com>
        679 KiB    vpi2-dev                        VPI Support <vpi-support@nvidia.com>
      15170 KiB    vpi2-samples                    VPI Support <vpi-support@nvidia.com>
    ```

#### Save in CSV

!!! note "For saving the list of NVIDIA packages in CSV format file"

    ```
    dpkg-query -Wf '${Installed-Size;8} KiB,\t${Package;-30},\t${Maintainer},\t${Depends},\t${Pre-depends}\n' | grep nvidia > dpkg_nvidia_packages.csv 
    ```

## Understanding Package Dependencies

### Generating Dependency Graph

```
sudo apt-get install debtree
debtree --max-depth=3 --no-conflicts nvidia-jetpack  | dot -Tpng >dpkg_nvidia-jetpack.png
```

??? info "Example Output of `debtree nvidia-jetpack` on JetPack 6.x, 5.x and 4.x"

    === ":material-numeric-6-box: JetPack 6.0 GA"

         > Click to enlarge

        [![](./images/dpkg_nvidia-jetpack-60.png)](./images/dpkg_nvidia-jetpack-60.png)

    === ":material-numeric-5-box-multiple: JetPack 5.0.2"

         > Click to enlarge

        [![](./images/dpkg_nvidia-jetpack-502.png)](./images/dpkg_nvidia-jetpack-502.png)

    === ":material-numeric-4-box-multiple-outline: R32.7.1 (JetPack 4.6.1)"

        > Click to enlarge

        [![](./images/dpkg_nvidia-jetpack_jp462_no-conflicts.png)](./images/dpkg_nvidia-jetpack_jp462_no-conflicts.png)



### Find the Dependent Package

```
apt-cache depends ${YOUR_PACKAGE}
```

??? info ":material-numeric-4-box-multiple-outline:  Example on JetPack 4.6.1"

    ```
    jetson@xnx6-jp461:~$ apt-cache depends cuda-toolkit-10-2
    cuda-toolkit-10-2
    Depends: cuda-compiler-10-2
    Depends: cuda-libraries-10-2
    Depends: cuda-libraries-dev-10-2
    Depends: cuda-tools-10-2
    Depends: cuda-documentation-10-2
    Depends: cuda-nvml-dev-10-2
    Depends: cuda-samples-10-2
    ```

### Find the Packages being Dependent

```
apt-cache rdepends ${YOUR_PACKAGE}
```

??? info ":material-numeric-5-box-multiple:  Example on JetPack 5.0.2"

    ```
    jetson@jao-jp502:~$ apt-cache rdepends cuda-samples-11-4 
    cuda-samples-11-4
    Reverse Depends:
    cuda-toolkit-11-4
    ```

### Inspect a Package

```
apt-cache --no-all-versions show ${YOUR_PACKAGE}
```

??? info "Example Output of `apt-cache show` for `nsight-systems` on JetPack 5.0.2"

    ```
    jetson@jao-jp502:~$ apt-cache --no-all-versions show nsight-systems-2022.3.3 
    Package: nsight-systems-2022.3.3
    Version: 2022.3.3.18-4d5367b
    Depends: libc6, libglib2.0-0, libtinfo5, libxcb-xinerama0, libxcb-icccm4, libxcb-image0, libxcb-keysyms1,     libxcb-randr0, libxcb-render-util0, libxcb-xfixes0, libxcb-shape0, libxkbcommon-x11-0, libxcb-xinput0
    Provides: nsight-systems
    Architecture: arm64
    Maintainer: Feedback <nsight-systems@nvidia.com>
    Priority: optional
    Section: devel
    Filename: pool/main/n/nsight-systems-2022.3.3/nsight-systems-2022.3.3_2022.3.3.18-4d5367b_arm64.deb
    Size: 316969792
    SHA256: 5381a6bfa018b65cb37f2da87f12c9060ea9f1c80be1716a50ab64057e1308be
    SHA1: c503e2723a1a463a707addf46e594cdbee01907a
    MD5sum: 41bd5dfd6bd00ed91ec73dc33b25a9cc
    Description: Nsight Systems is a statistical sampling profiler with tracing features.
    It is designed to work with devices and devkits based on
    NVIDIA Tegra SoCs (system-on-chip) or systems
    based on the x86_64 processor architecture that
    also include NVIDIA GPU(s).
    Description-md5: 05572d17c488868adaaffd1ce748ce4c
    ```

### Find what files a package installed

```
dpkg-query -L ${YOUR_PACKAGE}
```

??? info "Example Output of `dpkg-query -L` on JetPack 4.6.2"
    ```
    $ dpkg-query -L libcufft-10-2
    /.
    /usr
    /usr/local
    /usr/local/cuda-10.2
    /usr/local/cuda-10.2/targets
    /usr/local/cuda-10.2/targets/aarch64-linux
    /usr/local/cuda-10.2/targets/aarch64-linux/lib
    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft.so.10.1.2.300
    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufftw.so.10.1.2.300
    /usr/share
    /usr/share/doc
    /usr/share/doc/libcufft-10-2
    /usr/share/doc/libcufft-10-2/changelog.Debian.gz
    /usr/share/doc/libcufft-10-2/copyright
    /usr/local/cuda-10.2/lib64
    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft.so.10
    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufftw.so.10
    ```

### Find the package a file belongs to

```
dpkg-query -S ${YOUR_FILE}
```

??? info "Example Output of `dpkg -S` on JetPack 4.6.2"
    ```
    $dpkg -S /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft_static_nocallback.a
    libcufft-dev-10-2: /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft_static_nocallback.a
    ```



## Misc Tips

### Identifying L4T version on the system

```
cat /etc/nv_tegra_release 
```

!!! info "Content of `/etc/nv_tegra_release` on JetPack 6.x, 5.x and 4.x"

    === ":material-numeric-6-box: JetPack 6.0 GA"

        ```
        jetson@jao-jp60:~$ cat /etc/nv_tegra_release 
        # R36 (release), REVISION: 3.0, GCID: 36191598, BOARD: generic, EABI: aarch64, DATE: Mon May  6 17:34:21 UTC 2024
        # KERNEL_VARIANT: oot
        TARGET_USERSPACE_LIB_DIR=nvidia
        TARGET_USERSPACE_LIB_DIR_PATH=usr/lib/aarch64-linux-gnu/nvidia
        ```

    === ":material-numeric-5-box-multiple: JetPack 5.0.2"

        ```
        jetson@jao-jp502:~$ cat /etc/nv_tegra_release 
        # R35 (release), REVISION: 1.0, GCID: 31346300, BOARD: t186ref, EABI: aarch64, DATE: Thu Aug 25 18:41:45 UTC 2022
        ```

    === ":material-numeric-4-box-multiple-outline: R32.7.1 (JetPack 4.6.1)"

        ```
        cat /etc/nv_tegra_release 
        # R32 (release), REVISION: 7.1, GCID: 29818004, BOARD: t186ref, EABI: aarch64, DATE: Sat Feb 19 17:07:00 UTC 2022
        ```

### L4T version to JetPack version

See [https://developer.nvidia.com/embedded/jetson-linux-archive](https://developer.nvidia.com/embedded/jetson-linux-archive).

[![](./images/screenshot_L4T-Archieve-page_r35.1.png)](https://developer.nvidia.com/embedded/jetson-linux-archive)