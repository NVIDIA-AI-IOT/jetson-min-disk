# Step 3: Removing `dev` Packages / Static Libraries

!!! example "Disk space regained in typical setup by removing `dev` packages / Static Libraries"

    | <img width=240/> | JetPack 5.0.1 DP<br>(Rel 34.1.1)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | 3. Removing Static Libraries | **4.9 GB** | **2.3 GB** | **2.3 GB** |

Once you are done with building your applications, you don’t need those `dev` packages that contains static libraries and header files.

## Pre-check: Static Libraries

To find some of the big static libraries installed on the system, you can use a command like the following.

```
sudo find / -name 'lib*_static*.a' | tr '\n' '\0' | du -sch --files0-from=-
```

??? info ":material-numeric-4-box-multiple-outline: Example Output on JetPack 4.6.2"

    ```
    jetson@jax5-jp462:~/$ sudo find / -name 'lib*_static*.a' | tr '\n' '\0' | du -sch --files0-from=-
    find: ‘/run/user/1000/gvfs’: Permission denied
    find: ‘/run/user/120/gvfs’: Permission denied
    14M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppial_static.a
    888K    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libmetis_static.a
    28K     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppc_static.a
    5.5M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppicc_static.a
    11M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnpps_static.a
    143M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcusparse_static.a
    119M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcusolver_static.a
    3.1M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppitc_static.a
    93M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcublas_static.a
    23M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppist_static.a
    56M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppif_static.a
    12K     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppisu_static.a
    161M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnvgraph_static.a
    35M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcublasLt_static.a
    201M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft_static_nocallback.a
    60M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcurand_static.a
    1.1M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppicom_static.a
    8.0M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/liblapack_static.a
    11M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppidei_static.a
    30M     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppig_static.a
    32K     /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufftw_static.a
    7.1M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libnppim_static.a
    868K    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcudart_static.a
    184M    /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft_static.a
    2.0M    /usr/lib/aarch64-linux-gnu/libnvonnxparser_static.a
    4.5M    /usr/lib/aarch64-linux-gnu/libnvparsers_static.a
    0       /usr/lib/aarch64-linux-gnu/libcudnn_static.a
    346M    /usr/lib/aarch64-linux-gnu/libnvinfer_static.a
    18M     /usr/lib/aarch64-linux-gnu/libnvinfer_plugin_static.a
    811M    /usr/lib/aarch64-linux-gnu/libcudnn_static_v8.a
    2.3G    total
    ```

??? info  ":material-numeric-5-box-multiple: Example Output on JetPack 5.0.1 DP"

    ```
	jetson@jax6-jp501dp:~$ sudo find / -name 'lib*_static*.a' | tr '\n' '\0' | du -sch --files0-from=-
	[sudo] password for jetson: 
	find: ‘/run/user/1000/gvfs’: Permission denied
	find: ‘/run/user/124/gvfs’: Permission denied
	18M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnvptxcompiler_static.a
	202M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcusolver_static.a
	203M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcublas_static.a
	206M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcufft_static.a
	179M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcufft_static_nocallback.a
	11M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppidei_static.a
	78M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcurand_static.a
	28K     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppc_static.a
	15M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppial_static.a
	3.5M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppitc_static.a
	1.1M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcudart_static.a
	32K     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcufftw_static.a
	245M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcusparse_static.a
	6.1M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppicc_static.a
	35M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppist_static.a
	18M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnpps_static.a
	35M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppig_static.a
	480M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libcublasLt_static.a
	12K     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppisu_static.a
	16M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/liblapack_static.a
	79M     /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppif_static.a
	7.7M    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libnppim_static.a
	888K    /usr/local/cuda-11.4/targets/aarch64-linux/lib/libmetis_static.a
	95M     /usr/lib/aarch64-linux-gnu/libcudnn_ops_infer_static.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_adv_train_static_v8.a
	2.1M    /usr/lib/aarch64-linux-gnu/libnvonnxparser_static.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_cnn_infer_static_v8.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_ops_infer_static_v8.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_adv_infer_static_v8.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_ops_train_static_v8.a
	1.1G    /usr/lib/aarch64-linux-gnu/libcudnn_cnn_infer_static.a
	30M     /usr/lib/aarch64-linux-gnu/libnvinfer_plugin_static.a
	107M    /usr/lib/aarch64-linux-gnu/libcudnn_adv_train_static.a
	0       /usr/lib/aarch64-linux-gnu/libcudnn_cnn_train_static_v8.a
	4.6M    /usr/lib/aarch64-linux-gnu/libnvparsers_static.a
	75M     /usr/lib/aarch64-linux-gnu/libcudnn_ops_train_static.a
	150M    /usr/lib/aarch64-linux-gnu/libcudnn_cnn_train_static.a
	1.2G    /usr/lib/aarch64-linux-gnu/libnvinfer_static.a
	158M    /usr/lib/aarch64-linux-gnu/libcudnn_adv_infer_static.a
	4.6G    total
    ```

