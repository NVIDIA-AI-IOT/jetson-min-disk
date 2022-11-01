# jetson-min-disk

Document generation status: ![example workflow](https://github.com/NVIDIA-AI-IOT/jetson-min-disk/actions/workflows/ci.yml/badge.svg)

This repo is to host the online guide for minimizing Jetson disk usage, and to host the associated scripts and assets.

## Full Documentation 
https://nvidia-ai-iot.github.io/jetson-min-disk/

## About this repo

This repo is host two things;

1. Online documentation "Guide to Minimizing Jetson Disk Usage".
2. Scripts and text files being referenced in the guide, and supported files and directories.

## How to use scripts

### `prepare_l4t_dir.sh`

See ["Minimized L4T" configuration for JetPack 5.x page](https://nvidia-ai-iot.github.io/jetson-min-disk/jp5_minimal-l4t.html). 


## How to use this repo for docs

### Mkdocs: Initial setup

https://squidfunk.github.io/mkdocs-material/getting-started/

```
sudo apt install -y docker.io
sudo docker pull squidfunk/mkdocs-material
```

### Mkdocs: Start development server on http://localhost:8000

```bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material
```

> If you get "docker: Got permission denied while trying to connect to the Docker daemon socket at ..." error, 
> issue `sudo chmod 666 /var/run/docker.sock` to get around with the issue.

### Mkdocs: To locally build the HTML site

```bash
docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build
```
