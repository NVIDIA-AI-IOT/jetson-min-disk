#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DIR=$(realpath $SCRIPT_DIR/../)

L4T_USERNAME="jetson"
L4T_PASSWORD="jetson"

l4t_pkg_subset_flag=false
custom_rootfs=false

set -e

function usage()
{
	if [ -n "${1}" ]; then
		echo "${1}"
	fi

	echo "Usage:"
	echo "  ${script_name} -b <board> -j <jp_version> "
	echo "	-b | --board	- Supported are 'jetson-agx-orin-devkit', 'jetson-agx-xavier-devkit', 'jetson-xavier-nx-devkit'."
	echo "	-v | --version	- Supported are '35.1.0'/'5.0.2'."
	echo "	-r | --rfspkg   - If using pre-built RootFS package file placed under ./downloads dir"
	echo "	-f | --flavor   - If building custom flavor RootFS, specify the package list"
	echo "	-l | --l4tpkg   - If only installing selected nvidia-l4t-* packages, specify the subset list name"
	echo "	-h | --help - print usage"
	echo "Example:"
	echo "  ${script_name} -b jetson-agx-orin-devkit -v r35.1.0 --flavor minimal"
	echo "  ${script_name} -b jetson-xavier-nx-devkit -v 5.0.2  --flavor bone300 --l4tpkg k8"
	exit 1
}

