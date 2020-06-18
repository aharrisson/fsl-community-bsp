# Docker image for Yocto fsl-community-bsp

## How to use this image

### Creating a new project

```
$ docker run --rm -ti -v $(pwd):/opt/yocto/fsl-community-bsp/wandboard -e MACHINE=wandboard -e DISTRO=poky andersharrisson/fsl-community-bsp /bin/bash -c "source setup-environment wandboard"
```

### Building a project

```
$ docker run --rm -ti -v $(pwd):/opt/yocto/fsl-community-bsp/wandboard -e MACHINE=wandboard -e DISTRO=poky andersharrisson/fsl-community-bsp /bin/bash -c "source setup-environment wandboard; bitbake core-image-minimal"
```
