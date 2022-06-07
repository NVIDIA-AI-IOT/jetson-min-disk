# Verification

It is a good idea to have a way to verify your minimally configured Jetson environment. The specification greatly varies depending on your application needs.

Here, we present one way to use NVIDIA DeepStream reference app as a typical AI application to verify the minimally configured Jetson environment.

## DeepStream Reference App

### For JetPack 4.6

The matching DeepStream version for JetPack4.6.x is DeepStream 6.0.x, as explained in the [“Platform and OS Compatibility” section](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_Quickstart.html#platform-and-os-compatibility) of DeepStream SDK Developer Guide

#### Pre-setup

For the convenience of setting up and removal, we use a DeepStream Docker container built for Jetson. It is hosted on NGC, so you can simply pull the built container image.

To ensure the Docker environment is setup, first make sure you have nvidia runtime is setup.

```
jetson@xnx4-jp461:~$ cat /etc/docker/daemon.json 
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

Also execute the followings to ensure Docker service is running.

```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

#### For running an offline processing sample

You can execute the following without introducing a custom config file.

```
cd
mkdir _output
sudo docker run -it --rm --net=host --runtime nvidia -w /opt/nvidia/deepstream/deepstream -v /tmp/.X11-unix/:/tmp/.X11-unix -v ${PWD}/_output:/opt/nvidia/deepstream/deepstream/_output nvcr.io/nvidia/deepstream-l4t:6.0-samples bash -c "deepstream-app -c samples/configs/deepstream-app/source2_1080p_dec_infer-resnet_demux_int8.txt; cp out_*.mp4 ./_output/"
```

It takes a couple of minutes to build the TensorRT engines and process two video files.
Once finished, you should find two mp4 files under _output directory.

#### For running an Overlay display output sample;

This requires a custom config file for the DeepStream reference app, so it is easiest to use a script.

```
git clone https://github.com/NVIDIA-AI-IOT/jetson-min-disk/
cd jetson-min-disk
cd test-docker
./docker-run-deepstream-app-overlay.sh
```

DeepStream for Jetson has a capability to output using Tegra’s [“overlay”](https://docs.nvidia.com/metropolis/deepstream/5.0DP/dev-guide/index.html#page/DeepStream_Development_Guide/deepstream_app_config.3.2.html#wwpID0ENHA) display method, which does not rely on X11.

So if you have the fbconsole on your HDMI display, you should see the processed output on screen like this.

![](./images/DS-Container-Overlay.gif)

#### Size of Docker container image

The above command and script pulls the deepstream-l4t:6.0-sample container image from NGC, and it is about 1.8GB.

```
jetson@xnx6-jp461:~$ sudo docker image ls
[sudo] password for jetson: 
REPOSITORY                      TAG                   IMAGE ID       CREATED         SIZE
nvcr.io/nvidia/deepstream-l4t   6.0-samples           1e08ebd4f227   7 months ago    1.78GB
```

#### Container Image Removal

Once you complete the verification using the DeepStream reference app, you can delete the DeepStream container image to free up space.

```
sudo docker image rm nvcr.io/nvidia/deepstream-l4t:6.0-samples
```

### For JetPack 5.0

The matching DeepStream version for JetPack5.0.x DP is DeepStream 6.1, again as explained in the [“Platform and OS Compatibility” section](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_Quickstart.html#platform-and-os-compatibility) of DeepStream SDK Developer Guide.

As explained in the [“A Docker Container for Jetson” section](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_docker_containers.html#a-docker-container-for-jetson), the DeepStream 6.1 container no longer expects CUDA, TensorRT to be installed on the Jetson device, because it is included within the container image. Therefore, such “fat” container cannot be effectively used for verifying the minimally configured host Jetson setup.

However, if you are developing DeepStream application on JetPack 5.0 using Docker container, there is other recommended method to save space on Jetson, that is to set up your host Jetson only with BSP and NVIDIA Container runtime.

Read [“Recommended Minimal L4T Setup necessary to run the new docker images on Jetson” section](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_docker_containers.html#recommended-minimal-l4t-setup-necessary-to-run-the-new-docker-images-on-jetson) to learn more.

