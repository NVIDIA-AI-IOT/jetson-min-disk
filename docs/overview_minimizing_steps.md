# Overview of Minimizing Steps

## Composition of JetPack

To understand what files and components are present on system, it helps to understand what composes what NVIDIA calls JetPack.
JetPack is composed of the underlying Linux based BSP, and all the NVIDIA software, SDKs like CUDA, cuDNN, TensorRT and some Jetson orinetned libraries.

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQRL973rup4vKwlFuY_gu0sXh336QACYg8kEAYs4XYggeh2ew1X0-TppZ5R8kHMoViCO-w-2jK3AqEC/pub?w=1078&amp;h=572">

The BSP comes with a sample Ubuntu-derived root filesystem, including the GUI desktop environment. You may choose to remove the GUI components if that’s not the requirement for your application/product.

JetPack components can be installed and managed using Debian package manager. You may find some sub packages that you don’t need for your application, like a documentation package, so that’s a good candidate to remove.  You can even go further to the file level to find a huge library to shave off even more disk usage.


## Varying Degree of Minimized Configurations

So there are varying degree of minimizing the disk usage on Jetson.
You can start your development in the original full JetPack configuration (Configuration `[A]`), and as you go through the development you may start trimming out what you don’t need for your applications. You may choose to leave some components for the convenience in the development phase, but eventually you can land on very minimized and deployment oriented configuration (Configuration `[D]`).

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQSLro30qGYa6ZJj-yHZC7Qj0G3Ti60tVlDyf7odtnF4IlYANN3e9tIdexgYdLDxbqRaJ96PYq_oq00/pub?w=1481&amp;h=684" alt="Diagram to show different minimal configurations">

Above diagram shows different configurations (bottom is more minimized and deployment oriented configuration), and actions you would perform to realize those confgiurations.
You can choose to take and not to take some actions, all depending on your application and development needs.

## Steps

### Step 1: Remove Desktop GUI 

If your application/product does not require a local display output for GUI, you can get rid of GUI applications (web browser, productivity suite, email clients, etc) as well as the whole desktop environment.

```
sudo apt-get update
sudo apt-get purge $(cat apt-packages-only-in-full.txt)
sudo apt-get install network-manager
sudo systemctl set-default multi-user
sudo reboot
```

### Step 2 : Remove Docs and Samples
If you know you don’t need some documentation and samples of CUDA and some NVIDIA frameworks on your local Jetson for development, you can easily remove them.

```
sudo dpkg -r --force-depends "cuda-documentation-10-2" "cuda-samples-10-2" "libnvinfer-samples" "libvisionworks-samples" "libnvinfer-doc" "vpi1-samples"
```

### Action 3 : Remove `dev` / Static Libraries
Once you are done with building your applications, you don’t need developement oriented packages or static libraries on the system.

```
sudo find / -name 'lib*_static.a' -delete
```

## Entry Points

Just like there can be multiple target configurations, there are multiple possible entry points you may start, depending on the type of Jetson hardware you have and flashing method you use.

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQSLro30qGYa6ZJj-yHZC7Qj0G3Ti60tVlDyf7odtnF4IlYANN3e9tIdexgYdLDxbqRaJ96PYq_oq00/pub?w=1481&amp;h=684" alt="Diagram to show different minimal configurations">

### Factory-flashed Devloper Kits → L4T BSP (Configuration `[a]`)

Developer kits like Jetson AGX Orin Developer Kit comes with its eMMC flash memory pre-flashed with L4T BSP image at the factory.
You can boot into Ubuntu Desktop right out of the box, so the default setup flow is that you connect your developer kits to the Internet, so you can just perform `apt install` in order to install JetPack components, as described in [Getting Started with Jetson AGX Orin Developer Kit](https://developer.nvidia.com/embedded/learn/get-started-jetson-agx-orin-devkit).

### Developer Kits with microSD Card → Full JetPack (configuration `[A]`)

For developer kits that takes a microSD card as a main storage, like Jetson Xavier NX Developer Kit, you would flash your microSD card with NVIDIA provides image that has the fully configured JetPack, that means you have the L4T BSP as well as all the JetPack components.

### SDK Manager to flash Jetson → L4T BSP (Configuration `[a]`)

Whatever Jetson you have, you can choose to run SDK Manager on your Linux PC to flash. If you have a production version of Jetson module, you need to flash your Jetson module as it does not come pre-flashed at the factory by NVIDIA.
The step for Jetson AGX Orin Developer Kit is described in [this section of online user guide](https://developer.nvidia.com/embedded/learn/jetson-agx-orin-devkit-user-guide/two_ways_to_set_up_software.html#1-how-to-use-sdk-manager-to-flash-l4t-bsp).

You can also use SDK Manager to go even further and install all the JetPack components using your Linux PC. This is handy when you cannot have your Jetson connected to the internet.
The step for Jetson AGX Orin Developer Kit is described in [this section of online user guide](https://developer.nvidia.com/embedded/learn/jetson-agx-orin-devkit-user-guide/two_ways_to_set_up_software.html#2-use-sdk-manager-to-install-jetpack-components).
In this case, you would get to full JetPack, Configuration `[A]`.

### L4T Flash Tool to flash Jetson → L4T BSP (Configuration `[a]`)

You can also use L4T Flash Tool on your Linux PC to flash Jetson. 
Unlike SDK Manager, L4T Flash Tool does not come with GUI, but offers more functionality when flashing and confgiuring Jetson.
The typical way of using L4T Flash Tool to just flash Jetson with the normal L4T BSP is described in the Quick Start section of L4T/Jetson Linux Developer Guide ([Rel-32.7.2 for JetPack 4.6.2](https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3271/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/quick_start.html#), [Rel-34.1 for JetPack 5.0](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/IN/QuickStart.html)).

### L4T Flash Tool to flash Jetson → “minimal” L4T BSP (Configuration `[b]`)

L4T Flash Tool  is a versatile tool, so you can use L4T Flash Tool to customize the Kernel and/or RootFS to suite your Jetson-based product’s needs. 

So you can use a script packed in L4T Flash Tool to generate a RootFS image with a minimal package setup, to flash “minimal” L4T BSP on Jetson.
You can use this super slim version L4T as a base to install all or some of the JetPack components (`[b]` → `[B]`).
