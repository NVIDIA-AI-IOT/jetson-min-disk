# Step 1: Removing GUI

!!! example "Disk space regained in typical setup by removing GUI"

    | <img width=240/> | JetPack 5.0.1 DP<br>(Rel 34.1.1)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | 1. Removing GUI | **3.4 GB** | **3.3 GB** | **3.2 GB** |

You can remove some of the packages included in the base BSP, L4T/Jetson Linux. There are some productivity applications like LibreOffice suite and Thunderbird email client (and they take up more than 200MB as seen in the previous section), you can safely remove them. 

You can even remove `ubuntu-desktop` if you know your system does not require GUI on Jetson’s native display output (via HDMI, DP/eDP, or LVDS).

## Commands to Copy for Removing GUI

### Uninstalling packages only found in "desktop" package list.

=== ":material-numeric-4-box-multiple-outline: JetPack 4.6.x"

    Download [nvubuntu-bionic-packages_only-in-desktop.txt](https://github.com/NVIDIA-AI-IOT/jetson-min-disk/blob/main/assets/nvubuntu-bionic-packages_only-in-desktop.txt).

    ```
    sudo apt-get update
    sudo apt-get purge $(cat nvubuntu-bionic-packages_only-in-desktop.txt) 
    sudo apt-get install network-manager
    ```

=== ":material-numeric-5-box-multiple: JetPack 5.0.x DP"

    Download [nvubuntu-focal-packages_only-in-desktop.txt](https://github.com/NVIDIA-AI-IOT/jetson-min-disk/blob/main/assets/nvubuntu-focal-packages_only-in-desktop.txt).

    ```
    sudo apt-get update
    sudo apt-get purge $(cat nvubuntu-focal-packages_only-in-desktop)
    sudo apt-get install network-manager
    ```

!!! warning 

    Make sure to install `network-manager` back (or not to remove in the first place).

    Removing `network-manager` and rebooting will result in having the network interface (`eth0`) not up the next time the system boots up, so you won't be able to remotely SSH into it.


### Re-installing JetPack Components

```
sudo apt install nvidia-jetpack
sudo apt clean
sudo rm -rf /var/cuda-repo-l4t-10-2-local
```

The above `*_only-in-desktop.txt` file is derived by subtracting the minimal package list from the full/desktop package list for rootfs that you can find them in L4T Flashing Tool. The minimal package list does not include essential build tools like “build-essential”, so it would remove some of the JetPack components if they have dependencies on them. 
So you would need to perform the following to make sure you have everything of JetPack components.

And if you start from the base BSP (Configuration: `[a]`), with above commands you only get to the minimal L4T configuration (Configuration: `[b]`), so you want to install the JetPack components anyway to get to “Full JetPack without GUI” configuration (Configuration: `[B]`).

