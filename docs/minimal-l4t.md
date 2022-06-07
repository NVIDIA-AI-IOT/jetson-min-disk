# Option: Starting with Minimal L4T

If you are using an x86-64 Linux host PC to flash your Jetson, you can create a minimal configuration RootFS and flash that image onto Jetson.

In the diagram shown earlier (“[Varying degree of minimized configurations](./overview_minimizing_steps.md#varying-degree-of-minimized-configurations)”), this correspond to using L4T Flash Tool to flash Minimal L4T BSP to directly get to Configuration `[b]`.

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQSLro30qGYa6ZJj-yHZC7Qj0G3Ti60tVlDyf7odtnF4IlYANN3e9tIdexgYdLDxbqRaJ96PYq_oq00/pub?w=1481&amp;h=684" alt="Diagram to show different minimal configurations">

## How to flash minimal L4T BSP

For setting up the flashing tool on a host PC, you can either download individual tar files from the NVIDIA website, or use NVIDIA SDK Manager to download and set up the flashing tool.

## Set up flashing tool using tar files

If you opt to take the first route, go to the [L4T archive page](https://developer.nvidia.com/embedded/jetson-linux-archive), click on the L4T version that you want to use and jump to the individual L4T version page. 

Download both **L4T Driver Package (BSP)** and **Sample Root Filesystem** on your host PC.

??? info "Example for Downloading R32.7.1 (JetPack 4.6.1) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
    wget https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/jetson_linux_r32.7.1_aarch64.tbz2
    wget https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/tegra_linux_sample-root-filesystem_r32.7.1_aarch64.tbz2
    L4T_RELEASE_PACKAGE=jetson_linux_r32.7.1_aarch64.tbz2
    SAMPLE_FS_PACKAGE=Tegra_Linux_Sample-Root-Filesystem_R32.7.1_aarch64.tbz2
    tar xf ${L4T_RELEASE_PACKAGE}
    cd Linux_for_Tegra/rootfs/
    sudo tar xpf ../../${SAMPLE_FS_PACKAGE}
    cd ..
    sudo ./apply_binaries.sh
    ```

## Set up flashing tool using SDK Manager

You can also use NVIDIA SDK Manager to download the flashing tool.
Following "[Download and Run SDK Manager](https://docs.nvidia.com/sdk-manager/download-run-sdkm/index.html#download-run)" page and "[Install Jetson Software with SDK Manager](https://docs.nvidia.com/sdk-manager/install-with-sdkm-jetson/index.html#install-with-sdkm-jetson)" page of SDK Manager Documentation, go through the flashing process until "**SDK Manager is about to flash your Jetson ~~~**" dialog comes up. Click the "**Skip**" button and exit from SDK Manager.

You should find the `Linux_for_Tegra` directory set up in the following directory.

!!! info "Example of running SDK Manager to downloading R32.7.1 (JetPack 4.6.1) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
     ~/nvidia/nvidia_sdk/JetPack_4.6.1_Linux_JETSON_AGX_XAVIER_TARGETS$ ls
    Linux_for_Tegra
    ```

## `nv_build_samplefs.sh` to create RootFS

Regardless of whether you set up the flashing tool (`Linux_for_Tegra` directory) using tar files or using SDK Manager, it comes with a pre-build sample root file system.

NVIDIA also provides a tool to generate a roof file system, that is `nv_build_sample_fs.sh`.

## Create minimal RootFS and flash 

### For L4T r32.7.1 / JetPack 4.6.1 or earlier

Jetson Linux r32.7.1 or earlier has nv_build_samplefs.sh that takes the text file `nvubuntu-bionic-aarch64-packages` that lists out all the packages to be installed in the rootfs. 

??? info "Example of `nv_build_samplefs.sh` usage for R32.7.1 (JetPack 4.6.1) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
    $ cd Linux_for_Tegra/tools/samplefs/
    $ ls
    nv_build_samplefs.sh  nvubuntu-bionic-aarch64-packages  nvubuntu-bionic-aarch64-samplefs  nvubuntu_samplefs.sh
    $ sudo ./nv_build_samplefs.sh 
    Usage:
    nv_build_samplefs.sh --abi <ABI> --distro <distro> --version <version> [--verbose]
            <ABI>           - The ABI of Linux distro. Such as 'aarch64'
            <distro>        - The Linux distro. Such as 'ubuntu'
            <version>       - The version of Linux distro. Such as 'bionic' for Ubuntu.
    Example:
    nv_build_samplefs.sh --abi aarch64 --distro ubuntu --version bionic

    nv_build_samplefs.sh will download the base image for given Linux distro, install necessary
    packages, and generate samplefs tarball, so an internet connection is required.

    Generated samplefs tarball will be named 'sample_fs.tbz2' and put under the path
    executes this script.
    nv_build_samplefs.sh - cleanup
    ```

To build your own minimal rootfs, you need to edit this packages file. For example, [here](https://gitlab-master.nvidia.com/cyato/jetson-min-disk/-/blob/main/assets/nvubuntu-bionic-minimal-aarch64-packages) is the sample list of packages that would make up a minimal configuration rootfs without Ubuntu desktop GUI for Rel-32.7.

Build your custom RootFS using this custom list, use the generated tar file to set up the RootFS directory inside the Linux_for_Tegra directory.

??? info "Example of building custom RootFS for R32.7.1 (JetPack 4.6.1) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
    $ cd Linux_for_Tegra/tools/samplefs/
    $ mv nvubuntu-bionic-aarch64-packages nvubuntu-bionic-aarch64-packages.orig
    $ mv ~/Downloads/nvubuntu-bionic-minimal-aarch64-packages ./nvubuntu-bionic-aarch64-packages
    $ sudo ./nv_build_samplefs.sh --abi aarch64 --distro ubuntu --version bionic | tee nv_build_samplefs.log
    $ SAMPLE_FS_PACKAGE=$(pwd)/sample_fs.tbz2
    $ cd ../../../
    $ cd Linux_for_Tegra/rootfs/
    $ sudo rm -rf ./*/
    $ sudo tar xpf ${SAMPLE_FS_PACKAGE}
    $ cd ..
    $ sudo ./apply_binaries.sh
    $ cd ..
    ```

Follow this [section](https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3271/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/flashing.html) of L4T Developer Documentation to flash your Jetson, or you can just do this.

### For L4T r34.1.x / JetPack 5.0.x DP

Jetson Linux r34.1 (JetPack 5.0 DP) is based on Ubuntu 20.04, and we have a new `nv_build_samplefs.sh` that can now take `flavor` option for samplefs, such as desktop.

??? info "Example of `nv_build_samplefs.sh` usage for R34.1.x (JetPack 5.0.x DP) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
    $ cd Linux_for_Tegra/tools/samplefs/
    $ ls
    nv_build_samplefs.sh  nvubuntu-focal-aarch64-samplefs  nvubuntu-focal-desktop-aarch64-packages  nvubuntu-focal-minimal-aarch64-packages  nvubuntu_samplefs.sh
    $ sudo ./nv_build_samplefs.sh 
    ERROR: This script can be only run on Ubuntu 20.04 and 18.04
    Usage:
    nv_build_samplefs.sh --abi <ABI> --distro <distro> --flavor <flavor> --version <version> [--verbose]
            <ABI>           - The ABI of Linux distro. Such as 'aarch64'
            <distro>        - The Linux distro. Such as 'ubuntu'
            <flavor>        - The flavor of samplefs. Such as 'desktop'
            <version>       - The version of Linux distro. Such as 'focal' for Ubuntu.
    Example:
    nv_build_samplefs.sh --abi aarch64 --distro ubuntu --flavor desktop --version focal

    nv_build_samplefs.sh will download the base image for given Linux distro, install necessary
    packages, and generate samplefs tarball, so an internet connection is required.

    Generated samplefs tarball will be named 'sample_fs.tbz2' and put under the path
    executes this script.
    nv_build_samplefs.sh - cleanup
    ```

Build the minimal flavor samplefs, use the generated tar file to set up the RootFS directory inside the Linux_for_Tegra directory.

??? info "Example of commands to build `minimal` RootFS for R34.1.x (JetPack 5.0.x DP) on Host PC"

    :material-desktop-tower-monitor:  **Host PC**

    ```
    cd Linux_for_Tegra/tools/samplefs/
    sudo ./nv_build_samplefs.sh --abi aarch64 --distro ubuntu --flavor minimal --version focal| tee nv_build_samplefs.log
    SAMPLE_FS_PACKAGE=$(pwd)/sample_fs.tbz2
    cd ../../../
    cd Linux_for_Tegra/rootfs/
    sudo rm -rf ./*/
    sudo tar xpf ${SAMPLE_FS_PACKAGE}
    cd ..
    sudo ./apply_binaries.sh
    cd ..
    ```

Follow [this section](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/SD/FlashingSupport.html?highlight=flash%20sh#basic-flashing-script-usage) of Jetson Linux Developer Documentation to flash your Jetson, or you can just do this.