## Pre-check: Find `dev` packages

To list NVIDIA derived `dev` packages.

```
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)"
```

To get the total Installed-size of listed packages.

```
dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | awk '{sum+=$1}END{print sum/1024 " MiB";}'
```


??? info ":material-numeric-4-box-multiple-outline: Example Output on JetPack 4.6.2"

    ```
	jetson@jax5-jp462:~$ dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)"
	   15632 KiB    cuda-cudart-dev-10-2            CUDA Runtime native dev links, headers
		1044 KiB    cuda-cupti-dev-10-2             CUDA profiling tools interface.
		 122 KiB    cuda-driver-dev-10-2            CUDA Driver native dev stub library
		   7 KiB    cuda-libraries-dev-10-2         CUDA Libraries 10.2 development meta-package
	  164305 KiB    cuda-nvgraph-dev-10-2           NVGRAPH native dev links, headers
		 475 KiB    cuda-nvml-dev-10-2              NVML native dev links, headers
		 107 KiB    cuda-nvrtc-dev-10-2             NVRTC native dev links, headers
	  130285 KiB    libcublas-dev                   CUBLAS native dev links, headers
	  829842 KiB    libcudnn8-dev                   cuDNN development libraries and headers
	  393794 KiB    libcufft-dev-10-2               CUFFT native dev links, headers
	   62406 KiB    libcurand-dev-10-2              CURAND native dev links, headers
	  130310 KiB    libcusolver-dev-10-2            CUDA solver native dev links, headers
	  146509 KiB    libcusparse-dev-10-2            CUSPARSE native dev links, headers
	  354308 KiB    libnvinfer-dev                  TensorRT development libraries and headers
	   17787 KiB    libnvinfer-plugin-dev           TensorRT plugin libraries
		2606 KiB    libnvonnxparsers-dev            TensorRT ONNX libraries
		4571 KiB    libnvparsers-dev                TensorRT parsers libraries
		  10 KiB    python3-libnvinfer-dev          Python 3 development package for TensorRT
		 506 KiB    vpi1-dev                        NVIDIA VPI C/C++ development library and headers
    jetson@jax5-jp462:~$ 
    jetson@jax5-jp462:~$ dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | awk '{sum+=$1}END{print sum/1024 " MiB";}'
    2201.78 MiB
    ```

