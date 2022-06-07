# Step 2: Removing Docs and Samples Package

!!! example "Disk space regained in typical setup by removing docs/sample packages"

    | <img width=240/> | JetPack 5.0.1 DP<br>(Rel 34.1.1)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | 2. Removing Docs and<br>Sample Packages | **1.0 GB** | **1.1 GB** | **1.1 GB** |

If you have installed all the JetPack components (libraries and SDKs) all at once either with “sudo apt install nvidia-jetpack” command or using SDK Manager to install by simply selecting all to install, you are likely to have some packages that you don’t need for your application.

[Earlier analysis](./analysis.md#tree-command-output-filtered-by-disk-usage-size) of disk usage provides a good idea what component is taking up major parts of the disk space.

## Pre-check

First, check the size of installed packages that are either sample or documentation.

```
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(sample|doc)" 
```

!!! info "Example output of `dpkg-query` based list for sample and docs:"

    === ":material-numeric-4-box-multiple-outline: JetPack 4.6"

        ```
			6585 KiB 	cmake-data          	CMake data files (modules, templates and documentation)
		  338939 KiB 	cuda-documentation-1	CUDA documentation
		  207918 KiB 	cuda-samples-10-2   	CUDA example applications
		  160830 KiB 	docker.io           	Linux container runtime
			 143 KiB 	libavresample3      	FFmpeg compatibility library for resampling - runtime files
			2128 KiB 	libcudnn8-samples   	cuDNN documents and samples
			 211 KiB 	libhtml-parser-perl 	collection of modules that parse HTML text documents
		   15752 KiB 	libnvinfer-doc      	TensorRT documentation
		  548569 KiB 	libnvinfer-samples  	TensorRT samples
			 793 KiB 	libopencv-samples   	Samples for Open Source Computer Vision Library
			1468 KiB 	libsamplerate0      	Audio sample rate conversion library
			 129 KiB 	libsoxr0            	High quality 1D sample-rate conversion library
			 155 KiB 	libswresample2      	FFmpeg library for audio resampling, rematrixing etc. - runtime files
		   10191 KiB 	libx11-doc          	X11 client-side library (development documentation)
			 545 KiB 	libxml-twig-perl    	Perl module for processing huge XML documents in tree mode
			4791 KiB 	mesa-common-dev     	Developer documentation for Mesa
			  27 KiB 	nvidia-docker2      	nvidia-docker CLI wrapper
		   15145 KiB 	vpi1-samples        	NVIDIA VPI command-line sample applications
			 101 KiB 	xorg-sgml-doctools  	Common tools for building X.Org SGML documentation
        ```

    === ":material-numeric-5-box-multiple: JetPack 5.0.x DP"

        ```
			 378 KiB 	cuda-documentation-1	CUDA documentation
		  161640 KiB 	cuda-samples-11-4   	CUDA example applications
		  131139 KiB 	docker.io           	Linux container runtime
			 233 KiB 	libavresample-dev   	FFmpeg compatibility library for resampling - development files
			 152 KiB 	libavresample4      	FFmpeg compatibility library for resampling - runtime files
			2117 KiB 	libcudnn8-samples   	cuDNN samples
		   21460 KiB 	libglib2.0-doc      	Documentation files for the GLib library
		   15924 KiB 	libnvinfer-doc      	TensorRT documentation
		  536874 KiB 	libnvinfer-samples  	TensorRT samples
			1065 KiB 	libopencv-samples   	Open Computer Vision Library
			1468 KiB 	libsamplerate0      	Audio sample rate conversion library
			 149 KiB 	libsoxr0            	High quality 1D sample-rate conversion library
			 247 KiB 	libswresample-dev   	FFmpeg library for audio resampling, rematrixing etc. - development files
			 168 KiB 	libswresample3      	FFmpeg library for audio resampling, rematrixing etc. - runtime files
			  27 KiB 	nvidia-docker2      	nvidia-docker CLI wrapper
		   15169 KiB 	vpi2-samples        	NVIDIA VPI command-line sample applications
			 101 KiB 	xorg-sgml-doctools  	Common tools for building X.Org SGML documentation
        ```

## Commands to Copy for Removing Doc and Sample Packages

```
sudo dpkg -r --force-depends $(dpkg --list | grep -E -o 'cuda-documentation-[0-9\-]*') $(dpkg --list | grep -E -o 'cuda-samples-[0-9\-]*') "libnvinfer-doc" "libnvinfer-samples" "libvisionworks-samples" "vpi.-samples"
```