function parse_args()
{
	while [ -n "${1}" ]; do
		case "${1}" in
		-h | --help)
			usage
			;;
		-b | --board)
			[ -n "${2}" ] || usage || echo "ERROR: Not enough parameters"
			board="${2}"
			shift 2
			;;
		-v | --version)
			[ -n "${2}" ] || usage || echo "ERROR: Not enough parameters"
			l4t_jp_version="${2}"
			shift 2
			;;
		-r | --rfspkg)
			[ -n "${2}" ] || usage || echo "ERROR: Not enough parameters"
			custom_rfs_pkg="${2}"
			shift 2
			;;
		-f | --flavor)
			[ -n "${2}" ] || usage || echo "ERROR: Not enough parameters"
			flavor="${2}"
			shift 2
			;;
		-l | --l4tpkg)
			[ -n "${2}" ] || usage || echo "ERROR: Not enough parameters"
			l4t_pkg_subset="${2}"
			shift 2
			;;
		*)
			echo "ERROR: Invalid parameter. Exiting..."
			usage
			exit 1
			;;
		esac
	done

    if [ "${board}" == "" ]; then
		echo "ERROR: Invalid board name" > /dev/stderr
		usage
	else
		case "${board}" in
		jetson-agx-orin-devkit)
			boardid="3701"
			target="jetson-agx-orin-devkit"
            tgt="jao"
            tnum="T234"
			;;
		jetson-agx-xavier-devkit)
			boardid="2822"
			target="jetson-agx-xavier-devkit"
            tgt="jax"
            tnum="T194"
			;;
		jetson-xavier-nx-devkit)
			boardid="3668"
			target="jetson-xavier-nx-devkit"
            tgt="xnx"
            tnum="T194"
			;;
		*)
			usage "Unknown board: ${board}"
			;;
		esac
	fi

    if [ "${l4t_jp_version}" == "" ]; then
		echo "ERROR: Invalid JetPack version" > /dev/stderr
		usage
    else
		case "${l4t_jp_version}" in
            5.0.2 | 5.02 | 502 | 5-0-2 | 35.1.0 | r35.1.0 | 3510 | r3510)
                jetpack="5.0.2"
                jpnum="502"
                l4t_ver="R35.1.0"
                l4tnum="r3510"
                ;;
            *)
                usage "Unknown/Non-supported JetPack version: ${jetapck}"
                ;;
		esac
    fi
	
	rfs_package_list=""
	if [ -z ${custom_rfs_pkg+x} ]; then
		if [ -z ${flavor+x} ]; then
			### Case 1: No "-r" option, no "-f" option --> Use the standard Sample-Root-Filesystem package file
			RFS_PACKAGE=$DIR/downloads/Tegra_Linux_Sample-Root-Filesystem_${l4t_ver}_aarch64.tbz2\(temp\) #temp
			rfs_name="-gui"
		else
			if [ -f $DIR/rfs_flavors/nvubuntu-focal-${flavor}-aarch64-packages ]; then
				### Case 2: Only "-f" option --> Use the specified custom flavor rootfs package list file to generate RootFS
				rfs_name="-${flavor}"
				rfs_package_list=$DIR/rfs_flavors/nvubuntu-focal-${flavor}-aarch64-packages
				RFS_PACKAGE="(to-be-generated)"
			else
				echo "[ERROR] Specified custom RootFS package file does not exists under ./downloads dir."
				echo "    '${custom_rfs_pkg}'"
				ls -l $DIR/downloads/*.tbz2
				exit 1
			fi
		fi
	else
		if [ -f $DIR/${custom_rfs_pkg} ]; then
			### Case 3.1: "-r" option ("-f" option ignored even if provided) --> Use the specified prebuilt RootFS package file
			RFS_PACKAGE=$DIR/${custom_rfs_pkg} 
			#rfs_name="-${custom_rfs_pkg%.*}"
			tbz_tgt=$( echo "${custom_rfs_pkg##*/}" | sed 's|rfs_\(.*\)-JP[0-9]*-.*\.tbz2|\1|' )
			tbz_jpnum=$( echo "${custom_rfs_pkg##*/}" | sed 's|rfs_.*-JP\([0-9]*\)-.*\.tbz2|\1|' )
			echo "====[Case3.1]===> tbz_tgt: $tbz_tgt"
			echo "====[Case3.1]===> tbz_jpnum: $tbz_jpnum"
			echo "====[Case3.1]===> tgt: $tgt"
			echo "====[Case3.1]===> jpnum: $jpnum"
			if [ "$tbz_tgt" = "$tgt" ] && [ "$tbz_jpnum" = "$jpnum" ]; then
				rfs_name="-$( echo "${custom_rfs_pkg##*/}" | sed 's|rfs_.*-JP[0-9]*-\(.*\)\.tbz2|\1|' )"
				echo "====[Case3.1]===> rfs_name: $rfs_name"
			else
				echo "[ERROR] RFS package file speicified with '-r' / '--rfspkg' does not match."
				exit 1
			fi
		elif [ -f $DIR/downloads/${custom_rfs_pkg} ]; then
			### Case 3.2: "-r" option ("-f" option ignored even if provided) --> Use the specified prebuilt RootFS package file
			RFS_PACKAGE=$DIR/downloads/${custom_rfs_pkg} 
			#rfs_name="-${custom_rfs_pkg%.*}"
			tbz_tgt=$( echo "$custom_rfs_pkg" | sed 's|rfs_\(.*\)-JP[0-9]*-.*\.tbz2|\1|' )
			tbz_jpnum=$( echo "$custom_rfs_pkg" | sed 's|rfs_.*-JP\([0-9]*\)-.*\.tbz2|\1|' )
			echo "====[Case3.2]===> tbz_tgt: $tbz_tgt"
			echo "====[Case3.2]===> tbz_jpnum: $tbz_jpnum"
			if [ "$tbz_tgt" = "$tgt" ] && [ "$tbz_jpnum" = "$jpnum" ]; then
				rfs_name="-$( echo "${custom_rfs_pkg##*/}" | sed 's|rfs_.*-JP[0-9]*-\(.*\)\.tbz2|\1|' )"
				echo "====[Case3.2]===> rfs_name: $rfs_name"
			else
				echo "[ERROR] RFS package file speicified with '-r' / '--rfspkg' does not match."
				exit 1
			fi
		else
			echo "[ERROR] Specified custom RootFS package file does not exists under ./downloads dir."
			echo "    '${custom_rfs_pkg}'"
			ls -l $DIR/downloads/*.tbz2
			exit 1
		fi
	fi

	l4t_package_list=""
	echo $l4t_pkg_subset
	if [ -z ${l4t_pkg_subset+x} ]; then
		echo ">>> No -l / --l4t_pkg selected:"
		l4t_package_list=${DIR}/l4t_pkg_lists/l4t_all.list
	else
		ls -lh ${DIR}/l4t_pkg_lists/l4t_${l4t_pkg_subset}.list
		if [ -f ${DIR}/l4t_pkg_lists/l4t_${l4t_pkg_subset}.list ]; then
			### Case : "-l" option and file exists --> Use the specified custom l4t package list file to install in RootFS
			l4t_package_list=${DIR}/l4t_pkg_lists/l4t_${l4t_pkg_subset}.list
			l4t_pkg_subset_flag=true
			l4t_subset_tag="-${l4t_pkg_subset}"
		else
			echo "[ERROR] Specified custom L4T package list file does not exists under ./rfs_l4t_package dir."
			echo "    '${l4t_pkg_subset}'"
			ls -l $DIR/rfs_l4t_package/*.list
			exit 1
		fi
	fi

}

script_name="$(basename "${0}")"
parse_args "${@}"

L4T_HOSTNAME="${tgt}-JP${jpnum}${rfs_name}${l4t_subset_tag}"
L4T_DIR_NAME=Linux_for_Tegra_${tgt}-${l4tnum}-JP${jpnum}${rfs_name}${l4t_subset_tag}
L4T_DIR=$DIR/${L4T_DIR_NAME}

echo "| L4T version is $l4t_ver ('$l4tnum')"
echo "| JetPack version is $jetpack ('$jpnum')"
echo "| Specified board is $board ('$tgt')"
echo "|"
echo "| L4T_HOSTNAME:  $L4T_HOSTNAME"
echo "| L4T_USERNAME:  $L4T_USERNAME"
echo "| L4T_PASSWORD:  $L4T_PASSWORD"
echo "|"
echo "| DIR:     $DIR"
echo "| L4T_DIR: $L4T_DIR"
echo "|"
echo "| RFS flavor: $flavor"
echo "| rfs_name:   $rfs_name"
echo "| RFS_pkg:    $RFS_PACKAGE"
echo "| l4t_package_list: $l4t_package_list"
echo "| l4t_pkg_subset_flag: $l4t_pkg_subset_flag"
echo "|"

# Start from ./jetson-self-flash-tool/
cd $DIR
sudo date

# Keep updating the existing sudo time stamp
sudo -v
while true; do sudo -n true; sleep 120; kill -0 "$$" || exit; done 2>/dev/null &

echo ${L4T_DIR} > ${DIR}/LAST_L4T_DIR

###########################################
###   Step 1.  Download package files   ###
###########################################
echo " "
echo " ############################################################ "
echo " # Step 1. Download L4T package files "
echo " ############################################################ "

if [ "$l4t_ver" = "R35.1.0" ] | [ "$jetpack" = "5.0.2" ]; then
	# L4T r35.1.0 (JP5.0.2 GA)
	URL_L4T_PKG=https://developer.nvidia.com/embedded/l4t/r35_release_v1.0/release/jetson_linux_r35.1.0_aarch64.tbz2
	URL_RFS_PKG=https://developer.nvidia.com/embedded/l4t/r35_release_v1.0/release/tegra_linux_sample-root-filesystem_r35.1.0_aarch64.tbz2
	FILENAME_L4T=${URL_L4T_PKG##*/}
	FILENAME_L4T_ARG="${FILENAME_L4T%.*}"_${l4tnum}-JP${jpnum}-${tnum}."${FILENAME_L4T##*.}"
	FILENAME_RFS=${URL_RFS_PKG##*/}
	FILENAME_RFS_ARG="${FILENAME_RFS%.*}"_${l4tnum}-JP${jpnum}-${tnum}."${FILENAME_RFS##*.}"
fi

if [ -f $DIR/downloads/${FILENAME_L4T_ARG} ]; then
    echo "[INFO] ${FILENAME_L4T_ARG} is alredy downloaded."
else
    wget ${URL_L4T_PKG} -P $DIR/downloads/ -q --show-progress
    mv $DIR/downloads/$FILENAME_L4T $DIR/downloads/${FILENAME_L4T_ARG} 
fi
export L4T_RELEASE_PACKAGE=$DIR/downloads/${FILENAME_L4T_ARG} 
echo ">>> L4T_RELEASE_PACKAGE : ${L4T_RELEASE_PACKAGE}"

if [ "${rfs_name=}" == "-gui" ]; then
    if [ -f $DIR/downloads/${FILENAME_RFS_ARG} ]; then
        echo "[INFO] ${FILENAME_RFS_ARG} is already downloaded."
    else
        wget ${URL_RFS_PKG} -P $DIR/downloads/ -q --show-progress
        mv $DIR/downloads/$FILENAME_RFS $DIR/downloads/${FILENAME_RFS_ARG} 
    fi
    export RFS_PACKAGE=$DIR/downloads/${FILENAME_RFS_ARG}
    echo ">>> RFS_PACKAGE : ${RFS_PACKAGE}"
fi

################################################################################
###   Step 2.  Create ./Linux_for_Tegra/ and ./Linux_for_Tegra/rootfs dir    ###
################################################################################
echo " "
echo " ############################################################ "
echo " # Step 2. Creating 'Linux_for_Tegra' directory "
echo " ############################################################ "

if [ -d $L4T_DIR ]; then
	echo "[WARN] $L4T_DIR_NAME directory already exists.  Deleting contents."
	sudo rm -rf $L4T_DIR
fi
if [ "${generate_rootfs}" = true ] && [ -d $L4T_DIR ]; then
	echo "[WARN] $L4T_DIR_NAME directory already exists.  Deleting contents."
	sudo rm -rf $L4T_DIR
fi

cd $DIR
if [ -d ./Linux_for_Tegra ]; then
	echo "[WARN] Delete the incomplete Linux_for_Tegra dir"
	sudo rm -rf ./Linux_for_Tegra
fi
echo ">>> Going to unpack $L4T_RELEASE_PACKAGE ..."
tar xpf ${L4T_RELEASE_PACKAGE}
ls
mv Linux_for_Tegra $L4T_DIR_NAME
ls
cd $L4T_DIR/rootfs/
#sudo rm -rf $L4T_DIR/rootfs/*
echo "-----> RFS_PACKAGE: ${RFS_PACKAGE}"
echo "----->              ${L4T_DIR}/tools/samplefs/sample_fs.tbz2"
if [ "${RFS_PACKAGE}" != "(to-be-generated)" ]; then
	echo ">>> Going to unpack $RFS_PACKAGE ..."
	echo "sudo tar xpf ${RFS_PACKAGE}"
	sudo tar xpf ${RFS_PACKAGE}
else
	echo " " 
	echo " ********************************************************** " 
	echo " * Going to rebuilt rootfs using nv_build_samplefs.sh ..."
	echo " ********************************************************** " 
	sudo apt-get -y update
	sudo apt-get install -y docker.io
	echo ">>> cp $SCRIPT_DIR/build_rfs_custom.sh ${L4T_DIR}"
	cp $rfs_package_list ${L4T_DIR}/tools/samplefs/
	cp $SCRIPT_DIR/build_rfs_custom.sh ${L4T_DIR}
	ls ${L4T_DIR}
	echo "sudo docker run --privileged --rm --network host \
					-v ${L4T_DIR}:/l4t ubuntu:20.04 \
					/l4t/build_rfs_custom.sh ${flavor}"
	sudo docker run --privileged --rm --network host \
					-v ${L4T_DIR}:/l4t ubuntu:20.04 \
					/l4t/build_rfs_custom.sh ${flavor}

	RFS_PACKAGE=${L4T_DIR}/tools/samplefs/sample_fs.tbz2
	echo ">>> RFS_PACKAGE = ${RFS_PACKAGE}"
	ls -l ${RFS_PACKAGE}

	cd ${L4T_DIR}/rootfs/
	sudo rm -rf ./*/
	sudo tar xpf ${RFS_PACKAGE}
	echo ">>> RootFS dir re-built"
	sudo du -hs ${L4T_DIR}/rootfs/

	mv -f ${RFS_PACKAGE} ${DIR}/downloads/rfs_${tgt}-JP${jpnum}${rfs_name}.tbz2
fi
cd ${L4T_DIR}
echo ">>> Going to excute ./apply_binaries.sh ..."

if [ "${l4t_pkg_subset_flag}" = true ]; then 

	echo ">>> Shaving off some requirements from nvidia-l4t-* packages ..."

	# NVBug 3783861
	cd ${L4T_DIR}
	fakeroot sh -c "
		mkdir tmp_deb_core
		dpkg-deb -R ${L4T_DIR}/nv_tegra/l4t_deb_packages/nvidia-l4t-core_35.1.0-20220810203728_arm64.deb tmp_deb_core
		sed -i 's|libegl1,||g' tmp_deb_core/DEBIAN/control
		sed -i 's|,libegl1||g' tmp_deb_core/DEBIAN/control
		sed -i 's|libegl1||g' tmp_deb_core/DEBIAN/control
		dpkg-deb -b tmp_deb_core ${L4T_DIR}/nv_tegra/l4t_deb_packages/nvidia-l4t-core_35.1.0-20220810203728_arm64.deb
		rm -rf tmp_deb
	"
	fakeroot sh -c "
		mkdir tmp_deb_cuda
		dpkg-deb -R ${L4T_DIR}/nv_tegra/l4t_deb_packages/nvidia-l4t-cuda_35.1.0-20220810203728_arm64.deb tmp_deb_cuda
		sed -i 's|,\ nvidia-l4t-3d-core\ (.*)||g' tmp_deb_cuda/DEBIAN/control
		echo '################## ${L4T_DIR}/nv_tegra/l4t_deb_packages/nvidia-l4t-cuda_35.1.0-20220810203728-no3dcore_arm64.deb'
		dpkg-deb -b tmp_deb_cuda ${L4T_DIR}/nv_tegra/l4t_deb_packages/nvidia-l4t-cuda_35.1.0-20220810203728-no3dcore_arm64.deb
		rm -rf tmp_deb
	"

	###
	### ./bootloader/ --> /opt/nvidia/l4t-packages/bootloader/
	###
	if [ -d ${L4T_DIR}/bootloader_not-to-install ]; then
		echo "[INFO] ${L4T_DIR}/bootloader_not-to-install already exists."
	else
		mkdir ${L4T_DIR}/bootloader_not-to-install
	fi
	# Keep only the nvidia-l4t-* "bootloader" packages that's found in ${l4t_package_list} (./l4t_pkg_lists/l4t_<>.list file)
	DEB_FILES="${L4T_DIR}/bootloader/*.deb"
	for f in $DEB_FILES
	do
		echo "--- Orig deb file: $f"
		l4t_pkg_name=$( echo "$f" | sed 's/.*nvidia-l4t-\(.*\)_.*\_.*\.deb/nvidia-l4t-\1/' )
		echo "--- l4t_pkg_name:  ${l4t_pkg_name}"
		
		echo "if grep -F \"$l4t_pkg_name\" ${l4t_package_list}"
		if grep -F "$l4t_pkg_name" ${l4t_package_list}
		then
			echo ">>> KEEP! : $l4t_pkg_name"
		else
			echo "find \"${L4T_DIR}/bootloader/\" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' \"${L4T_DIR}/bootloader_not-to-install\" \;
"
			find "${L4T_DIR}/bootloader/" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' "${L4T_DIR}/bootloader_not-to-install" \;
		fi
	done

	###
	### ./kernel/ --> /opt/nvidia/l4t-packages/kernel/
	###
	if [ -d ${L4T_DIR}/kernel_not-to-install ]; then
		echo "[INFO] ${L4T_DIR}/kernel_not-to-install already exists."
	else
		mkdir ${L4T_DIR}/kernel_not-to-install
	fi
	# Keep only the nvidia-l4t-* "kernel" packages that's found in ${l4t_package_list} (./l4t_pkg_lists/l4t_<>.list file)
	DEB_FILES="${L4T_DIR}/kernel/*.deb"
	for f in $DEB_FILES
	do
		echo "--- Orig deb file: $f"
		l4t_pkg_name=$( echo "$f" | sed 's/.*nvidia-l4t-\(.*\)_.*\_.*\.deb/nvidia-l4t-\1/' )
		echo "--- l4t_pkg_name:  ${l4t_pkg_name}"
		
		echo "if grep -Fxq \"$l4t_pkg_name\" ${l4t_package_list}"
		if grep -Fxq "$l4t_pkg_name" ${l4t_package_list}
		then
			echo ">>> KEEP! : $l4t_pkg_name"
		else
			echo "find \"${L4T_DIR}/kernel/\" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' \"${L4T_DIR}/kernel_not-to-install\" \;
"
			find "${L4T_DIR}/kernel/" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' "${L4T_DIR}/kernel_not-to-install" \;
		fi
	done

	sudo cp -v ${DIR}/patches/patch_Linux_for_Tegra/nv_tegra/nv-apply-debs.sh ${L4T_DIR}/nv_tegra/

	###
	### ./nv_tegra/l4t_deb_package/ --> /opt/nvidia/l4t-packages/userspace/
	### 
	if [ -d ${L4T_DIR}/nv_tegra/l4t_deb_packages_not-to-install ]; then
		echo "[INFO] ${L4T_DIR}/nv_tegra/l4t_deb_packages_orig already exists."
	else
		mkdir ${L4T_DIR}/nv_tegra/l4t_deb_packages_not-to-install
	fi
	# Keep only the nvidia-l4t-* "userspace" packages that's found in ${l4t_package_list} (./l4t_pkg_lists/l4t_<>.list file)
	DEB_FILES="${L4T_DIR}/nv_tegra/l4t_deb_packages/*.deb"
	for f in $DEB_FILES
	do
		echo "--- Orig deb file: $f"
		l4t_pkg_name=$( echo "$f" | sed 's/.*nvidia-l4t-\(.*\)_.*\_.*\.deb/nvidia-l4t-\1/' )
		echo "--- l4t_pkg_name:  ${l4t_pkg_name}"
		
		echo "if grep -Fxq \"$l4t_pkg_name\" ${l4t_package_list}"
		if grep -Fxq "$l4t_pkg_name" ${l4t_package_list}
		then
			echo ">>> KEEP! : $l4t_pkg_name"
		else
			echo "find \"${L4T_DIR}/nv_tegra/l4t_deb_packages/\" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' \"${L4T_DIR}/nv_tegra/l4t_deb_packages_not-to-install\" \;
"
			find "${L4T_DIR}/nv_tegra/l4t_deb_packages/" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' "${L4T_DIR}/nv_tegra/l4t_deb_packages_not-to-install" \;
		fi
	done

	###
	### ./tools/ --> /opt/nvidia/l4t-packages/standalone/
	### 
	if [ -d ${L4T_DIR}/tools_not-to-install/ ]; then
		echo "[INFO] ${L4T_DIR}/tools_orig/ already exists."
	else
		mkdir ${L4T_DIR}/tools_not-to-install/
	fi
	# Among "standalone" packages found under ./tools/ dir (jetson-gpio-common, python-jetson-gpio, python3-jetson-gpio), 
	#keep only the one found in ./l4t_pkg_lists/l4t_<>.list file
	DEB_STANDALONE_FILES="${L4T_DIR}/tools/*.deb"
	for f in $DEB_STANDALONE_FILES
	do
		echo "--- Orig deb file: $(basename $f)"
		l4t_pkg_name=$( echo "$(basename $f)" | sed 's|\(.*\)_.*\_.*\.deb|\1|' )
		echo "--- l4t_pkg_name:  ${l4t_pkg_name}"

		echo "if grep -Fxq \"$l4t_pkg_name\" ${l4t_package_list}"
		if grep -Fxq "$l4t_pkg_name" ${l4t_package_list}
		then
			echo ">>> KEEP! : $l4t_pkg_name"
		else
			echo "find \"${L4T_DIR}/tools/\" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' \"${L4T_DIR}/tools_not-to-install/\" \;"
			find "${L4T_DIR}/tools/" -maxdepth 1 -type f -name ${l4t_pkg_name}*.deb -exec mv -v '{}' "${L4T_DIR}/tools_not-to-install/" \;
		fi
	done

fi # [ "${l4t_pkg_subset_flag}" = true ] 

echo ">>> ### sudo ./apply_binaries.sh --debug"
sudo ./apply_binaries.sh --debug


##################################################################
###   Step 3.  Set hostname in ./Linux_for_Tegra/rootfs/ dir   ###
##################################################################
echo " "
echo " ############################################################"
echo " # Step 3. Set hostname in ./Linux_for_Tegra/rootfs dir   ###"
echo " ############################################################"

echo "# Going to create the default user ($DEFAULT_USERNAME) ..."

echo ">>> sudo ${L4T_DIR}/tools/l4t_create_default_user.sh -u ${L4T_USERNAME} -p ${L4T_PASSWORD} -n ${L4T_HOSTNAME} --accept-license --autologin"
sudo ${L4T_DIR}/tools/l4t_create_default_user.sh -u ${L4T_USERNAME} -p ${L4T_PASSWORD} -n ${L4T_HOSTNAME} --accept-license --autologin


echo " ********************************************************** " 
echo " * Linux_for_Tegra dir prepared: "
echo " *   ${L4T_DIR} "
echo " ********************************************************** " 

echo ${L4T_DIR} > ${DIR}/LAST_L4T_DIR

date
