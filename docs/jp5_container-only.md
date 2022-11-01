# "nvidia-container only" configuration for JetPack 5.x

If you are on JetPack 5.0.2 and above, and if you plan to run your application(s) inside a docker container, you can choose to install jest the `nvidia-container` package to be able to run containers on your Jetson.

!!! quote ""

    ```
    sudo apt install nvidia-container
    ```

!!! example "Disk space used for JetPack Runtime configuration"

    | <img width=240/> | JetPack 5.0.2<br>(Rel 35.1.0)<br>Jetson AGX Orin<br>Developer Kit | JetPack 5.0.2<br>(Rel 35.1.0)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 5.0.2<br>(Rel 35.1.0)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | *Base L4T* | 5.6 GB | nnn GB | 5.6 GB  |
    | `nvidia-container` on L4T | {==5.9 GB==} | {==nnn GB==} | {==5.9 GB==} |
    | *JetPack Full* | 16.6 GB | nnn GB | nnn GB |

## Step 1. Flash L4T

Flash your Jetson with just the regular L4T (Jetson Linux).

See [this section](./jp5_jetpack-runtime.md#step-1-flash-l4t) of the former page for the detailed steps.

## Step 2. Install `nvidia-container`

After flashing is done, boot your Jetson, complete the initial setup (OEM-config) flow if necessary.

Once ready, with Internet connection secured, execute the following.

```
sudo apt update
sudo apt install nvidia-container
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker
```

## Done - Verification

Check [Verification (JP5) page](./jp5_verification.md).

## How to build Docker container with CUDA and other SDKs

Refer to this [Dockerfile](https://gitlab.com/nvidia/container-images/l4t-jetpack/-/blob/master/Dockerfile.jetpack) of `l4t-jetpack` container ([NGC link](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-jetpack)) to learn how you can build a Docker container and install NVIDIA SDKs inside the container.

## Tips

!!! tip "Move Docker data directory to USB drive" 

    You may want to expand your storage anyway if you have multiple container images on your Jetson.

    One solution is to add a USB thumb drive to your Jetson and configure Docker daemon to use the USB drive as the data directory, to store all the overlay files. 

    [https://www.guguweb.com/2019/02/07/how-to-move-docker-data-directory-to-another-location-on-ubuntu/](https://www.guguweb.com/2019/02/07/how-to-move-docker-data-directory-to-another-location-on-ubuntu/)