??? info ":material-numeric-5-box-multiple: Example Output on JetPack 5.0.1 DP"

    ```
    jetson@jax6-jp501dp:~$ dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" 
		4963 KiB    cuda-cudart-dev-11-4            CUDA Runtime native dev links, headers
		1308 KiB    cuda-cupti-dev-11-4             CUDA profiling tools interface.
		 131 KiB    cuda-driver-dev-11-4            CUDA Driver native dev stub library
		   7 KiB    cuda-libraries-dev-11-4         CUDA Libraries 11.4 development meta-package
		 559 KiB    cuda-nvml-dev-11-4              NVML native dev links, headers
		 117 KiB    cuda-nvrtc-dev-11-4             NVRTC native dev links, headers
	  699018 KiB    libcublas-dev-11-4              CUBLAS native dev links, headers
		 111 KiB    libcudla-dev-11-4               CUDLA native dev links, headers
	 1718597 KiB    libcudnn8-dev                   cuDNN development libraries and headers
	  393703 KiB    libcufft-dev-11-4               CUFFT native dev links, headers
	   81676 KiB    libcurand-dev-11-4              CURAND native dev links, headers
	  223245 KiB    libcusolver-dev-11-4            CUDA solver native dev links, headers
	  251151 KiB    libcusparse-dev-11-4            CUSPARSE native dev links, headers
	 1157390 KiB    libnvinfer-dev                  TensorRT development libraries and headers
	   29878 KiB    libnvinfer-plugin-dev           TensorRT plugin libraries
		2759 KiB    libnvonnxparsers-dev            TensorRT ONNX libraries
		4730 KiB    libnvparsers-dev                TensorRT parsers libraries
		  10 KiB    python3-libnvinfer-dev          Python 3 development package for TensorRT
		 654 KiB    vpi2-dev                        NVIDIA VPI C/C++ development library and headers
	jetson@jax6-jp501dp:~$ 
	jetson@jax6-jp501dp:~$ dpkg-query -Wf '${Installed-Size;8} KiB \t${Package;-30}\t${binary:Summary}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)" | awk '{sum+=$1}END{print sum/1024 " MiB";}'
	4462.9 MiB
    ```

## Commands to Copy for Removing `dev` packages

```
sudo dpkg -r --force-depends $(dpkg-query -Wf '${Package}\n' | grep -E "(cuda[^ ]+dev|libcu[^ ]+dev|libnv[^ ]+dev|vpi[^ ]+dev)")
```

## Commands to Copy for Removing Static Libraries

??? warning 

	It is recommended to use the above `dpkg -r` command to use the package manager to remove the package rather than manually removing individual library files.

    If you perform the following command, always perform the above `sudo find / -name 'lib*_static*.a'` command first to make sure the filter does not include the unintended files.

    ```
    sudo find / -name 'lib*_static*.a' -delete
    ```

## Reference

You can reference a Docker file like the following to learn some strategy/technics for making production oriented environment.

[https://github.com/tensorflow/serving/blob/master/tensorflow_serving/tools/docker/Dockerfile.devel-gpu](https://github.com/tensorflow/serving/blob/master/tensorflow_serving/tools/docker/Dockerfile.devel-gpu) 

## Extra

### Nsight System (for JetPack 5.x)

Starting from JetPack 5.0 Developer Preview, The NVIDIA Nsight Systems host application can be installed on Jetson.
However if you plan to use your host PC to run the application to remotely profile Jetson, this is another candidate to be uninstalled.

!!! info "Example Output of the `tree` Command for `/opt/` Directory on JetPack 5.0.1 DP"

	```
	jetson@jao3-jp501:~$ sudo bash -c "cd /opt; tree --du  -h  | grep -E \"\[[0-9]*M]|G]\""
	├── [861M]  nvidia
	│   ├── [724M]  nsight-systems
	│   │   └── [724M]  2022.2.3
	│   │       ├── [472M]  host-linux-armv8
	│   │       │   ├── [234M]  libQt6WebEngineCore.so.6
	│   │       ├── [115M]  target-linux-sbsa-armv8
	│   │       └── [116M]  target-linux-tegra-armv8
	│   └── [121M]  vpi2
	└── [279M]  ota_package
		├── [165M]  t19x
		└── [114M]  t23x
	```

```
sudo dpkg -r --force-depends nsight-systems-2022.2.3
```