# Usage

Run all commands from the root of this repository.  
Build docker container
```bash
sudo docker build --name openwrt-buildroot .
```

Run docker container
```bash
sudo docker run -ti --rm --name openwrt-buildroot --user openwrt -v ./bin:/home/openwrt/build/bin/ openwrt-buildroot bash
```

Create config

```bash
make defconfig
make menuconfig
```

Build, downloading all needed sources in advance to speed up the process by utilising multiple cores
```bash
make -j $(($(nproc)+1)) download
make -j $(($(nproc)+1)) world
```

Save config for reuse
```bash
./scripts/diffconfig.sh > bin/custom.config
```

Restore config
```bash
cp bin/custom.config .config
make defconfig
```

