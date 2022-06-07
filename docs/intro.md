# Introduction

## "Initial" Disk Usage on Jetson: With Full JetPack

Jetson provides flexible storage options/configuration for development, but some of the Jetson modules are equipped with a limited eMMC flash memory storage size for more cost-conscious, large-scale product deployment.

It may initially seem impossible to fit your applications and necessary libraries in the limited storage space, especially with the full set of JetPack, BSP and all the development that NVIDIA has pre-packaged for Jetson.

!!! example ""

    | <img width=240/> | JetPack 5.0.1 DP<br>(Rel 34.1.1)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | (Original) Regular L4T (`[a]`) | 6.1 GB | 5.5 GB |   |
    | (Original) Full JetPack (`[A]`)  | {==16.6 GB==} | {==11.6 GB==} | {==11.6GB==} |


However you can cut down on disk usage by removing unnecessary packages, libraries and other assets. The following table illustrates how you can reclaim more than 8 GB of storage space on some of the latest JetPack versions.

!!! example ""

    | <img width=240/> | JetPack 5.0.1 DP<br>(Rel 34.1.1)<br>Jetson AGX Orin<br>Developer Kit | JetPack 4.6.2<br>(Rel 32.7.2)<br>Jetson AGX Xavier<br>Developer Kit | JetPack 4.6.1<br>(Rel 32.7.1)<br>Jetson Xavier NX<br>Developer Kit |
    |---|--:|--:|--:|
    | (Original) Full JetPack (`[A]`)  | {==16.6 GB==} | {==11.6 GB==} | {==11.6GB==} |
    | Example Deployment Configuration (`[D]`) | 8.3 GB | 5.2 GB | 5.3 GB  |
    | **Reduction (`[A]` → `[D]`)** | **{++8.3 GB++}** | **{++6.4 GB++}** | **{++6.3 GB++}**  |

This guide details steps to minimize the disk usage on your Jetson, while sharing tips on analyzing disk usage, actual commands, and the example outputs on different versions of JetPack, so that you can assess how you can further optimize the disk usage for your application.

We also shows how to check if an AI application is still working functionally under the slimmed-down configuration.



!!! tips 
    ## For Development, Expand Storage
    First, if it is possible on your system and especially if this is at your development phase, it is highly recommended to consider just adding more storage space to your Jetson.
    <br>It would not only give you more storage space, but it may also provide faster disk access, so your development speed can be accelerated.

    Options of your additional storage vary depending on your Jetson Developer Kit (and the custom carrier board design, if you are developing one).

    |   | NVMe SSD | USB Mass-Storage Device | microSD Card |
    |---|:-:|:-:|:-:|
    | Jetson AGX Orin<br>Developer Kit | Yes<br>(Recommended) | Yes | Yes |
    | Jetson AGX Xavier<br>Developer Kit | Yes<br>(Recommended) | Yes | Yes |
    | Jetson Xavier NX<br>Developer Kit | Yes<br>(Recommended) | Yes | n/a |
    | Jetson Nano<br>Developer Kit |  | Yes | n/a |

    ### Benchmark

    To access your added storage’s access speed, you can do something like this.

    ```
    fio -filename=test2g -direct=1 -rw=read -bs=1M -size=2G -numjobs=64 -runtime=10 -group_reporting -name=file1
    fio -filename=test2g -direct=1 -rw=write -bs=1M -size=2G -numjobs=64 -runtime=10 -group_reporting -name=file1
    ```

    ### Graph 
    
    Example graph of read/write speed per storage medium recorded on Jetson AGX Orin Developer Kit with JetPack 5.0.1 Developer Preview

    <iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSgyRt-YN1hzP_I4Q9cJpRKY_4teGDi3OxL5oYtjGCgVo9idRPFhIwGkcDyQQTYbzocYGSr74YwvrKt/pubchart?oid=1732700168&amp;format=interactive"></iframe>