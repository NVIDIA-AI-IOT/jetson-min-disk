# Option: Starting with Minimal L4T

If you are using an x86-64 Linux host PC to flash your Jetson, you can create a minimal configuration RootFS and flash that image onto Jetson.

In the diagram shown earlier (“[Varying degree of minimized configurations](./overview_minimizing_steps.md#varying-degree-of-minimized-configurations)”), this correspond to using L4T Flash Tool to flash Minimal L4T BSP to directly get to Configuration `[b]`.

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQSLro30qGYa6ZJj-yHZC7Qj0G3Ti60tVlDyf7odtnF4IlYANN3e9tIdexgYdLDxbqRaJ96PYq_oq00/pub?w=1481&amp;h=684" alt="Diagram to show different minimal configurations">

## How to flash minimal L4T BSP

For setting up the flashing tool on a host PC, you can either download individual tar files from the NVIDIA website, or use NVIDIA SDK Manager to download and set up the flashing tool.

### Using tar files

If you opt to take the first route, go to the [L4T archive page](https://developer.nvidia.com/embedded/jetson-linux-archive), click on the L4T version that you want to use and jump to the individual L4T version page. 

Download both **L4T Driver Package (BSP)** and **Sample Root Filesystem** on your host PC.

!!! note "Example for downloading and setting up L4T Flash Tool on Host PC"

	===  ":material-numeric-4-box-multiple-outline: r32.7.1 (JetPack 4.6.1)"

		:material-desktop-tower-monitor:  **Host PC**
		```
		wget https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/jetson_linux_r32.7.1_aarch64.tbz2
		wget https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t186/tegra_linux_sample-root-filesystem_r32.7.1_aarch64.tbz2
		L4T_RELEASE_PACKAGE=jetson_linux_r32.7.1_aarch64.tbz2
		SAMPLE_FS_PACKAGE=tegra_linux_sample-root-filesystem_r32.7.1_aarch64.tbz2
		tar xf ${L4T_RELEASE_PACKAGE}
		cd Linux_for_Tegra/rootfs/
		sudo tar xpf ../../${SAMPLE_FS_PACKAGE}
		cd ..
		sudo ./apply_binaries.sh
		```

	=== ":material-numeric-5-box-multiple: JetPack 5.0.1 DP"

		:material-desktop-tower-monitor:  **Host PC**
		```
		wget https://developer.nvidia.com/embedded/l4t/r34_release_v1.1/release/jetson_linux_r34.1.1_aarch64.tbz2
		wget https://developer.nvidia.com/embedded/l4t/r34_release_v1.1/release/tegra_linux_sample-root-filesystem_r34.1.1_aarch64.tbz2
		L4T_RELEASE_PACKAGE=jetson_linux_r34.1.1_aarch64.tbz2
		SAMPLE_FS_PACKAGE=tegra_linux_sample-root-filesystem_r34.1.1_aarch64.tbz2
		tar xf ${L4T_RELEASE_PACKAGE}
		cd Linux_for_Tegra/rootfs/
		sudo tar xpf ../../${SAMPLE_FS_PACKAGE}
		cd ..
		sudo ./apply_binaries.sh
		```

### Using SDK Manager

You can also use NVIDIA SDK Manager to download the flashing tool.
Following "[Download and Run SDK Manager](https://docs.nvidia.com/sdk-manager/download-run-sdkm/index.html#download-run)" page and "[Install Jetson Software with SDK Manager](https://docs.nvidia.com/sdk-manager/install-with-sdkm-jetson/index.html#install-with-sdkm-jetson)" page of SDK Manager Documentation, go through the flashing process until "**SDK Manager is about to flash your Jetson ~~~**" dialog comes up. Click the "**Skip**" button and exit from SDK Manager.

You should find the `Linux_for_Tegra` directory set up in the following directory.

!!! note "Example of using SDK Manager to find L4T Flashing Tool for Jetson AGX Xavier"

	===  ":material-numeric-4-box-multiple-outline: r32.7.1 (JetPack 4.6.1)"

		:material-desktop-tower-monitor:  **Host PC** 
		```
		cd ~/nvidia/nvidia_sdk/JetPack_4.6.1_Linux_JETSON_AGX_XAVIER_TARGETS
		cd Linux_for_Tegra
		```

	=== ":material-numeric-5-box-multiple:  r34.1.1 (JetPack 5.0.1 DP)"

		:material-desktop-tower-monitor:  **Host PC**
		```
		cd ~/nvidia/nvidia_sdk/JetPack_5.0.1_DP_Linux_JETSON_AGX_XAVIER_TARGETS
		cd Linux_for_Tegra
		```

## Create custom RootFS image using `nv_build_samplefs.sh`

Regardless of whether you set up the flashing tool (`Linux_for_Tegra` directory) using tar files or using SDK Manager, L4T Flash Tool comes with a pre-build sample root file system.

NVIDIA also provides a tool to generate a roof file system image, that is `nv_build_samplefs.sh`.

### Usage of `nv_build_samplefs.sh`

??? info "`nv_build_samplefs.sh` usage : r32.x vs r34.x"

	===  ":material-numeric-4-box-multiple-outline: r32.7.1 (JetPack 4.6.1)"

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

	=== ":material-numeric-5-box-multiple: r34.1.1 (JetPack 5.0.1 DP)"

		:material-desktop-tower-monitor:  **Host PC**

		```
		$ cd Linux_for_Tegra/tools/samplefs/
		$ ls
		nv_build_samplefs.sh  nvubuntu-focal-aarch64-samplefs  nvubuntu-focal-desktop-aarch64-packages  nvubuntu-focal-minimal-aarch64-packages  nvubuntu_samplefs.sh
		$ sudo ./nv_build_samplefs.sh 
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

### Customize RootFS composition/flavor

As seen in above usage, `nv_build_samplefs.sh` has a slight difference;

* **r32.x**: You need to edit `nvubuntu-bionic-aarch64-packages`
* **r34.x**: You can use custom package list with `--flavor` option

L4T (Jetson Linux) 32.7.2 (for JetPack 4.6.2) or earlier has a version of `nv_build_samplefs.sh` that takes the text file `nvubuntu-bionic-aarch64-packages` that lists out the public Debian packages to be installed in the rootfs. 

You can edit this package file to build your own minimal rootfs image. For example, [here](https://github.com/NVIDIA-AI-IOT/jetson-min-disk/blob/main/assets/nvubuntu-bionic-minimal-aarch64-packages) is an example list of packages that would generate a minimal configuration rootfs image without Ubuntu desktop GUI for Rel-32.7.

L4T (Jetson Linux) 34.1 (for JetPack 5.0 DP) is based on Ubuntu 20.04, and we have a new version of `nv_build_samplefs.sh` that takes `flavor` option.

You find text files `nvubuntu-focal-desktop-aarch64-packages` and `nvubuntu-focal-minimal-aarch64-packages` in the `samplefs` directory. You can use `--flavor {CUSTOM}` to specify `nvubuntu-focal-{CUSTOM}-aarch64-packages` file.

!!! note "Example commands to create custom composition RootFS image"
	
	===  ":material-numeric-4-box-multiple-outline: r32.7.1 (JetPack 4.6.1)"

		:material-desktop-tower-monitor:  **Host PC**
		```
		cd Linux_for_Tegra/tools/samplefs/
		mv nvubuntu-bionic-aarch64-packages nvubuntu-bionic-aarch64-packages.orig
		mv ~/Downloads/nvubuntu-bionic-minimal-aarch64-packages ./nvubuntu-bionic-aarch64-packages
		sudo ./nv_build_samplefs.sh --abi aarch64 --distro ubuntu --version bionic | tee nv_build_samplefs.log
		SAMPLE_FS_PACKAGE=$(pwd)/sample_fs.tbz2
		cd ../../../
		cd Linux_for_Tegra/rootfs/
		sudo rm -rf ./*/
		sudo tar xpf ${SAMPLE_FS_PACKAGE}
		cd ..
		sudo ./apply_binaries.sh
		cd tools/
		sudo ./l4t_create_default_user.sh -u {USERNAME} -p {PASSWORD} -n {HOSTNAME} ‑‑accept-license --autologin
		cd ..
		```

	=== ":material-numeric-5-box-multiple: r34.1.1 (JetPack 5.0.1 DP)"

    	:material-desktop-tower-monitor:  **Host PC**
		```
		cd Linux_for_Tegra/tools/samplefs/
		sudo ./nv_build_samplefs.sh --abi aarch64 --distro ubuntu --flavor minimal --version focal | tee nv_build_samplefs.log
		SAMPLE_FS_PACKAGE=$(pwd)/sample_fs.tbz2
		cd ../../../
		cd Linux_for_Tegra/rootfs/
		sudo rm -rf ./*/
		sudo tar xpf ${SAMPLE_FS_PACKAGE}
		cd ..
		sudo ./apply_binaries.sh
		cd ./tools/
		sudo ./l4t_create_default_user.sh -u {USERNAME} -p {PASSWORD} -n {HOSTNAME} ‑‑accept-license --autologin
		cd ../
		```

### Flash and Boot

??? note "Example command to flash Jetson Xavier NX production module from a Host PC "

    :material-desktop-tower-monitor:  **Host PC**

    ```
    sudo ./flash.sh jetson-xavier-nx-devkit-emmc internal
    ```

See developer guide ([r32.7](https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3271/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/flashing.html), [r34.1](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/SD/FlashingSupport.html?highlight=flash%20sh#basic-flashing-script-usage)) to flash your Jetson.

You can log into the Jetson using the username and password you used when running `l4t_create_default_user.sh` script.

!!! attention 

	Note you may need to manually bring "up" `eth0` if you removed the `network-manager` package in order to enable Ethernet network access.

### Results

You can check the disk usage and the install package size using some of the commands introduced in [Analyze Disk Usage](./analysis.md) page

??? info "Example output of `df` and `dpkg` commands on Jetson"

	===  ":material-numeric-4-box-multiple-outline: r32.7.1 (JetPack 4.6.1)"

    	```
		Filesystem     1K-blocks    Used Available Use% Mounted on
		/dev/mmcblk0p1  14384136 1756760  11876992  13% /
		Filesystem      Size  Used Avail Use% Mounted on
		/dev/mmcblk0p1   14G  1.7G   12G  13% /
		613
			 624 KiB 	adduser                       	add and remove users and groups
			5399 KiB 	adwaita-icon-theme            	default icon theme of GNOME (small subset)
			2240 KiB 	alsa-utils                    	Utilities for configuring and using ALSA
			 792 KiB 	apport                        	automatically generate crash reports for debugging
			  75 KiB 	apport-symptoms               	symptom scripts for apport
			3891 KiB 	apt                           	commandline package manager
			 276 KiB 	at-spi2-core                  	Assistive Technology Service Provider Interface (dbus core)
			 387 KiB 	base-files                    	Debian base system miscellaneous files
			 228 KiB 	base-passwd                   	Debian base system master password and group files
			1528 KiB 	bash                          	GNU Bourne Again SHell
			 214 KiB 	bc                            	GNU bc arbitrary precision calculator language
			  99 KiB 	bridge-utils                  	Utilities for configuring the Linux Ethernet bridge
			 248 KiB 	bsdutils                      	basic utilities from 4.4BSD-Lite
			 174 KiB 	bzip2                         	high-quality block-sorting file compressor - utilities
			 374 KiB 	ca-certificates               	Common CA certificates
			 500 KiB 	can-utils                     	SocketCAN userspace utilities and tools
			 446 KiB 	console-setup                 	console font and keymap setup program
			1229 KiB 	console-setup-linux           	Linux specific part of console-setup
			6052 KiB 	coreutils                     	GNU core utilities
			  64 KiB 	cpp                           	GNU C preprocessor (cpp)
		   17973 KiB 	cpp-7                         	GNU C preprocessor
			 269 KiB 	crda                          	wireless Central Regulatory Domain Agent
			 247 KiB 	cron                          	process scheduling daemon
			 395 KiB 	cryptsetup                    	disk encryption support - startup scripts
			 404 KiB 	cryptsetup-bin                	disk encryption support - command line tools
			 206 KiB 	dash                          	POSIX-compliant shell
			 531 KiB 	dbus                          	simple interprocess messaging system (daemon and utilities)
			  67 KiB 	dconf-gsettings-backend       	simple configuration storage system - GSettings back-end
			  97 KiB 	dconf-service                 	simple configuration storage system - D-Bus service
			 544 KiB 	debconf                       	Debian configuration management system
			 211 KiB 	debianutils                   	Miscellaneous utilities specific to Debian
			 417 KiB 	device-tree-compiler          	Device Tree Compiler for Flat Device Trees
			 420 KiB 	diffutils                     	File comparison utilities
			 772 KiB 	dirmngr                       	GNU privacy guard - network certificate management service
			  17 KiB 	distro-info-data              	information about the distributions' releases (data files)
			 266 KiB 	dmsetup                       	Linux Kernel Device Mapper userspace library
			6656 KiB 	dpkg                          	Debian package management system
			1163 KiB 	e2fsprogs                     	ext2/ext3/ext4 file system utilities
			 363 KiB 	ethtool                       	display or change Ethernet device settings
			 209 KiB 	fakeroot                      	tool for simulating superuser privileges
			 243 KiB 	fbset                         	framebuffer device maintenance program
			 413 KiB 	fdisk                         	collection of partitioning utilities
			  81 KiB 	file                          	Recognize the type of data in a file using "magic" numbers
			 556 KiB 	findutils                     	utilities for finding files--find, xargs
			1665 KiB 	fio                           	flexible I/O tester
			 559 KiB 	fontconfig                    	generic font configuration library - support binaries
			 414 KiB 	fontconfig-config             	generic font configuration library - configuration
			2954 KiB 	fonts-dejavu-core             	Vera font family derivate with additional characters
			 286 KiB 	freeglut3                     	OpenGL Utility Toolkit
		   33224 KiB 	freepats                      	Free patch set for MIDI audio synthesis
			 103 KiB 	fuse                          	Filesystem in Userspace
			 115 KiB 	gcc-7-base                    	GCC, the GNU Compiler Collection (base package)
			 117 KiB 	gcc-8-base                    	GCC, the GNU Compiler Collection (base package)
			1085 KiB 	gdbserver                     	GNU Debugger (remote server)
			 787 KiB 	gdisk                         	GPT fdisk text-mode partitioning tool
			 630 KiB 	gir1.2-glib-2.0               	Introspection data for GLib, GObject, Gio and GModule
			 170 KiB 	glib-networking               	network-related giomodules for GLib
			  44 KiB 	glib-networking-common        	network-related giomodules for GLib - data files
			  37 KiB 	glib-networking-services      	network-related giomodules for GLib - D-Bus services
			 362 KiB 	gnupg                         	GNU privacy guard - a free PGP replacement
			 364 KiB 	gnupg-l10n                    	GNU privacy guard - localization files
			 421 KiB 	gnupg-utils                   	GNU privacy guard - utility programs
			  51 KiB 	gnupg2                        	GNU privacy guard - a free PGP replacement (dummy transitional package)
			1002 KiB 	gpg                           	GNU Privacy Guard -- minimalist public key operations
			 771 KiB 	gpg-agent                     	GNU privacy guard - cryptographic agent
			 227 KiB 	gpg-wks-client                	GNU privacy guard - Web Key Service client
			 210 KiB 	gpg-wks-server                	GNU privacy guard - Web Key Service server
			 352 KiB 	gpgconf                       	GNU privacy guard - core configuration utilities
			 497 KiB 	gpgsm                         	GNU privacy guard - S/MIME version
			 427 KiB 	gpgv                          	GNU privacy guard - signature verification tool
			 480 KiB 	grep                          	GNU grep, egrep and fgrep
			3377 KiB 	groff-base                    	GNU troff text-formatting system (base system components)
			 272 KiB 	gsettings-desktop-schemas     	GSettings desktop-wide schemas
			 194 KiB 	gstreamer1.0-alsa             	GStreamer plugin for ALSA
			 321 KiB 	gstreamer1.0-gl               	GStreamer plugins for GL
			 379 KiB 	gstreamer1.0-libav            	libav plugin for GStreamer
			5845 KiB 	gstreamer1.0-plugins-bad      	GStreamer plugins from the "bad" set
			1843 KiB 	gstreamer1.0-plugins-base     	GStreamer plugins from the "base" set
			5260 KiB 	gstreamer1.0-plugins-good     	GStreamer plugins from the "good" set
			 793 KiB 	gstreamer1.0-plugins-ugly     	GStreamer plugins from the "ugly" set
			1185 KiB 	gstreamer1.0-tools            	Tools for use with GStreamer
			 311 KiB 	gstreamer1.0-x                	GStreamer plugins for X11 and Pango
			 141 KiB 	gtk-update-icon-cache         	icon theme caching utility
			 222 KiB 	gzip                          	GNU compression utilities
			  73 KiB 	haveged                       	Linux entropy source using the HAVEGE algorithm
			 440 KiB 	hicolor-icon-theme            	default fallback theme for FreeDesktop.org icon themes
			  45 KiB 	hostname                      	utility to set/show the host name or domain name
		   20754 KiB 	humanity-icon-theme           	Humanity Icon theme
			 255 KiB 	i2c-tools                     	heterogeneous set of I2C tools for Linux
			 532 KiB 	ibverbs-providers             	User space provider drivers for libibverbs
			 129 KiB 	init-system-helpers           	helper tools for all init systems
			  40 KiB 	iperf3                        	Internet Protocol bandwidth measuring tool
			1972 KiB 	iproute2                      	networking and traffic control tools
			1505 KiB 	iptables                      	administration tools for packet filtering and NAT
			 115 KiB 	iputils-ping                  	Tools to test the reachability of network hosts
			 670 KiB 	isc-dhcp-client               	DHCP client for automatically obtaining an IP address
			 155 KiB 	isc-dhcp-common               	common manpages relevant to all of the isc-dhcp packages
			1340 KiB 	isc-dhcp-server               	ISC DHCP server for automatic IP address assignment
		   18648 KiB 	iso-codes                     	ISO language, territory, currency, script codes and their translations
			 207 KiB 	iw                            	tool for configuring Linux wireless devices
			  52 KiB 	jetson-gpio-common            	Jetson GPIO library package (common files)
			1224 KiB 	kbd                           	Linux console font and keytable utilities
			2558 KiB 	keyboard-configuration        	system-wide keyboard preferences
			 216 KiB 	kmod                          	tools for managing Linux kernel modules
			 136 KiB 	krb5-locales                  	internationalization support for MIT Kerberos
			2264 KiB 	language-pack-en              	translation updates for language English
			3659 KiB 	language-pack-en-base         	translations for language English
			 279 KiB 	less                          	pager program similar to more
			  78 KiB 	liba52-0.7.4                  	library for decoding ATSC A/52 streams
			 138 KiB 	libaa1                        	ASCII art library
			 116 KiB 	libaacs0                      	free-and-libre implementation of AACS
			  57 KiB 	libacl1                       	Access control list shared library
			  30 KiB 	libaio1                       	Linux kernel AIO access library - shared library
			 138 KiB 	libapparmor1                  	changehat AppArmor library
			 474 KiB 	libapt-inst2.0                	deb package format runtime library
			3076 KiB 	libapt-pkg5.0                 	package management runtime library
			  50 KiB 	libargon2-0                   	memory-hard hashing function - runtime library
			 672 KiB 	libasn1-8-heimdal             	Heimdal Kerberos - ASN.1 library
			1148 KiB 	libasound2                    	shared library for ALSA applications
			 691 KiB 	libasound2-data               	Configuration files and profiles for ALSA drivers
			 167 KiB 	libass9                       	library for SSA/ASS subtitles rendering
			  87 KiB 	libassuan0                    	IPC library for the GnuPG components
			  39 KiB 	libasyncns0                   	Asynchronous name service query library
			 212 KiB 	libatk-bridge2.0-0            	AT-SPI 2 toolkit bridge - shared library
			 174 KiB 	libatk1.0-0                   	ATK accessibility toolkit
			  44 KiB 	libatk1.0-data                	Common files for the ATK accessibility toolkit
			 105 KiB 	libatm1                       	shared library for ATM (Asynchronous Transfer Mode)
			 197 KiB 	libatspi2.0-0                 	Assistive Technology Service Provider Interface - shared library
			  36 KiB 	libattr1                      	Extended attribute shared library
			  23 KiB 	libaudit-common               	Dynamic library for security auditing - common files
			 139 KiB 	libaudit1                     	Dynamic library for security auditing
			 116 KiB 	libavahi-client3              	Avahi client library
			 112 KiB 	libavahi-common-data          	Avahi common data files
			 101 KiB 	libavahi-common3              	Avahi common library
			  53 KiB 	libavc1394-0                  	control IEEE 1394 audio/video devices
		   10489 KiB 	libavcodec57                  	FFmpeg library with de/encoders for audio/video codecs - runtime files
			2386 KiB 	libavfilter6                  	FFmpeg library containing media filters - runtime files
			2268 KiB 	libavformat57                 	FFmpeg library with (de)muxers for multimedia containers - runtime files
			 143 KiB 	libavresample3                	FFmpeg compatibility library for resampling - runtime files
			 495 KiB 	libavutil55                   	FFmpeg library with functions for simplifying programming - runtime files
			 106 KiB 	libbdplus0                    	implementation of BD+ for reading Blu-ray Discs
			 370 KiB 	libblkid1                     	block device ID library
			 327 KiB 	libbluray2                    	Blu-ray disc playback support library (shared library)
			  35 KiB 	libbs2b0                      	Bauer stereophonic-to-binaural DSP library
			 162 KiB 	libbsd0                       	utility functions from BSD systems - shared library
			  89 KiB 	libbz2-1.0                    	high-quality block-sorting file compressor library - runtime
			3035 KiB 	libc-bin                      	GNU C Library: Binaries
			9494 KiB 	libc6                         	GNU C Library: Shared libraries
			1013 KiB 	libcaca0                      	colour ASCII art library
			  90 KiB 	libcairo-gobject2             	Cairo 2D vector graphics library (GObject library)
			1103 KiB 	libcairo2                     	Cairo 2D vector graphics library
			  36 KiB 	libcap-ng0                    	An alternate POSIX capabilities library
			  46 KiB 	libcap2                       	POSIX 1003.1e capabilities (library)
			  84 KiB 	libcap2-bin                   	POSIX 1003.1e capabilities (utilities)
			 284 KiB 	libcdio17                     	library to read and control CD-ROM
			 118 KiB 	libcdparanoia0                	audio extraction tool for sampling CDs (library)
			  94 KiB 	libchromaprint1               	audio fingerprint library
			 347 KiB 	libcolord2                    	system service to manage device colour profiles -- runtime
			  87 KiB 	libcom-err2                   	common error description library
			 242 KiB 	libcroco3                     	Cascading Style Sheet (CSS) parsing and manipulation toolkit
			 339 KiB 	libcryptsetup12               	disk encryption support - shared library
			 669 KiB 	libcups2                      	Common UNIX Printing System(tm) - Core library
			 564 KiB 	libcurl3-gnutls               	easy-to-use client-side URL transfer library (GnuTLS flavour)
			  48 KiB 	libdatrie1                    	Double-array trie library
			1489 KiB 	libdb5.3                      	Berkeley v5.3 Database Libraries [runtime]
			 403 KiB 	libdbus-1-3                   	simple interprocess messaging system (library)
			 213 KiB 	libdc1394-22                  	high level programming interface for IEEE 1394 digital cameras
			 195 KiB 	libdca0                       	decoding library for DTS Coherent Acoustics streams
			  86 KiB 	libdconf1                     	simple configuration storage system - runtime library
			 548 KiB 	libde265-0                    	Open H.265 video codec implementation
			  67 KiB 	libdebconfclient0             	Debian Configuration Management System (C-implementation library)
			 482 KiB 	libdevmapper1.02.1            	Linux Kernel Device Mapper userspace library
			1910 KiB 	libdns-export1100             	Exported DNS Shared Library
			  75 KiB 	libdrm-amdgpu1                	Userspace interface to amdgpu-specific kernel DRM services -- runtime
			  41 KiB 	libdrm-common                 	Userspace interface to kernel DRM services -- common files
			  68 KiB 	libdrm-nouveau2               	Userspace interface to nouveau-specific kernel DRM services -- runtime
			  82 KiB 	libdrm-radeon1                	Userspace interface to radeon-specific kernel DRM services -- runtime
			 107 KiB 	libdrm2                       	Userspace interface to kernel DRM services -- runtime
			 135 KiB 	libdv4                        	software library for DV format digital video (runtime lib)
			 101 KiB 	libdvdnav4                    	DVD navigation library
			 136 KiB 	libdvdread4                   	library for reading DVDs
			 210 KiB 	libedit2                      	BSD editline and history libraries
			 314 KiB 	libegl-mesa0                  	free implementation of the EGL API -- Mesa vendor library
			  95 KiB 	libegl1                       	Vendor neutral GL dispatch library -- EGL support
			  78 KiB 	libegl1-mesa                  	transitional dummy package
			 180 KiB 	libelf1                       	library to read and write ELF files
			1055 KiB 	libepoxy0                     	OpenGL function pointer management library
			  25 KiB 	libestr0                      	Helper functions for handling strings (lib)
			 119 KiB 	libevdev2                     	wrapper library for evdev devices
			 416 KiB 	libexpat1                     	XML parsing C library - runtime library
			 411 KiB 	libext2fs2                    	ext2/ext3/ext4 file system libraries
			 470 KiB 	libfaad2                      	freeware Advanced Audio Decoder - runtime files
			 134 KiB 	libfakechroot                 	gives a fake chroot environment - runtime
			 141 KiB 	libfakeroot                   	tool for simulating superuser privileges - shared libraries
			  57 KiB 	libfastjson4                  	fast json library for C
			 479 KiB 	libfdisk1                     	fdisk partitioning library
			  51 KiB 	libffi6                       	Foreign Function Interface library runtime
			 693 KiB 	libfftw3-double3              	Library for computing Fast Fourier Transforms - Double precision
			1149 KiB 	libfftw3-single3              	Library for computing Fast Fourier Transforms - Single precision
			 372 KiB 	libflac8                      	Free Lossless Audio Codec - runtime C library
		   26585 KiB 	libflite1                     	Small run-time speech synthesis engine - shared libraries
			 360 KiB 	libfluidsynth1                	Real-time MIDI software synthesizer (runtime library)
			 533 KiB 	libfontconfig1                	generic font configuration library - runtime
			  43 KiB 	libfontenc1                   	X11 font encoding library
			 806 KiB 	libfreetype6                  	FreeType 2 font engine, shared library files
			 117 KiB 	libfribidi0                   	Free Implementation of the Unicode BiDi algorithm
			 282 KiB 	libfuse2                      	Filesystem in Userspace (library)
			 143 KiB 	libgbm1                       	generic buffer management API -- runtime
			  95 KiB 	libgcc1                       	GCC support library
			 763 KiB 	libgcrypt20                   	LGPL Crypto library - runtime library
			  34 KiB 	libgdbm-compat4               	GNU dbm database routines (legacy support runtime version) 
			  72 KiB 	libgdbm5                      	GNU dbm database routines (runtime version) 
			 491 KiB 	libgdk-pixbuf2.0-0            	GDK Pixbuf library
			  37 KiB 	libgdk-pixbuf2.0-bin          	GDK Pixbuf library (thumbnailer)
			  48 KiB 	libgdk-pixbuf2.0-common       	GDK Pixbuf library - data files
			 219 KiB 	libgirepository-1.0-1         	Library for handling GObject introspection data (runtime library)
			1067 KiB 	libgl1                        	Vendor neutral GL dispatch library -- legacy GL support
		  524642 KiB 	libgl1-mesa-dri               	free implementation of the OpenGL API -- DRI modules
			  78 KiB 	libgl1-mesa-glx               	transitional dummy package
			 337 KiB 	libglapi-mesa                 	free implementation of the GL API -- shared library
			 160 KiB 	libgles1                      	Vendor neutral GL dispatch library -- GLESv1 support
			 185 KiB 	libgles2                      	Vendor neutral GL dispatch library -- GLESv2 support
			3348 KiB 	libglib2.0-0                  	GLib library of C routines
			  88 KiB 	libglib2.0-data               	Common files for GLib library
			 411 KiB 	libglu1-mesa                  	Mesa OpenGL utility library (GLU)
			  63 KiB 	libglvnd-core-dev             	Vendor neutral GL dispatch library -- core development files
			  25 KiB 	libglvnd-dev                  	Vendor neutral GL dispatch library -- development files
			1032 KiB 	libglvnd0                     	Vendor neutral GL dispatch library
			 540 KiB 	libglx-mesa0                  	free implementation of the OpenGL API -- GLX vendor library
			  86 KiB 	libglx0                       	Vendor neutral GL dispatch library -- GLX support
			 301 KiB 	libgme0                       	Playback library for video game music files - shared library
			 478 KiB 	libgmp10                      	Multiprecision arithmetic library
			1632 KiB 	libgnutls30                   	GNU TLS library - main runtime library
			 203 KiB 	libgomp1                      	GCC OpenMP (GOMP) support library
			 152 KiB 	libgpg-error0                 	library for common error values and messages in GnuPG components
			  59 KiB 	libgpm2                       	General Purpose Mouse - shared library
			 236 KiB 	libgraphene-1.0-0             	library of graphic data types
			 156 KiB 	libgraphite2-3                	Font rendering engine for Complex Scripts -- library
			  60 KiB 	libgsm1                       	Shared libraries for GSM speech compressor
			 383 KiB 	libgssapi-krb5-2              	MIT Kerberos runtime libraries - krb5 GSS-API Mechanism
			 276 KiB 	libgssapi3-heimdal            	Heimdal Kerberos - GSSAPI support library
			  87 KiB 	libgssdp-1.0-3                	GObject-based library for SSDP
			 485 KiB 	libgstreamer-gl1.0-0          	GStreamer GL libraries
			 978 KiB 	libgstreamer-plugins-bad1.0-0 	GStreamer libraries from the "bad" set
			2136 KiB 	libgstreamer-plugins-base1.0-0	GStreamer libraries from the "base" set
			 190 KiB 	libgstreamer-plugins-good1.0-0	GStreamer development files for libraries from the "good" set
			3500 KiB 	libgstreamer1.0-0             	Core GStreamer libraries and elements
			8034 KiB 	libgtk-3-0                    	GTK+ graphical user interface library
			 278 KiB 	libgtk-3-bin                  	programs for the GTK+ graphical user interface library
			 408 KiB 	libgtk-3-common               	common files for the GTK+ graphical user interface library
			  56 KiB 	libgudev-1.0-0                	GObject-based wrapper library for libudev
			 228 KiB 	libgupnp-1.0-4                	GObject-based library for UPnP
			  47 KiB 	libgupnp-igd-1.0-4            	library to handle UPnP IGD port mapping
			 606 KiB 	libharfbuzz0b                 	OpenType text shaping engine (shared library)
			 125 KiB 	libhavege1                    	entropy source using the HAVEGE algorithm - shared library
			 242 KiB 	libhcrypto4-heimdal           	Heimdal Kerberos - crypto library
			  96 KiB 	libheimbase1-heimdal          	Heimdal Kerberos - Base library
			  77 KiB 	libheimntlm0-heimdal          	Heimdal Kerberos - NTLM support library
			 220 KiB 	libhogweed4                   	low level cryptographic library (public-key cryptos)
			 316 KiB 	libhx509-5-heimdal            	Heimdal Kerberos - X509 support library
			  27 KiB 	libi2c0                       	userspace I2C programming library
			 128 KiB 	libibverbs1                   	Library for direct userspace use of RDMA (InfiniBand/iWARP)
			 100 KiB 	libice6                       	X11 Inter-Client Exchange library
		   31181 KiB 	libicu60                      	International Components for Unicode
			 235 KiB 	libidn11                      	GNU Libidn library, implementation of IETF IDN specifications
			 142 KiB 	libidn2-0                     	Internationalized domain names (IDNA2008/TR46) library
			  69 KiB 	libiec61883-0                 	partial implementation of IEC 61883 (shared lib)
			 560 KiB 	libilmbase12                  	several utility libraries from ILM used by OpenEXR
			  50 KiB 	libinput-bin                  	input device management and event handling library - udev quirks
			 227 KiB 	libinput10                    	input device management and event handling library - shared library
			  77 KiB 	libip4tc0                     	netfilter libip4tc library
			  77 KiB 	libip6tc0                     	netfilter libip6tc library
			 140 KiB 	libiperf0                     	Internet Protocol bandwidth measuring tool (runtime files)
			  55 KiB 	libiptc0                      	netfilter libiptc library
			  85 KiB 	libirs-export160              	Exported IRS Shared Library
			 424 KiB 	libisc-export169              	Exported ISC Shared Library
			 205 KiB 	libisccfg-export160           	Exported ISC CFG Shared Library
			1491 KiB 	libisl19                      	manipulating sets and relations of integer points bounded by linear constraints
			  56 KiB 	libiw30                       	Wireless tools - library
			1113 KiB 	libjack-jackd2-0              	JACK Audio Connection Kit (libraries)
			  69 KiB 	libjbig0                      	JBIGkit libraries
			 262 KiB 	libjpeg-turbo8                	IJG JPEG compliant runtime library.
			  26 KiB 	libjpeg8                      	Independent JPEG Group's JPEG runtime library (dependency package)
			  62 KiB 	libjson-c3                    	JSON manipulation library - shared library
			 170 KiB 	libjson-glib-1.0-0            	GLib JSON manipulation library
			  40 KiB 	libjson-glib-1.0-common       	GLib JSON manipulation library (common files)
			 292 KiB 	libk5crypto3                  	MIT Kerberos runtime libraries - Crypto Library
			  88 KiB 	libkate1                      	Codec for karaoke and text encapsulation
			  36 KiB 	libkeyutils1                  	Linux Key Management Utilities (library)
			 107 KiB 	libkmod2                      	libkmod shared library
			 572 KiB 	libkrb5-26-heimdal            	Heimdal Kerberos - libraries
			 922 KiB 	libkrb5-3                     	MIT Kerberos runtime libraries
			 151 KiB 	libkrb5support0               	MIT Kerberos runtime libraries - Support library
			 226 KiB 	libksba8                      	X.509 and CMS support library
			 325 KiB 	liblcms2-2                    	Little CMS 2 color management library
			 459 KiB 	libldap-2.4-2                 	OpenLDAP libraries
			  98 KiB 	libldap-common                	OpenLDAP common files for libraries
			 108 KiB 	liblilv-0-0                   	library for simple use of LV2 plugins
		   63643 KiB 	libllvm10                     	Modular compiler and toolchain technologies, runtime library
		   59650 KiB 	libllvm9                      	Modular compiler and toolchain technologies, runtime library
			  50 KiB 	liblocale-gettext-perl        	module using libc functions for internationalization in Perl
			 413 KiB 	libltdl7                      	System independent dlopen wrapper for GNU libtool
			 131 KiB 	liblz4-1                      	Fast LZ compression algorithm library - runtime
			 314 KiB 	liblzma5                      	XZ-format compression library
			 160 KiB 	liblzo2-2                     	data compression library
			4893 KiB 	libmagic-mgc                  	File type determination library using "magic" numbers (compiled magic file)
			 186 KiB 	libmagic1                     	Recognize the type of data in a file using "magic" numbers - library
			  65 KiB 	libmjpegutils-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
			  74 KiB 	libmms0                       	MMS stream protocol library - shared library
			  42 KiB 	libmnl0                       	minimalistic Netlink communication library
			 295 KiB 	libmodplug1                   	shared libraries for mod music based on ModPlug
			 405 KiB 	libmount1                     	device mounting library
			 285 KiB 	libmp3lame0                   	MP3 encoding library
			 109 KiB 	libmpc3                       	multiple precision complex floating-point library
			  80 KiB 	libmpcdec6                    	MusePack decoder - library
			 215 KiB 	libmpdec2                     	library for decimal floating point arithmetic (runtime library)
			 143 KiB 	libmpeg2-4                    	MPEG1 and MPEG2 video decoder library
			 173 KiB 	libmpeg2encpp-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
			1011 KiB 	libmpfr6                      	multiple precision floating-point computation
			 276 KiB 	libmpg123-0                   	MPEG layer 1/2/3 audio decoder (shared library)
			 129 KiB 	libmplex2-2.1-0               	MJPEG capture/editing/replay and MPEG encoding toolset (library)
			  52 KiB 	libmtdev1                     	Multitouch Protocol Translation Library - shared library
			 100 KiB 	libmysofa0                    	library to read HRTFs stored in the AES69-2015 SOFA format
			 246 KiB 	libncurses5                   	shared libraries for terminal handling
			 302 KiB 	libncursesw5                  	shared libraries for terminal handling (wide character support)
			 109 KiB 	libnetfilter-conntrack3       	Netfilter netlink-conntrack library
			 356 KiB 	libnettle6                    	low level cryptographic library (symmetric and one-way cryptos)
			 176 KiB 	libnewt0.52                   	Not Erik's Windowing Toolkit - text mode windowing with slang
			  60 KiB 	libnfnetlink0                 	Netfilter netlink library
			 181 KiB 	libnghttp2-14                 	library implementing HTTP/2 protocol (shared library)
			 299 KiB 	libnice10                     	ICE library (shared library)
			 160 KiB 	libnl-3-200                   	library for dealing with netlink sockets
			  52 KiB 	libnl-genl-3-200              	library for dealing with netlink sockets - generic netlink
			 455 KiB 	libnl-route-3-200             	library for dealing with netlink sockets - route interface
			 532 KiB 	libnorm1                      	NACK-Oriented Reliable Multicast (NORM) library
			  32 KiB 	libnpth0                      	replacement for GNU Pth using system threads
			 289 KiB 	libnspr4                      	NetScape Portable Runtime Library
			 347 KiB 	libnss-systemd                	nss module providing dynamic user and group name resolution
			3163 KiB 	libnss3                       	Network Security Service libraries
			  73 KiB 	libnuma1                      	Libraries for controlling NUMA policy
			 159 KiB 	libofa0                       	library for acoustic fingerprinting
			  68 KiB 	libogg0                       	Ogg bitstream library
			 153 KiB 	libopenal-data                	Software implementation of the OpenAL audio API (data files)
			 613 KiB 	libopenal1                    	Software implementation of the OpenAL audio API (shared library)
			 179 KiB 	libopencore-amrnb0            	Adaptive Multi Rate speech codec - shared library
			 107 KiB 	libopencore-amrwb0            	Adaptive Multi-Rate - Wideband speech codec - shared library
			2934 KiB 	libopenexr22                  	runtime files for the OpenEXR image library
			 427 KiB 	libopengl0                    	Vendor neutral GL dispatch library -- OpenGL support
			 358 KiB 	libopenjp2-7                  	JPEG 2000 image compression/decompression library
			1491 KiB 	libopenmpt0                   	module music library based on OpenMPT -- shared library
			 262 KiB 	libopus0                      	Opus codec runtime library
			 467 KiB 	liborc-0.4-0                  	Library of Optimized Inner Loops Runtime Compiler
			1067 KiB 	libp11-kit0                   	library for loading and coordinating access to PKCS#11 modules - runtime
			  39 KiB 	libpam-cap                    	POSIX 1003.1e capabilities (PAM module)
			 897 KiB 	libpam-modules                	Pluggable Authentication Modules for PAM
			 280 KiB 	libpam-modules-bin            	Pluggable Authentication Modules for PAM - helper binaries
			 300 KiB 	libpam-runtime                	Runtime support for the PAM library
			 344 KiB 	libpam-systemd                	system and service manager - PAM module
			 208 KiB 	libpam0g                      	Pluggable Authentication Modules library
			 380 KiB 	libpango-1.0-0                	Layout and rendering of internationalized text
			  86 KiB 	libpangocairo-1.0-0           	Layout and rendering of internationalized text
			 116 KiB 	libpangoft2-1.0-0             	Layout and rendering of internationalized text
			 331 KiB 	libparted2                    	disk partition manipulator - shared library
			 280 KiB 	libpcap0.8                    	system interface for user-level packet capture
			  90 KiB 	libpci3                       	Linux PCI Utilities (shared library)
			  53 KiB 	libpciaccess0                 	Generic PCI access library for X
			 601 KiB 	libpcre3                      	Old Perl 5 Compatible Regular Expression Library - runtime files
			  66 KiB 	libpcsclite1                  	Middleware to access a smart card using PC/SC (library)
		   20989 KiB 	libperl5.26                   	shared Perl library
			 297 KiB 	libpgm-5.2-0                  	OpenPGM shared library
			 363 KiB 	libpixman-1-0                 	pixel-manipulation library for X and cairo
			 539 KiB 	libpixman-1-dev               	pixel-manipulation library for X and cairo (development files)
			 291 KiB 	libpng16-16                   	PNG library - runtime (version 1.6)
			  64 KiB 	libpolkit-agent-1-0           	PolicyKit Authentication Agent API
			 119 KiB 	libpolkit-backend-1-0         	PolicyKit backend API
			 130 KiB 	libpolkit-gobject-1-0         	PolicyKit Authorization API
			 112 KiB 	libpopt0                      	lib for parsing cmdline parameters
			 115 KiB 	libpostproc54                 	FFmpeg library for post processing - runtime files
			 113 KiB 	libprocps6                    	library for accessing process information from /proc
			 143 KiB 	libproxy1v5                   	automatic proxy configuration management library (shared)
			  74 KiB 	libpsl5                       	Library for Public Suffix List (shared libraries)
			 859 KiB 	libpulse0                     	PulseAudio client libraries
			  37 KiB 	libpython-stdlib              	interactive high-level object-oriented language (default python version)
			3254 KiB 	libpython2.7                  	Shared Python runtime library (version 2.7)
			2783 KiB 	libpython2.7-minimal          	Minimal subset of the Python language (version 2.7)
			8676 KiB 	libpython2.7-stdlib           	Interactive high-level object-oriented language (standard library, version 2.7)
			  37 KiB 	libpython3-stdlib             	interactive high-level object-oriented language (default python3 version)
			4663 KiB 	libpython3.6                  	Shared Python runtime library (version 3.6)
			3813 KiB 	libpython3.6-minimal          	Minimal subset of the Python language (version 3.6)
			7756 KiB 	libpython3.6-stdlib           	Interactive high-level object-oriented language (standard library, version 3.6)
		   11707 KiB 	librados2                     	RADOS distributed object store client library
			  80 KiB 	libraw1394-11                 	library for direct access to IEEE 1394 bus (aka FireWire)
			3223 KiB 	librbd1                       	RADOS block device client library
			 152 KiB 	librdmacm1                    	Library for managing RDMA connections
			 386 KiB 	libreadline7                  	GNU readline and history libraries, run-time libraries
			 103 KiB 	librest-0.7-0                 	REST service access library
			 125 KiB 	libroken18-heimdal            	Heimdal Kerberos - roken support library
			 223 KiB 	librsvg2-2                    	SAX-based renderer library for SVG files (runtime)
			  39 KiB 	librsvg2-common               	SAX-based renderer library for SVG files (extra runtime)
			 123 KiB 	librtmp1                      	toolkit for RTMP streams (shared library)
			 239 KiB 	librubberband2                	audio time-stretching and pitch-shifting library
			1468 KiB 	libsamplerate0                	Audio sample rate conversion library
			 136 KiB 	libsasl2-2                    	Cyrus SASL - authentication abstraction library
			 207 KiB 	libsasl2-modules              	Cyrus SASL - pluggable authentication modules
			  57 KiB 	libsasl2-modules-db           	Cyrus SASL - pluggable authentication modules (DB)
			  75 KiB 	libsbc1                       	Sub Band CODEC library - runtime
			 131 KiB 	libseccomp2                   	high level interface to Linux seccomp filter
			 173 KiB 	libselinux1                   	SELinux runtime shared libraries
			  29 KiB 	libsemanage-common            	Common files for SELinux policy management libraries
			 256 KiB 	libsemanage1                  	SELinux policy management library
			 106 KiB 	libsensors4                   	library to read temperature/voltage/fan sensors
			 632 KiB 	libsepol1                     	SELinux library for manipulating binary security policies
			  96 KiB 	libserd-0-0                   	lightweight RDF syntax library
			  55 KiB 	libshine3                     	Fixed-point MP3 encoding library - runtime files
			 120 KiB 	libshout3                     	MP3/Ogg Vorbis broadcast streaming library
			 246 KiB 	libsidplay1v5                 	SID (MOS 6581) emulation library
			1555 KiB 	libslang2                     	S-Lang programming library - runtime version
			  67 KiB 	libsm6                        	X11 Session Management library
			 267 KiB 	libsmartcols1                 	smart column output alignment library
			  47 KiB 	libsnappy1v5                  	fast compression/decompression library
			 434 KiB 	libsndfile1                   	Library for reading/writing audio files
			  68 KiB 	libsndio6.1                   	Small audio and MIDI framework from OpenBSD, runtime libraries
			 231 KiB 	libsodium23                   	Network communication, cryptography and signaturing library
			  56 KiB 	libsord-0-0                   	library for storing RDF data in memory
			 126 KiB 	libsoundtouch1                	Sound stretching library
			  35 KiB 	libsoup-gnome2.4-1            	HTTP library implementation in C -- GNOME support library
			1042 KiB 	libsoup2.4-1                  	HTTP library implementation in C -- Shared library
			  56 KiB 	libsox-fmt-alsa               	SoX alsa format I/O library
			 303 KiB 	libsox-fmt-base               	Minimal set of SoX format libraries
			 508 KiB 	libsox3                       	SoX library of audio effects and processing
			 129 KiB 	libsoxr0                      	High quality 1D sample-rate conversion library
			 755 KiB 	libspandsp2                   	Telephony signal processing library
			 101 KiB 	libspeex1                     	The Speex codec runtime library
			1062 KiB 	libsqlite3-0                  	SQLite 3 shared library
			  51 KiB 	libsratom-0-0                 	library for serialising LV2 atoms to/from Turtle
			 145 KiB 	libsrtp2-1                    	Secure RTP (SRTP) and UST Reference Implementations - shared library
			  99 KiB 	libss2                        	command-line interface parsing library
			 468 KiB 	libssh-gcrypt-4               	tiny C SSH library (gcrypt flavor)
			2659 KiB 	libssl1.0.0                   	Secure Sockets Layer toolkit - shared libraries
			3238 KiB 	libssl1.1                     	Secure Sockets Layer toolkit - shared libraries
			2025 KiB 	libstdc++6                    	GNU Standard C++ Library v3
			 155 KiB 	libswresample2                	FFmpeg library for audio resampling, rematrixing etc. - runtime files
			 431 KiB 	libswscale4                   	FFmpeg library for image scaling and various conversions - runtime files
			 597 KiB 	libsystemd0                   	systemd utility library
			  49 KiB 	libtag1v5                     	audio meta-data library
			1124 KiB 	libtag1v5-vanilla             	audio meta-data library - vanilla flavour
			 104 KiB 	libtasn1-6                    	Manage ASN.1 structures (runtime)
			 578 KiB 	libthai-data                  	Data files for Thai language support library
			  85 KiB 	libthai0                      	Thai language support library
			 582 KiB 	libtheora0                    	Theora Video Compression Codec
			 468 KiB 	libtiff5                      	Tag Image File Format (TIFF) library
			 485 KiB 	libtinfo5                     	shared low-level terminfo library for terminal handling
			 124 KiB 	libtwolame0                   	MPEG Audio Layer 2 encoding library
			 220 KiB 	libudev1                      	libudev shared library
			1524 KiB 	libunistring2                 	Unicode string library for C
			 188 KiB 	libunwind8                    	library to determine the call-chain of a program - runtime
			 116 KiB 	libusb-1.0-0                  	userspace USB programming library
			  41 KiB 	libutempter0                  	privileged helper for utmp/wtmp updates (runtime)
			 116 KiB 	libuuid1                      	Universally Unique ID library
			 198 KiB 	libv4l-0                      	Collection of video4linux support libraries
			 251 KiB 	libv4lconvert0                	Video4linux frame format conversion library
			  39 KiB 	libva-drm2                    	Video Acceleration (VA) API for Linux -- DRM runtime
			  47 KiB 	libva-x11-2                   	Video Acceleration (VA) API for Linux -- X11 runtime
			 153 KiB 	libva2                        	Video Acceleration (VA) API for Linux -- runtime
			  98 KiB 	libvdpau1                     	Video Decode and Presentation API for Unix (libraries)
			 324 KiB 	libvisual-0.4-0               	audio visualization framework
			 137 KiB 	libvo-aacenc0                 	VisualOn AAC encoder library
			 128 KiB 	libvo-amrwbenc0               	VisualOn AMR-WB encoder library
			 181 KiB 	libvorbis0a                   	decoder library for Vorbis General Audio Compression Codec
			 658 KiB 	libvorbisenc2                 	encoder library for Vorbis General Audio Compression Codec
			  55 KiB 	libvorbisfile3                	high-level API for Vorbis General Audio Compression Codec
			1668 KiB 	libvpx5                       	VP8 and VP9 video codec (shared library)
			 304 KiB 	libvulkan1                    	Vulkan loader library
			  21 KiB 	libwacom-bin                  	Wacom model feature query library -- binaries
			 574 KiB 	libwacom-common               	Wacom model feature query library (common files)
			  57 KiB 	libwacom2                     	Wacom model feature query library
			 163 KiB 	libwavpack1                   	audio codec (lossy and lossless) - library
			  72 KiB 	libwayland-client0            	wayland compositor infrastructure - client library
			  50 KiB 	libwayland-cursor0            	wayland compositor infrastructure - cursor library
			  25 KiB 	libwayland-egl1               	wayland compositor infrastructure - EGL library
			  91 KiB 	libwayland-server0            	wayland compositor infrastructure - server library
			 302 KiB 	libwebp6                      	Lossy compression of digital photographic images.
			  53 KiB 	libwebpmux3                   	Lossy compression of digital photographic images.
			 607 KiB 	libwebrtc-audio-processing1   	AudioProcessing module from the WebRTC project.
			  29 KiB 	libwildmidi-config            	software MIDI player configuration
			 130 KiB 	libwildmidi2                  	software MIDI player library
			 200 KiB 	libwind0-heimdal              	Heimdal Kerberos - stringprep implementation
			 100 KiB 	libwrap0                      	Wietse Venema's TCP wrappers library
			1237 KiB 	libx11-6                      	X11 client-side library
			1504 KiB 	libx11-data                   	X11 client-side library
			  76 KiB 	libx11-xcb1                   	Xlib/XCB interface library
			1657 KiB 	libx264-152                   	x264 video coding library
			2462 KiB 	libx265-146                   	H.265/HEVC video stream encoder (shared library)
			  26 KiB 	libxau6                       	X11 authorisation library
			 417 KiB 	libxaw7                       	X11 Athena Widget library
			  37 KiB 	libxcb-dri2-0                 	X C Binding, dri2 extension
			  37 KiB 	libxcb-dri3-0                 	X C Binding, dri3 extension
			 125 KiB 	libxcb-glx0                   	X C Binding, glx extension
			  31 KiB 	libxcb-present0               	X C Binding, present extension
			  73 KiB 	libxcb-render0                	X C Binding, render extension
			  36 KiB 	libxcb-shape0                 	X C Binding, shape extension
			  31 KiB 	libxcb-shm0                   	X C Binding, shm extension
			  46 KiB 	libxcb-sync1                  	X C Binding, sync extension
			  51 KiB 	libxcb-xfixes0                	X C Binding, xfixes extension
			 170 KiB 	libxcb1                       	X C Binding
			  27 KiB 	libxcomposite1                	X11 Composite extension library
			  55 KiB 	libxcursor1                   	X cursor management library
			  26 KiB 	libxdamage1                   	X11 damaged region extension library
			  34 KiB 	libxdmcp6                     	X11 Display Manager Control Protocol library
			 113 KiB 	libxext6                      	X11 miscellaneous extension library
			  42 KiB 	libxfixes3                    	X11 miscellaneous 'fixes' extension library
			 184 KiB 	libxfont2                     	X11 font rasterisation library
			 113 KiB 	libxft2                       	FreeType-based font drawing library for X
			  80 KiB 	libxi6                        	X11 Input extension library
			  49 KiB 	libxinerama1                  	X11 Xinerama extension library
			 253 KiB 	libxkbcommon0                 	library interface to the XKB compiler - shared library
			 154 KiB 	libxkbfile1                   	X11 keyboard file manipulation library
			1750 KiB 	libxml2                       	GNOME XML library
			 111 KiB 	libxmu6                       	X11 miscellaneous utility library
			  37 KiB 	libxmuu1                      	X11 miscellaneous micro-utility library
			  77 KiB 	libxpm4                       	X11 pixmap library
			  61 KiB 	libxrandr2                    	X11 RandR extension library
			  56 KiB 	libxrender1                   	X Rendering Extension client library
			  25 KiB 	libxshmfence1                 	X shared memory fences - shared library
			 394 KiB 	libxt6                        	X11 toolkit intrinsics library
			  98 KiB 	libxtables12                  	netfilter xtables library
			  44 KiB 	libxtst6                      	X11 Testing -- Record extension library
			  36 KiB 	libxv1                        	X11 Video extension library
			 424 KiB 	libxvidcore4                  	Open source MPEG-4 video codec (library)
			  59 KiB 	libxxf86dga1                  	X11 Direct Graphics Access extension library
			  54 KiB 	libxxf86vm1                   	X11 XFree86 video mode extension library
			 269 KiB 	libzbar0                      	bar code scanner and decoder (library)
			 641 KiB 	libzmq5                       	lightweight messaging kernel (shared library)
			 435 KiB 	libzstd1                      	fast lossless compression algorithm
			 140 KiB 	libzvbi-common                	Vertical Blanking Interval decoder (VBI) - common files
			 617 KiB 	libzvbi0                      	Vertical Blanking Interval decoder (VBI) - runtime files
		   14132 KiB 	locales                       	GNU C Library: National Language (locale) data [support]
			1204 KiB 	login                         	system login tools
			 116 KiB 	logrotate                     	Log rotation utility
			  58 KiB 	lsb-base                      	Linux Standard Base init script functionality
			  65 KiB 	lsb-release                   	Linux Standard Base version reporting utility
			 180 KiB 	mawk                          	a pattern scanning and text processing language
		   22944 KiB 	mesa-va-drivers               	Mesa VA-API video acceleration drivers
		   31535 KiB 	mesa-vdpau-drivers            	Mesa VDPAU video acceleration drivers
			 111 KiB 	mime-support                  	MIME files 'mime.types' & 'mailcap', and support programs
			 354 KiB 	mount                         	tools for mounting and manipulating filesystems
			 956 KiB 	mtd-utils                     	Memory Technology Device Utilities
			 245 KiB 	multiarch-support             	Transitional package to ensure multiarch compatibility
			 364 KiB 	ncurses-base                  	basic terminal type definitions
			 561 KiB 	ncurses-bin                   	terminal-related programs and man pages
			4143 KiB 	ncurses-term                  	additional terminal type definitions
			 704 KiB 	net-tools                     	NET-3 networking toolkit
			  44 KiB 	netbase                       	Basic TCP/IP networking system
			  13 KiB 	netcat                        	TCP/IP swiss army knife -- transitional package
			 136 KiB 	netcat-traditional            	TCP/IP swiss army knife
			  61 KiB 	networkd-dispatcher           	Dispatcher service for systemd-networkd connection status changes
			 115 KiB 	numactl                       	NUMA scheduling and memory placement tool
		   75465 KiB 	nvidia-l4t-3d-core            	NVIDIA GL EGL Package
			  31 KiB 	nvidia-l4t-apt-source         	NVIDIA L4T apt source list debian package
		  135145 KiB 	nvidia-l4t-bootloader         	NVIDIA Bootloader Package
		   18618 KiB 	nvidia-l4t-camera             	NVIDIA Camera Package
			1510 KiB 	nvidia-l4t-configs            	NVIDIA configs debian package
			7633 KiB 	nvidia-l4t-core               	NVIDIA Core Package
		   15520 KiB 	nvidia-l4t-cuda               	NVIDIA CUDA Package
			5071 KiB 	nvidia-l4t-firmware           	NVIDIA Firmware Package
			  38 KiB 	nvidia-l4t-gputools           	NVIDIA dgpu helper Package
		   69451 KiB 	nvidia-l4t-graphics-demos     	NVIDIA graphics demo applications
			3041 KiB 	nvidia-l4t-gstreamer          	NVIDIA GST Application files
		   16715 KiB 	nvidia-l4t-init               	NVIDIA Init debian package
		   14161 KiB 	nvidia-l4t-initrd             	NVIDIA initrd debian package
			 134 KiB 	nvidia-l4t-jetson-io          	NVIDIA Jetson.IO debian package
		  193926 KiB 	nvidia-l4t-kernel             	NVIDIA Kernel Package
			4208 KiB 	nvidia-l4t-kernel-dtbs        	NVIDIA Kernel DTB Package
		   51712 KiB 	nvidia-l4t-kernel-headers     	NVIDIA Linux Tegra Kernel Headers Package
			 420 KiB 	nvidia-l4t-libvulkan          	NVIDIA Vulkan Loader Package
		   37448 KiB 	nvidia-l4t-multimedia         	NVIDIA Multimedia Package
			  74 KiB 	nvidia-l4t-multimedia-utils   	NVIDIA Multimedia Package
			 119 KiB 	nvidia-l4t-oem-config         	NVIDIA OEM-Config Package
		   11388 KiB 	nvidia-l4t-tools              	NVIDIA Public Test Tools Package
			  64 KiB 	nvidia-l4t-wayland            	NVIDIA Wayland Package
			4617 KiB 	nvidia-l4t-weston             	NVIDIA Weston Package
			 209 KiB 	nvidia-l4t-x11                	NVIDIA X11 Package
			 405 KiB 	nvidia-l4t-xusb-firmware      	NVIDIA USB Firmware Package
			3741 KiB 	openssh-client                	secure shell (SSH) client, for secure access to remote machines
			 801 KiB 	openssh-server                	secure shell (SSH) server, for secure access from remote machines
			 110 KiB 	openssh-sftp-server           	secure shell (SSH) sftp server module, for SFTP access from remote machines
			1179 KiB 	openssl                       	Secure Sockets Layer toolkit - cryptographic utility
			 145 KiB 	parted                        	disk partition manipulator
			2425 KiB 	passwd                        	change and administer password and group data
			1288 KiB 	pciutils                      	Linux PCI Utilities
			 568 KiB 	perl                          	Larry Wall's Practical Extraction and Report Language
			7328 KiB 	perl-base                     	minimal Perl system
		   18501 KiB 	perl-modules-5.26             	Core Perl modules
			  88 KiB 	pinentry-curses               	curses-based PIN or pass-phrase entry dialog for GnuPG
			 436 KiB 	policykit-1                   	framework for managing administrative policies and privileges
			 917 KiB 	ppp                           	Point-to-Point Protocol (PPP) - daemon
			 673 KiB 	procps                        	/proc file system utilities
			 283 KiB 	publicsuffix                  	accurate, machine-readable list of domain name suffixes
			 624 KiB 	python                        	interactive high-level object-oriented language (default version)
			  33 KiB 	python-apipkg                 	namespace control and lazy-import mechanism for Python
			 252 KiB 	python-apt-common             	Python interface to libapt-pkg (locales)
			 108 KiB 	python-attr                   	Attributes without boilerplate (Python 2)
			 146 KiB 	python-execnet                	rapid multi-Python deployment (Python 2)
			  68 KiB 	python-funcsigs               	function signatures from PEP362 - Python 2.7
			 102 KiB 	python-jetson-gpio            	Jetson GPIO library package (Python 2)
			 145 KiB 	python-minimal                	minimal subset of the Python language (default version)
			5289 KiB 	python-opengl                 	Python bindings to OpenGL (Python 2)
			 182 KiB 	python-pexpect                	Python module for automating interactive applications
			 545 KiB 	python-pkg-resources          	Package Discovery and Resource Access using pkg_resources
			  57 KiB 	python-pluggy                 	plugin and hook calling mechanisms for Python - 2.7
			  53 KiB 	python-ptyprocess             	Run a subprocess in a pseudo terminal from Python 2
			 334 KiB 	python-py                     	Advanced Python development support library (Python 2)
			 650 KiB 	python-pytest                 	Simple, powerful testing in Python
			  31 KiB 	python-pytest-forked          	py.test plugin for running tests in isolated forked subprocesses
			 135 KiB 	python-pytest-xdist           	xdist plugin for py.test
			  54 KiB 	python-six                    	Python 2 and 3 compatibility library (Python 2 interface)
			 383 KiB 	python2.7                     	Interactive high-level object-oriented language (version 2.7)
			3331 KiB 	python2.7-minimal             	Minimal subset of the Python language (version 2.7)
			 187 KiB 	python3                       	interactive high-level object-oriented language (default python3 version)
			  33 KiB 	python3-apipkg                	namespace control and lazy-import mechanism for Python 3
			 571 KiB 	python3-apport                	Python 3 library for Apport crash report handling
			 685 KiB 	python3-apt                   	Python 3 interface to libapt-pkg
			 108 KiB 	python3-attr                  	Attributes without boilerplate (Python 3)
			 308 KiB 	python3-certifi               	root certificates for validating SSL certs and verifying TLS hosts (python3)
			 410 KiB 	python3-chardet               	universal character encoding detector for Python3
			1374 KiB 	python3-crypto                	cryptographic algorithms and protocols for Python 3
			 391 KiB 	python3-dbus                  	simple interprocess messaging system (Python 3 interface)
			2036 KiB 	python3-distutils             	distutils package for Python 3.x
			 146 KiB 	python3-execnet               	rapid multi-Python deployment (Python 3)
			 617 KiB 	python3-gi                    	Python 3 bindings for gobject-introspection libraries
			 113 KiB 	python3-httplib2              	comprehensive HTTP client library written for Python3
			 269 KiB 	python3-idna                  	Python IDNA2008 (RFC 5891) handling (Python 3)
			 102 KiB 	python3-jetson-gpio           	Jetson GPIO library package (Python 3)
			1033 KiB 	python3-lib2to3               	Interactive high-level object-oriented language (2to3, version 3.6)
			 121 KiB 	python3-minimal               	minimal subset of the Python language (default python3 version)
			 517 KiB 	python3-pkg-resources         	Package Discovery and Resource Access using pkg_resources
			  57 KiB 	python3-pluggy                	plugin and hook calling mechanisms for Python - 3.x
			 174 KiB 	python3-problem-report        	Python 3 library to handle problem reports
			 334 KiB 	python3-py                    	Advanced Python development support library (Python 3)
			 650 KiB 	python3-pytest                	Simple, powerful testing in Python3
			  31 KiB 	python3-pytest-forked         	py.test plugin for running tests in isolated forked subprocesses
			 135 KiB 	python3-pytest-xdist          	xdist plugin for py.test (Python 3)
			 275 KiB 	python3-requests              	elegant and simple HTTP library for Python3, built for human beings
			  33 KiB 	python3-requests-unixsocket   	Use requests to talk HTTP via a UNIX domain socket - Python 3.x
			  54 KiB 	python3-six                   	Python 2 and 3 compatibility library (Python 3 interface)
			 171 KiB 	python3-systemd               	Python 3 bindings for systemd
			 403 KiB 	python3-urllib3               	HTTP library with thread-safe connection pooling for Python3
			 329 KiB 	python3.6                     	Interactive high-level object-oriented language (version 3.6)
			8941 KiB 	python3.6-minimal             	Minimal subset of the Python language (version 3.6)
			  34 KiB 	qemu-efi                      	transitional dummy package
		  133154 KiB 	qemu-efi-aarch64              	UEFI firmware for 64-bit ARM virtual machines
			  59 KiB 	read-edid                     	hardware information-gathering tool for VESA PnP monitors
			  78 KiB 	readline-common               	GNU readline and history libraries, common files
			 183 KiB 	resolvconf                    	name server information handler
			 683 KiB 	rsync                         	fast, versatile, remote (and local) file-copying tool
			1360 KiB 	rsyslog                       	reliable system and kernel logging daemon
			 304 KiB 	sed                           	GNU stream editor for filtering/transforming text
			  62 KiB 	sensible-utils                	Utilities for sensible alternative selection
			2596 KiB 	shared-mime-info              	FreeDesktop.org shared MIME database and spec
			 187 KiB 	sox                           	Swiss army knife of sound processing
			  53 KiB 	ssh-import-id                 	securely retrieve an SSH public key and install it locally
			 103 KiB 	sshfs                         	filesystem client based on SSH File Transfer Protocol
			1668 KiB 	sudo                          	Provide limited super user privileges to specific users
		   11776 KiB 	systemd                       	system and service manager
			 130 KiB 	systemd-sysv                  	system and service manager - SysV links
			  59 KiB 	sysvinit-utils                	System-V-like utilities
			 836 KiB 	tar                           	GNU version of the tar archiving utility
			  46 KiB 	ubuntu-keyring                	GnuPG keys of the Ubuntu archive
			5647 KiB 	ubuntu-mono                   	Ubuntu Mono Icon theme
			 183 KiB 	ucf                           	Update Configuration File(s): preserve user changes to config files
			7642 KiB 	udev                          	/dev/ and hotplug management daemon
			3121 KiB 	util-linux                    	miscellaneous system utilities
			  22 KiB 	va-driver-all                 	Video Acceleration (VA) API -- driver metapackage
			  17 KiB 	vdpau-driver-all              	Video Decode and Presentation API for Unix (driver metapackage)
			2596 KiB 	vim                           	Vi IMproved - enhanced vi editor
			 330 KiB 	vim-common                    	Vi IMproved - Common files
		   28421 KiB 	vim-runtime                   	Vi IMproved - Runtime files
			 294 KiB 	vulkan-utils                  	Miscellaneous Vulkan utilities
			 892 KiB 	wget                          	retrieves files from the web
			  64 KiB 	whiptail                      	Displays user-friendly dialog boxes from shell scripts
			  33 KiB 	wireless-regdb                	wireless regulatory database
			 276 KiB 	wireless-tools                	Tools for manipulating Linux Wireless Extensions
			2353 KiB 	wpasupplicant                 	client support for WPA and WPA2 (IEEE 802.11i)
			 313 KiB 	x11-common                    	X Window System (X.Org) infrastructure
			 599 KiB 	x11-utils                     	X11 utilities
			 426 KiB 	x11-xkb-utils                 	X11 XKB utilities
			 477 KiB 	x11-xserver-utils             	X server utilities
			  68 KiB 	xauth                         	X authentication utility
			 223 KiB 	xbitmaps                      	Base X bitmaps
			 532 KiB 	xdg-user-dirs                 	tool to manage well known user directories
			7020 KiB 	xfonts-base                   	standard fonts for X
			 668 KiB 	xfonts-encodings              	Encodings for X.Org fonts
			 406 KiB 	xfonts-utils                  	X Window System font utility programs
			  57 KiB 	xinit                         	X server initialisation tool
			3186 KiB 	xkb-data                      	X Keyboard Extension (XKB) configuration data
			 236 KiB 	xserver-common                	common files used by various X servers
			 411 KiB 	xserver-xorg                  	X.Org X server
			3475 KiB 	xserver-xorg-core             	Xorg X server - core server
			  50 KiB 	xserver-xorg-input-all        	X.Org X server -- input driver metapackage
			  97 KiB 	xserver-xorg-input-libinput   	X.Org X server -- libinput input driver
			 279 KiB 	xserver-xorg-input-wacom      	X.Org X server -- Wacom input driver
			 262 KiB 	xserver-xorg-legacy           	setuid root Xorg server wrapper
			  50 KiB 	xserver-xorg-video-all        	X.Org X server -- output driver metapackage
			 145 KiB 	xserver-xorg-video-amdgpu     	X.Org X server -- AMDGPU display driver
			  44 KiB 	xserver-xorg-video-ati        	X.Org X server -- AMD/ATI display driver wrapper
			  46 KiB 	xserver-xorg-video-fbdev      	X.Org X server -- fbdev display driver
			 241 KiB 	xserver-xorg-video-nouveau    	X.Org X server -- Nouveau display driver
			 524 KiB 	xserver-xorg-video-radeon     	X.Org X server -- AMD/ATI Radeon display driver
			  49 KiB 	xserver-xorg-video-vesa       	X.Org X server -- VESA display driver
			1873 KiB 	xterm                         	X terminal emulator
			 191 KiB 	xxd                           	tool to make (or reverse) a hex dump
			 424 KiB 	xz-utils                      	XZ-format compression utilities
			 169 KiB 	zlib1g                        	compression library - runtime
    	```

	===  ":material-numeric-5-box-multiple: r34.1.1 (JetPack 5.0.1 DP)"

		```
		Filesystem     1K-blocks    Used Available Use% Mounted on
		/dev/mmcblk0p1  14384136 2514372  11119380  19% /
		Filesystem      Size  Used Avail Use% Mounted on
		/dev/mmcblk0p1   14G  2.4G   11G  19% /
		972
			 624 KiB 	adduser                       	add and remove users and groups
			5135 KiB 	adwaita-icon-theme            	default icon theme of GNOME (small subset)
			 338 KiB 	alsa-ucm-conf                 	ALSA Use Case Manager configuration files
			2348 KiB 	alsa-utils                    	Utilities for configuring and using ALSA
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
			 175 KiB 	bzip2                         	high-quality block-sorting file compressor - utilities
			 375 KiB 	ca-certificates               	Common CA certificates
			 103 KiB 	ca-certificates-mono          	Common CA certificates (Mono keystore)
			 517 KiB 	can-utils                     	SocketCAN userspace utilities and tools
			 265 KiB 	cli-common                    	common files between all CLI packages
			 428 KiB 	console-setup                 	console font and keymap setup program
			1766 KiB 	console-setup-linux           	Linux specific part of console-setup
			6480 KiB 	coreutils                     	GNU core utilities
			  64 KiB 	cpp                           	GNU C preprocessor (cpp)
		   19215 KiB 	cpp-9                         	GNU C preprocessor
			 254 KiB 	cron                          	process scheduling daemon
			 386 KiB 	cryptsetup                    	disk encryption support - startup scripts
			 512 KiB 	cryptsetup-bin                	disk encryption support - command line tools
			 220 KiB 	dash                          	POSIX-compliant shell
			 575 KiB 	dbus                          	simple interprocess messaging system (daemon and utilities)
			 127 KiB 	dbus-user-session             	simple interprocess messaging system (systemd --user integration)
			 153 KiB 	dbus-x11                      	simple interprocess messaging system (X11 deps)
			  78 KiB 	dconf-gsettings-backend       	simple configuration storage system - GSettings back-end
			 110 KiB 	dconf-service                 	simple configuration storage system - D-Bus service
			 520 KiB 	debconf                       	Debian configuration management system
			 217 KiB 	debianutils                   	Miscellaneous utilities specific to Debian
			 446 KiB 	device-tree-compiler          	Device Tree Compiler for Flat Device Trees
			 496 KiB 	diffutils                     	File comparison utilities
			 872 KiB 	dirmngr                       	GNU privacy guard - network certificate management service
			  17 KiB 	distro-info-data              	information about the distributions' releases (data files)
			 277 KiB 	dmsetup                       	Linux Kernel Device Mapper userspace library
			6704 KiB 	dpkg                          	Debian package management system
			1406 KiB 	e2fsprogs                     	ext2/ext3/ext4 file system utilities
			 486 KiB 	fdisk                         	collection of partitioning utilities
			  82 KiB 	file                          	Recognize the type of data in a file using "magic" numbers
			 648 KiB 	findutils                     	utilities for finding files--find, xargs
			2008 KiB 	fio                           	flexible I/O tester
			 333 KiB 	fontconfig                    	generic font configuration library - support binaries
			 170 KiB 	fontconfig-config             	generic font configuration library - configuration
			2954 KiB 	fonts-dejavu-core             	Vera font family derivate with additional characters
			 286 KiB 	freeglut3                     	OpenGL Utility Toolkit
			  99 KiB 	fuse                          	Filesystem in Userspace
			 265 KiB 	gcc-10-base                   	GCC, the GNU Compiler Collection (base package)
			 265 KiB 	gcc-9-base                    	GCC, the GNU Compiler Collection (base package)
			1893 KiB 	gdal-data                     	Geospatial Data Abstraction Library - Data files
			 789 KiB 	gdbserver                     	GNU Debugger (remote server)
			 804 KiB 	gdisk                         	GPT fdisk text-mode partitioning tool
			 650 KiB 	gir1.2-glib-2.0               	Introspection data for GLib, GObject, Gio and GModule
			 237 KiB 	gir1.2-gst-plugins-bad-1.0    	GObject introspection data for the GStreamer libraries from the "bad" set
			 469 KiB 	gir1.2-gst-plugins-base-1.0   	GObject introspection data for the GStreamer Plugins Base library
			1427 KiB 	gir1.2-gstreamer-1.0          	GObject introspection data for the GStreamer library
			 187 KiB 	glib-networking               	network-related giomodules for GLib
			  52 KiB 	glib-networking-common        	network-related giomodules for GLib - data files
			  47 KiB 	glib-networking-services      	network-related giomodules for GLib - D-Bus services
			 413 KiB 	gnupg                         	GNU privacy guard - a free PGP replacement
			 380 KiB 	gnupg-l10n                    	GNU privacy guard - localization files
			1485 KiB 	gnupg-utils                   	GNU privacy guard - utility programs
			  50 KiB 	gnupg2                        	GNU privacy guard - a free PGP replacement (dummy transitional package)
			1107 KiB 	gpg                           	GNU Privacy Guard -- minimalist public key operations
			 878 KiB 	gpg-agent                     	GNU privacy guard - cryptographic agent
			 275 KiB 	gpg-wks-client                	GNU privacy guard - Web Key Service client
			 247 KiB 	gpg-wks-server                	GNU privacy guard - Web Key Service server
			 389 KiB 	gpgconf                       	GNU privacy guard - core configuration utilities
			 548 KiB 	gpgsm                         	GNU privacy guard - S/MIME version
			 487 KiB 	gpgv                          	GNU privacy guard - signature verification tool
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
			 217 KiB 	kexec-tools                   	tools to support fast kexec reboots
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
			2315 KiB 	libaom0                       	AV1 Video Codec Library
			 159 KiB 	libapparmor1                  	changehat AppArmor library
			3107 KiB 	libapt-pkg6.0                 	package management runtime library
			 808 KiB 	libarchive13                  	Multi-format archive and compression library (shared library)
			  51 KiB 	libargon2-1                   	memory-hard hashing function - runtime library
			 662 KiB 	libarmadillo9                 	streamlined C++ linear algebra library
			 257 KiB 	libarpack2                    	Fortran77 subroutines to solve large scale eigenvalue problems
			 732 KiB 	libasn1-8-heimdal             	Heimdal Kerberos - ASN.1 library
			1098 KiB 	libasound2                    	shared library for ALSA applications
			 215 KiB 	libasound2-data               	Configuration files and profiles for ALSA drivers
			 167 KiB 	libass9                       	library for SSA/ASS subtitles rendering
			 101 KiB 	libassuan0                    	IPC library for the GnuPG components
			  39 KiB 	libasyncns0                   	Asynchronous name service query library
			 230 KiB 	libatk-bridge2.0-0            	AT-SPI 2 toolkit bridge - shared library
			 199 KiB 	libatk1.0-0                   	ATK accessibility toolkit
			  44 KiB 	libatk1.0-data                	Common files for the ATK accessibility toolkit
			 156 KiB 	libatopology2                 	shared library for handling ALSA topology definitions
			 235 KiB 	libatspi2.0-0                 	Assistive Technology Service Provider Interface - shared library
			  52 KiB 	libattr1                      	extended attribute handling - shared library
			  24 KiB 	libaudit-common               	Dynamic library for security auditing - common files
			 148 KiB 	libaudit1                     	Dynamic library for security auditing
			 124 KiB 	libavahi-client3              	Avahi client library
			 112 KiB 	libavahi-common-data          	Avahi common data files
			 109 KiB 	libavahi-common3              	Avahi common library
			  53 KiB 	libavc1394-0                  	control IEEE 1394 audio/video devices
		   17374 KiB 	libavcodec-dev                	FFmpeg library with de/encoders for audio/video codecs - development files
		   11725 KiB 	libavcodec58                  	FFmpeg library with de/encoders for audio/video codecs - runtime files
			3296 KiB 	libavfilter7                  	FFmpeg library containing media filters - runtime files
			5319 KiB 	libavformat-dev               	FFmpeg library with (de)muxers for multimedia containers - development files
			2538 KiB 	libavformat58                 	FFmpeg library with (de)muxers for multimedia containers - runtime files
			 235 KiB 	libavresample-dev             	FFmpeg compatibility library for resampling - development files
			 157 KiB 	libavresample4                	FFmpeg compatibility library for resampling - runtime files
			1639 KiB 	libavutil-dev                 	FFmpeg library with functions for simplifying programming - development files
			 649 KiB 	libavutil56                   	FFmpeg library with functions for simplifying programming - runtime files
			2092 KiB 	libbinutils                   	GNU binary utilities (private shared library)
			 375 KiB 	libblas3                      	Basic Linear Algebra Reference implementations, shared library
			 977 KiB 	libblkid-dev                  	block device ID library - headers and static libraries
			 443 KiB 	libblkid1                     	block device ID library
			 344 KiB 	libbluray2                    	Blu-ray disc playback support library (shared library)
			2105 KiB 	libboost-iostreams1.71.0      	Boost.Iostreams Library
			2129 KiB 	libboost-thread1.71.0         	portable C++ multi-threading
			 694 KiB 	libbrotli1                    	library implementing brotli encoder and decoder (shared libraries)
			  36 KiB 	libbs2b0                      	Bauer stereophonic-to-binaural DSP library
			 191 KiB 	libbsd0                       	utility functions from BSD systems - shared library
			  94 KiB 	libbz2-1.0                    	high-quality block-sorting file compressor library - runtime
			3181 KiB 	libc-bin                      	GNU C Library: Binaries
			 422 KiB 	libc-dev-bin                  	GNU C Library: Development binaries
		   10468 KiB 	libc6                         	GNU C Library: Shared libraries
		   15831 KiB 	libc6-dev                     	GNU C Library: Development Libraries and Header Files
			1025 KiB 	libcaca0                      	colour ASCII art library
			  94 KiB 	libcairo-gobject2             	Cairo 2D vector graphics library (GObject library)
			1250 KiB 	libcairo2                     	Cairo 2D vector graphics library
			 118 KiB 	libcanberra0                  	simple abstract interface for playing event sounds
			  37 KiB 	libcap-ng0                    	An alternate POSIX capabilities library
			  52 KiB 	libcap2                       	POSIX 1003.1e capabilities (library)
			 100 KiB 	libcap2-bin                   	POSIX 1003.1e capabilities (utilities)
			  78 KiB 	libcbor0.6                    	library for parsing and generating CBOR (RFC 7049)
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
			 753 KiB 	libcups2                      	Common UNIX Printing System(tm) - Core library
			 641 KiB 	libcurl3-gnutls               	easy-to-use client-side URL transfer library (GnuTLS flavour)
			1535 KiB 	libdap25                      	Open-source Project for a Network Data Access Protocol library
			 270 KiB 	libdapclient6v5               	Client library for the Network Data Access Protocol
			  57 KiB 	libdatrie1                    	Double-array trie library
			1613 KiB 	libdb5.3                      	Berkeley v5.3 Database Libraries [runtime]
			 462 KiB 	libdbus-1-3                   	simple interprocess messaging system (library)
			 233 KiB 	libdc1394-22                  	high level programming interface for IEEE 1394 digital cameras
			 589 KiB 	libdc1394-22-dev              	high level programming interface for IEEE 1394 digital cameras - development
			 181 KiB 	libdca0                       	decoding library for DTS Coherent Acoustics streams
			 102 KiB 	libdconf1                     	simple configuration storage system - runtime library
			 552 KiB 	libde265-0                    	Open H.265 video codec implementation
			  69 KiB 	libdebconfclient0             	Debian Configuration Management System (C-implementation library)
			 492 KiB 	libdevmapper1.02.1            	Linux Kernel Device Mapper userspace library
			2123 KiB 	libdns-export1109             	Exported DNS Shared Library
			2176 KiB 	libdpkg-perl                  	Dpkg perl modules
			  80 KiB 	libdrm-amdgpu1                	Userspace interface to amdgpu-specific kernel DRM services -- runtime
			  45 KiB 	libdrm-common                 	Userspace interface to kernel DRM services -- common files
			 695 KiB 	libdrm-dev                    	Userspace interface to kernel DRM services -- development files
			  62 KiB 	libdrm-etnaviv1               	Userspace interface to etnaviv-specific kernel DRM services -- runtime
			  79 KiB 	libdrm-freedreno1             	Userspace interface to msm/kgsl kernel DRM services -- runtime
			  74 KiB 	libdrm-nouveau2               	Userspace interface to nouveau-specific kernel DRM services -- runtime
			  83 KiB 	libdrm-radeon1                	Userspace interface to radeon-specific kernel DRM services -- runtime
			  49 KiB 	libdrm-tegra0                 	Userspace interface to tegra-specific kernel DRM services -- runtime
			 124 KiB 	libdrm2                       	Userspace interface to kernel DRM services -- runtime
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
			  25 KiB 	libestr0                      	Helper functions for handling strings (lib)
			 131 KiB 	libevdev2                     	wrapper library for evdev devices
			 392 KiB 	libevent-2.1-7                	Asynchronous event notification library
			 262 KiB 	libevent-core-2.1-7           	Asynchronous event notification library (core)
			  41 KiB 	libevent-pthreads-2.1-7       	Asynchronous event notification library (pthreads)
			 508 KiB 	libexif-dev                   	library to parse EXIF files (development files)
			 360 KiB 	libexif12                     	library to parse EXIF files
			 353 KiB 	libexpat1                     	XML parsing C library - runtime library
			 535 KiB 	libext2fs2                    	ext2/ext3/ext4 file system libraries
			 497 KiB 	libfaad2                      	freeware Advanced Audio Decoder - runtime files
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
			 139 KiB 	libgbm1                       	generic buffer management API -- runtime
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
			  70 KiB 	libgl1-mesa-glx               	transitional dummy package
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
			2456 KiB 	libgstreamer-plugins-base1.0-0	GStreamer libraries from the "base" set
			 195 KiB 	libgstreamer-plugins-good1.0-0	GStreamer development files for libraries from the "good" set
			3856 KiB 	libgstreamer1.0-0             	Core GStreamer libraries and elements
			4936 KiB 	libgstreamer1.0-0-dbg         	Core GStreamer libraries and elements
			6671 KiB 	libgstreamer1.0-dev           	GStreamer core development files
			9816 KiB 	libgtk-3-0                    	GTK graphical user interface library
			 420 KiB 	libgtk-3-common               	common files for the GTK graphical user interface library
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
			 142 KiB 	libjs-sphinxdoc               	JavaScript support for Sphinx documentation
			 297 KiB 	libjs-underscore              	JavaScript's functional programming helper library
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
			 507 KiB 	libldap-2.4-2                 	OpenLDAP libraries
			 102 KiB 	libldap-common                	OpenLDAP common files for libraries
			2663 KiB 	liblept5                      	image processing library
			 126 KiB 	liblilv-0-0                   	library for simple use of LV2 plugins
		   81948 KiB 	libllvm12                     	Modular compiler and toolchain technologies, runtime library
			  54 KiB 	liblocale-gettext-perl        	module using libc functions for internationalization in Perl
			 418 KiB 	libltdl7                      	System independent dlopen wrapper for GNU libtool
			 140 KiB 	liblz4-1                      	Fast LZ compression algorithm library - runtime
			 575 KiB 	liblzma-dev                   	XZ-format compression library - development files
			 251 KiB 	liblzma5                      	XZ-format compression library
			 150 KiB 	liblzo2-2                     	data compression library
			5723 KiB 	libmagic-mgc                  	File type determination library using "magic" numbers (compiled magic file)
			 208 KiB 	libmagic1                     	Recognize the type of data in a file using "magic" numbers - library
			  55 KiB 	libminizip1                   	compression library - minizip library
			  69 KiB 	libmjpegutils-2.1-0           	MJPEG capture/editing/replay and MPEG encoding toolset (library)
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
			7313 KiB 	libmysqlclient21              	MySQL database client library
			 285 KiB 	libncurses5                   	shared libraries for terminal handling (legacy version)
			 308 KiB 	libncurses6                   	shared libraries for terminal handling
			 392 KiB 	libncursesw6                  	shared libraries for terminal handling (wide character support)
			 153 KiB 	libnetcdf-c++4                	legacy NetCDF C++ interface
			1278 KiB 	libnetcdf15                   	Interface for scientific data access to large binary data
			 134 KiB 	libnetfilter-conntrack3       	Netfilter netlink-conntrack library
			 384 KiB 	libnettle7                    	low level cryptographic library (symmetric and one-way cryptos)
			  40 KiB 	libnfnetlink0                 	Netfilter netlink library
			 216 KiB 	libnftnl11                    	Netfilter nftables userspace API library
			 208 KiB 	libnghttp2-14                 	library implementing HTTP/2 protocol (shared library)
			 362 KiB 	libnice10                     	ICE library (shared library)
			 176 KiB 	libnl-3-200                   	library for dealing with netlink sockets
			  52 KiB 	libnl-genl-3-200              	library for dealing with netlink sockets - generic netlink
			 531 KiB 	libnl-route-3-200             	library for dealing with netlink sockets - route interface
			 666 KiB 	libnorm1                      	NACK-Oriented Reliable Multicast (NORM) library
			  32 KiB 	libnpth0                      	replacement for GNU Pth using system threads
			 310 KiB 	libnspr4                      	NetScape Portable Runtime Library
			 404 KiB 	libnss-systemd                	nss module providing dynamic user and group name resolution
			3657 KiB 	libnss3                       	Network Security Service libraries
			  68 KiB 	libnuma1                      	Libraries for controlling NUMA policy
			 569 KiB 	libodbc1                      	ODBC library for Unix
			 155 KiB 	libofa0                       	library for acoustic fingerprinting
			 568 KiB 	libogdi4.1                    	Open Geographic Datastore Interface Library -- library
			  62 KiB 	libogg0                       	Ogg bitstream library
			 206 KiB 	libopenal-data                	Software implementation of the OpenAL audio API (data files)
			 930 KiB 	libopenal1                    	Software implementation of the OpenAL audio API (shared library)
			 175 KiB 	libopencore-amrnb0            	Adaptive Multi Rate speech codec - shared library
			  92 KiB 	libopencore-amrwb0            	Adaptive Multi-Rate - Wideband speech codec - shared library
			3417 KiB 	libopencv-calib3d-dev         	development files for libopencv-calib3d4.2
			1365 KiB 	libopencv-calib3d4.2          	computer vision Camera Calibration library
		   22575 KiB 	libopencv-contrib-dev         	development files for libopencv-contrib4.2
			8383 KiB 	libopencv-contrib4.2          	computer vision contrlib library
		   10215 KiB 	libopencv-core-dev            	development files for libopencv-core4.2
			2693 KiB 	libopencv-core4.2             	computer vision core library
			 335 KiB 	libopencv-dev                 	development files for opencv
		   10713 KiB 	libopencv-dnn-dev             	development files for libopencv-dnn4.2
			2855 KiB 	libopencv-dnn4.2              	computer vision Deep neural network module
			1638 KiB 	libopencv-features2d-dev      	development files for libopencv-features2d4.2
			 665 KiB 	libopencv-features2d4.2       	computer vision Feature Detection and Descriptor Extraction library
			1527 KiB 	libopencv-flann-dev           	development files for libopencv-flann4.2
			 369 KiB 	libopencv-flann4.2            	computer vision Clustering and Search in Multi-Dimensional spaces library
			 300 KiB 	libopencv-highgui-dev         	development files for libopencv-highgui4.2
			 120 KiB 	libopencv-highgui4.2          	computer vision High-level GUI and Media I/O library
			1220 KiB 	libopencv-imgcodecs-dev       	development files for libopencv-imgcodecs4.2
			 333 KiB 	libopencv-imgcodecs4.2        	computer vision Image Codecs library
			7352 KiB 	libopencv-imgproc-dev         	development files for libopencv-imgproc4.2
			3000 KiB 	libopencv-imgproc4.2          	computer vision Image Processing library
			1741 KiB 	libopencv-ml-dev              	development files for libopencv-ml4.2
			 636 KiB 	libopencv-ml4.2               	computer vision Machine Learning library
			 869 KiB 	libopencv-objdetect-dev       	development files for libopencv-objdetect4.2
			 381 KiB 	libopencv-objdetect4.2        	computer vision Object Detection library
			1502 KiB 	libopencv-photo-dev           	development files for libopencv-photo4.2
			 668 KiB 	libopencv-photo4.2            	computer vision computational photography library
			 493 KiB 	libopencv-shape-dev           	development files for libopencv-shape4.2
			 188 KiB 	libopencv-shape4.2            	computer vision shape descriptors and matchers library
			1754 KiB 	libopencv-stitching-dev       	development files for libopencv-stitching4.2
			 669 KiB 	libopencv-stitching4.2        	computer vision image stitching library
			 395 KiB 	libopencv-superres-dev        	development files for libopencv-superres4.2
			 180 KiB 	libopencv-superres4.2         	computer vision Super Resolution library
			2045 KiB 	libopencv-ts-dev              	development files for TS library of OpenCV (Open Computer Vision)
			 961 KiB 	libopencv-video-dev           	development files for libopencv-video4.2
			 417 KiB 	libopencv-video4.2            	computer vision Video analysis library
			1351 KiB 	libopencv-videoio-dev         	development files for libopencv-videoio4.2
			 445 KiB 	libopencv-videoio4.2          	computer vision Video I/O library
			 807 KiB 	libopencv-videostab-dev       	development files for libopencv-videostab4.2
			 324 KiB 	libopencv-videostab4.2        	computer vision video stabilization library
			1308 KiB 	libopencv-viz-dev             	development files for libopencv-viz4.2
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
			 160 KiB 	libopts25                     	automated option processing library based on autogen
			 343 KiB 	libopus0                      	Opus codec runtime library
			1053 KiB 	liborc-0.4-0                  	Library of Optimized Inner Loops Runtime Compiler
			1337 KiB 	liborc-0.4-dev                	Library of Optimized Inner Loops Runtime Compiler (development headers)
			1056 KiB 	liborc-0.4-dev-bin            	Library of Optimized Inner Loops Runtime Compiler (development tools)
			1299 KiB 	libp11-kit0                   	library for loading and coordinating access to PKCS#11 modules - runtime
			 941 KiB 	libpam-modules                	Pluggable Authentication Modules for PAM
			 290 KiB 	libpam-modules-bin            	Pluggable Authentication Modules for PAM - helper binaries
			 304 KiB 	libpam-runtime                	Runtime support for the PAM library
			 219 KiB 	libpam0g                      	Pluggable Authentication Modules library
			 409 KiB 	libpango-1.0-0                	Layout and rendering of internationalized text
			 103 KiB 	libpangocairo-1.0-0           	Layout and rendering of internationalized text
			 133 KiB 	libpangoft2-1.0-0             	Layout and rendering of internationalized text
			 445 KiB 	libparted2                    	disk partition manipulator - shared library
			 325 KiB 	libpcap0.8                    	system interface for user-level packet capture
			 105 KiB 	libpci3                       	PCI utilities (shared library)
			  99 KiB 	libpciaccess-dev              	Generic PCI access library for X - development files
			  57 KiB 	libpciaccess0                 	Generic PCI access library for X
			 482 KiB 	libpcre16-3                   	Old Perl 5 Compatible Regular Expression Library - 16 bit runtime files
			 487 KiB 	libpcre2-16-0                 	New Perl Compatible Regular Expression Library - 16 bit runtime files
			 455 KiB 	libpcre2-32-0                 	New Perl Compatible Regular Expression Library - 32 bit runtime files
			 524 KiB 	libpcre2-8-0                  	New Perl Compatible Regular Expression Library- 8 bit runtime files
			2007 KiB 	libpcre2-dev                  	New Perl Compatible Regular Expression Library - development files
			  29 KiB 	libpcre2-posix2               	New Perl Compatible Regular Expression Library - posix-compatible runtime files
			 601 KiB 	libpcre3                      	Old Perl 5 Compatible Regular Expression Library - runtime files
			 466 KiB 	libpcre32-3                   	Old Perl 5 Compatible Regular Expression Library - 32 bit runtime files
			 189 KiB 	libpcrecpp0v5                 	Old Perl 5 Compatible Regular Expression Library - C++ runtime files
			  71 KiB 	libpcsclite1                  	Middleware to access a smart card using PC/SC (library)
		   26547 KiB 	libperl5.30                   	shared Perl library
			 313 KiB 	libpgm-5.2-0                  	OpenPGM shared library
			  76 KiB 	libpipeline1                  	Unix process pipeline manipulation library
			 407 KiB 	libpixman-1-0                 	pixel-manipulation library for X and cairo
			 606 KiB 	libpixman-1-dev               	pixel-manipulation library for X and cairo (development files)
			1571 KiB 	libpmix2                      	Process Management Interface (Exascale) library
			 699 KiB 	libpng-dev                    	PNG library - development (version 1.6)
			 328 KiB 	libpng16-16                   	PNG library - runtime (version 1.6)
			3280 KiB 	libpoppler97                  	PDF rendering library
			 120 KiB 	libpopt0                      	lib for parsing cmdline parameters
			 120 KiB 	libpostproc55                 	FFmpeg library for post processing - runtime files
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
			 368 KiB 	libqhull7                     	calculate convex hulls and related structures (shared library)
		   12878 KiB 	librados2                     	RADOS distributed object store client library
			  80 KiB 	libraw1394-11                 	library for direct access to IEEE 1394 bus (aka FireWire)
			 174 KiB 	libraw1394-dev                	library for direct access to IEEE 1394 bus - development files
			5367 KiB 	librbd1                       	RADOS block device client library
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
			  56 KiB 	libsox-fmt-alsa               	SoX alsa format I/O library
			 321 KiB 	libsox-fmt-base               	Minimal set of SoX format libraries
			 556 KiB 	libsox3                       	SoX library of audio effects and processing
			 149 KiB 	libsoxr0                      	High quality 1D sample-rate conversion library
			 819 KiB 	libspandsp2                   	Telephony signal processing library
			5371 KiB 	libspatialite7                	Geospatial extension for SQLite - libraries
			 113 KiB 	libspeex1                     	The Speex codec runtime library
			1300 KiB 	libsqlite3-0                  	SQLite 3 shared library
			  52 KiB 	libsratom-0-0                 	library for serialising LV2 atoms to/from Turtle
			 589 KiB 	libsrt1                       	Secure Reliable Transport UDP streaming library
			 155 KiB 	libsrtp2-1                    	Secure RTP (SRTP) and UST Reference Implementations - shared library
			 103 KiB 	libss2                        	command-line interface parsing library
			 479 KiB 	libssh-4                      	tiny C SSH library (OpenSSL flavor)
			 594 KiB 	libssh-gcrypt-4               	tiny C SSH library (gcrypt flavor)
			3613 KiB 	libssl1.1                     	Secure Sockets Layer toolkit - shared libraries
			2389 KiB 	libstdc++6                    	GNU Standard C++ Library v3
			 402 KiB 	libsuperlu5                   	Direct solution of large, sparse systems of linear equations
			 249 KiB 	libswresample-dev             	FFmpeg library for audio resampling, rematrixing etc. - development files
			 169 KiB 	libswresample3                	FFmpeg library for audio resampling, rematrixing etc. - runtime files
			 747 KiB 	libswscale-dev                	FFmpeg library for image scaling and various conversions - development files
			 501 KiB 	libswscale5                   	FFmpeg library for image scaling and various conversions - runtime files
			 869 KiB 	libsystemd0                   	systemd utility library
			  24 KiB 	libsz2                        	Adaptive Entropy Coding library - SZIP
			  50 KiB 	libtag1v5                     	audio meta-data library
			1101 KiB 	libtag1v5-vanilla             	audio meta-data library - vanilla flavour
			 116 KiB 	libtasn1-6                    	Manage ASN.1 structures (runtime)
			1972 KiB 	libtbb-dev                    	parallelism library for C++ - development files
			 285 KiB 	libtbb2                       	parallelism library for C++ - runtime files
			 134 KiB 	libtdb1                       	Trivial Database - shared library
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
			 139 KiB 	libtwolame0                   	MPEG Audio Layer 2 encoding library
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
			  31 KiB 	libxcb-present0               	X C Binding, present extension
			  86 KiB 	libxcb-render0                	X C Binding, render extension
			  36 KiB 	libxcb-shape0                 	X C Binding, shape extension
			  31 KiB 	libxcb-shm0                   	X C Binding, shm extension
			  50 KiB 	libxcb-sync1                  	X C Binding, sync extension
			  55 KiB 	libxcb-xfixes0                	X C Binding, xfixes extension
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
			 273 KiB 	libxkbcommon0                 	library interface to the XKB compiler - shared library
			 166 KiB 	libxkbfile1                   	X11 keyboard file manipulation library
			1850 KiB 	libxml2                       	GNOME XML library
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
			5965 KiB 	linux-libc-dev                	Linux Kernel Headers for development
		   17196 KiB 	locales                       	GNU C Library: National Language (locale) data [support]
			 908 KiB 	login                         	system login tools
			 135 KiB 	logrotate                     	Log rotation utility
			  91 KiB 	logsave                       	save the output of a command in a log file
			  58 KiB 	lsb-base                      	Linux Standard Base init script functionality
			  66 KiB 	lsb-release                   	Linux Standard Base version reporting utility
			2744 KiB 	man-db                        	tools for reading manual pages
			 225 KiB 	mawk                          	Pattern scanning and text processing language
			 114 KiB 	mime-support                  	MIME files 'mime.types' & 'mailcap', and support programs
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
			  69 KiB 	networkd-dispatcher           	Dispatcher service for systemd-networkd connection status changes
			1942 KiB 	ntp                           	Network Time Protocol daemon and utility programs
			 138 KiB 	numactl                       	NUMA scheduling and memory placement tool
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
			 105 KiB 	ocl-icd-libopencl1            	Generic OpenCL ICD Loader
			  55 KiB 	odbcinst                      	Helper program for accessing odbc ini files
			 210 KiB 	odbcinst1debian2              	Support library for accessing odbc ini files
			3961 KiB 	openssh-client                	secure shell (SSH) client, for secure access to remote machines
			1471 KiB 	openssh-server                	secure shell (SSH) server, for secure access from remote machines
			 137 KiB 	openssh-sftp-server           	secure shell (SSH) sftp server module, for SFTP access from remote machines
			1213 KiB 	openssl                       	Secure Sockets Layer toolkit - cryptographic utility
			 159 KiB 	parted                        	disk partition manipulator
			2536 KiB 	passwd                        	change and administer password and group data
			1193 KiB 	pci.ids                       	PCI ID Repository
			 175 KiB 	pciutils                      	PCI utilities
			 745 KiB 	perl                          	Larry Wall's Practical Extraction and Report Language
		   10407 KiB 	perl-base                     	minimal Perl system
		   17226 KiB 	perl-modules-5.30             	Core Perl modules
			  92 KiB 	pinentry-curses               	curses-based PIN or pass-phrase entry dialog for GnuPG
			 182 KiB 	pkg-config                    	manage compile and link flags for libraries
			 961 KiB 	ppp                           	Point-to-Point Protocol (PPP) - daemon
			 803 KiB 	procps                        	/proc file system utilities
		   23574 KiB 	proj-data                     	Cartographic projection filter and library (datum package)
			 268 KiB 	python-apt-common             	Python interface to libapt-pkg (locales)
			  33 KiB 	python-atomicwrites           	Atomic file writes - Python 2.7
			 159 KiB 	python-attr                   	Attributes without boilerplate (Python 2)
			 394 KiB 	python-configparser           	backport of the enhanced config parser introduced in Python 3.2 - PyPy
			  49 KiB 	python-contextlib2            	Backport and enhancements for the contextlib module - Python 2.7
			  68 KiB 	python-funcsigs               	function signatures from PEP362 - Python 2.7
			  43 KiB 	python-importlib-metadata     	library to access the metadata for a Python package - Python 2.7
			  10 KiB 	python-is-python3             	symlinks /usr/bin/python to python3
			 105 KiB 	python-jetson-gpio            	Jetson GPIO library package (Python 2)
			 199 KiB 	python-more-itertools         	library with for operating on iterables, beyond itertools (Python 2)
			5289 KiB 	python-opengl                 	Python bindings to OpenGL (Python 2)
			 129 KiB 	python-packaging              	core utilities for python packages
			  81 KiB 	python-pathlib2               	Backport of the "pathlib" stdlib module (Python 2)
			 190 KiB 	python-pexpect                	Python module for automating interactive applications
			 566 KiB 	python-pkg-resources          	Package Discovery and Resource Access using pkg_resources
			  89 KiB 	python-pluggy                 	plugin and hook calling mechanisms for Python - 2.7
			  53 KiB 	python-ptyprocess             	Run a subprocess in a pseudo terminal from Python 2
			 336 KiB 	python-py                     	Advanced Python development support library (Python 2)
			 298 KiB 	python-pyparsing              	alternative to creating and executing simple grammars - Python 2.7
			 823 KiB 	python-pytest                 	Simple, powerful testing in Python
			  80 KiB 	python-scandir                	Backport of the "scandir" stdlib module (Python 2)
			  58 KiB 	python-six                    	Python 2 and 3 compatibility library (Python 2 interface)
			  78 KiB 	python-wcwidth                	determine printable width of a string on a terminal (Python 2)
			  25 KiB 	python-zipp                   	pathlib-compatible Zipfile object wrapper - Python 2.7
			 136 KiB 	python2                       	interactive high-level object-oriented language (Python2 version)
			 144 KiB 	python2-minimal               	minimal subset of the Python2 language
			 382 KiB 	python2.7                     	Interactive high-level object-oriented language (version 2.7)
			3642 KiB 	python2.7-minimal             	Minimal subset of the Python language (version 2.7)
			 189 KiB 	python3                       	interactive high-level object-oriented language (default python3 version)
			  35 KiB 	python3-apipkg                	namespace control and lazy-import mechanism for Python 3
			 589 KiB 	python3-apport                	Python 3 library for Apport crash report handling
			 699 KiB 	python3-apt                   	Python 3 interface to libapt-pkg
			  33 KiB 	python3-atomicwrites          	Atomic file writes - Python 3.x
			 159 KiB 	python3-attr                  	Attributes without boilerplate (Python 3)
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
			 151 KiB 	python3-execnet               	rapid multi-Python deployment (Python 3)
			 692 KiB 	python3-gi                    	Python 3 bindings for gobject-introspection libraries
			 130 KiB 	python3-httplib2              	comprehensive HTTP client library written for Python3
			 289 KiB 	python3-idna                  	Python IDNA2008 (RFC 5891) handling (Python 3)
			  43 KiB 	python3-importlib-metadata    	library to access the metadata for a Python package - Python 3.x
			 105 KiB 	python3-jetson-gpio           	Jetson GPIO library package (Python 3)
			  85 KiB 	python3-jwt                   	Python 3 implementation of JSON Web Token
			 155 KiB 	python3-keyring               	store and access your passwords safely - Python 3 version of the package
			 243 KiB 	python3-launchpadlib          	Launchpad web services client library (Python 3)
			 185 KiB 	python3-lazr.restfulclient    	client for lazr.restful-based web services (Python 3)
			  74 KiB 	python3-lazr.uri              	library for parsing, manipulating, and generating URIs
			 702 KiB 	python3-lib2to3               	Interactive high-level object-oriented language (lib2to3)
			 120 KiB 	python3-minimal               	minimal subset of the Python language (default python3 version)
			 197 KiB 	python3-more-itertools        	library with routines for operating on iterables, beyond itertools (Python 3)
			 540 KiB 	python3-oauthlib              	generic, spec-compliant implementation of OAuth for Python3
			 129 KiB 	python3-packaging             	core utilities for python3 packages
			 567 KiB 	python3-pkg-resources         	Package Discovery and Resource Access using pkg_resources
			  89 KiB 	python3-pluggy                	plugin and hook calling mechanisms for Python - 3.x
			 177 KiB 	python3-problem-report        	Python 3 library to handle problem reports
			 336 KiB 	python3-py                    	Advanced Python development support library (Python 3)
			 298 KiB 	python3-pyparsing             	alternative to creating and executing simple grammars - Python 3.x
			 823 KiB 	python3-pytest                	Simple, powerful testing in Python3
			  32 KiB 	python3-pytest-forked         	py.test plugin for running tests in forked subprocesses (Python 3)
			 143 KiB 	python3-pytest-xdist          	xdist plugin for py.test (Python 3)
			 228 KiB 	python3-requests              	elegant and simple HTTP library for Python3, built for human beings
			  34 KiB 	python3-requests-unixsocket   	Use requests to talk HTTP via a UNIX domain socket - Python 3.x
			  53 KiB 	python3-secretstorage         	Python module for storing secrets - Python 3.x version
			 242 KiB 	python3-simplejson            	simple, fast, extensible JSON encoder/decoder for Python 3.x
			  58 KiB 	python3-six                   	Python 2 and 3 compatibility library (Python 3 interface)
			 173 KiB 	python3-systemd               	Python 3 bindings for systemd
			 414 KiB 	python3-urllib3               	HTTP library with thread-safe connection pooling for Python3
			 372 KiB 	python3-wadllib               	Python 3 library for navigating WADL files
			  78 KiB 	python3-wcwidth               	determine printable width of a string on a terminal (Python 3)
			  25 KiB 	python3-zipp                  	pathlib-compatible Zipfile object wrapper - Python 3.x
			 509 KiB 	python3.8                     	Interactive high-level object-oriented language (version 3.8)
			5240 KiB 	python3.8-minimal             	Minimal subset of the Python language (version 3.8)
			  39 KiB 	qemu-efi                      	transitional dummy package
		  133162 KiB 	qemu-efi-aarch64              	UEFI firmware for 64-bit ARM virtual machines
			  79 KiB 	readline-common               	GNU readline and history libraries, common files
			 195 KiB 	resolvconf                    	name server information handler
			 137 KiB 	rfkill                        	tool for enabling and disabling wireless devices
			 672 KiB 	rsync                         	fast, versatile, remote (and local) file-copying tool
			1524 KiB 	rsyslog                       	reliable system and kernel logging daemon
			 328 KiB 	sed                           	GNU stream editor for filtering/transforming text
			  62 KiB 	sensible-utils                	Utilities for sensible alternative selection
			2648 KiB 	shared-mime-info              	FreeDesktop.org shared MIME database and spec
			 537 KiB 	sound-theme-freedesktop       	freedesktop.org sound theme
			 187 KiB 	sox                           	Swiss army knife of sound processing
			 112 KiB 	sshfs                         	filesystem client based on SSH File Transfer Protocol
			2124 KiB 	sudo                          	Provide limited super user privileges to specific users
		   14688 KiB 	systemd                       	system and service manager
			 176 KiB 	systemd-sysv                  	system and service manager - SysV links
			 234 KiB 	systemd-timesyncd             	minimalistic service to synchronize local time with NTP servers
			  62 KiB 	sysvinit-utils                	System-V-like utilities
			 884 KiB 	tar                           	GNU version of the tar archiving utility
			6071 KiB 	timgm6mb-soundfont            	TimGM6mb SoundFont from MuseScore 1.3
			3935 KiB 	tzdata                        	time zone and daylight-saving time data
			  46 KiB 	ubuntu-keyring                	GnuPG keys of the Ubuntu archive
			5591 KiB 	ubuntu-mono                   	Ubuntu Mono Icon theme
			 188 KiB 	ucf                           	Update Configuration File(s): preserve user changes to config files
			9071 KiB 	udev                          	/dev/ and hotplug management daemon
			4181 KiB 	util-linux                    	miscellaneous system utilities
			 168 KiB 	uuid-dev                      	Universally Unique ID library - headers and static libraries
			3069 KiB 	vim                           	Vi IMproved - enhanced vi editor
			 376 KiB 	vim-common                    	Vi IMproved - Common files
		   30766 KiB 	vim-runtime                   	Vi IMproved - Runtime files
			 913 KiB 	vulkan-tools                  	Miscellaneous Vulkan utilities
			   9 KiB 	vulkan-utils                  	transitional package
			 964 KiB 	wget                          	retrieves files from the web
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
			 159 KiB 	zlib1g                        	compression library - runtime
			 588 KiB 	zlib1g-dev                    	compression library - development
		```
