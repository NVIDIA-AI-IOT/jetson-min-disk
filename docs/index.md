# Guide to Minimizing Jetson Disk Usage

!!! note "News"

    2022-11-01: Updated with JetPack 5.x specific contents, which is covered in [JetPack 5 webinar series](https://gateway.on24.com/wcc/experience/elitenvidiabrill/1407606/3944300/jetpack-502).


![](./images/feature-image_available-disk-image-transition.png)

This online guide explains ways to minimize Jetson's disk/storage usage, while sharing tips and actual commands to analyze the disk usage to further optimize the storage usage.

## Steps to Minimize

This guide details various steps to minimize the disk usage on your Jetson, while sharing tips on analyzing disk usage, actual commands, and the example outputs on different versions of JetPack.

## Example Result

The amount of disk space you can save varies based on the configuration you choose to take and also on the JetPack and L4T versions.

!!! info "Example on Jetson AGX Orin with JetPack 5.0.2"

    | <img width=200/> | Disk Space Used | Available Space | Available Percentage |
    |---|--:|--:|--:|
    | Full JetPack | 16.6 GB | **38 GB** | 30%  |
    | Base L4T | 5.6 GB | **49 GB** | 11% |
    | **Minimized L4T** | {==682 MB==} | {==**54 GB**==} | {==1.2%==} |

!!! info "Example on Jetson Xavier NX production module with JetPack 4.6.2"

    | <img width=200/> | Disk Space Used | Available Space | Available Percentage |
    |---|--:|--:|--:|
    | (Original) Full JetPack (`[A]`)  | 11.6 GB | **1.9 GB** | 13.3 % |
    | CUI configuration (`[B]`)        | 8.4 GB | **4.7 GB** | 32.7 % |
    | Packages removed (`[D]`)      | 6.0 GB | **8.5 GB** | 55.9 %  |

## Verification

It will also demonstrate a way to verify the minimized set up by using a DeepStream reference application as an example AI application.

![](./images/DS-Container-Overlay.gif)
