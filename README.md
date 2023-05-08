# Build

https://risc-v-getting-started-guide.readthedocs.io/en/latest/linux-qemu.html#

In busybox; make install for a static binary (menuconfig Settings/Build Options). This will create an `_install` sub-folder.
```
CROSS_COMPILE=riscv64-linux-gnu- make defconfig
CROSS_COMPILE=riscv64-linux-gnu- make menuconfig   
CROSS_COMPILE=riscv64-linux-gnu- make -j $(nproc)
CROSS_COMPILE=riscv64-linux-gnu- make install
```

See also: https://gist.github.com/chrisdone/02e165a0004be33734ac2334f215380e

./mkinitramfs.sh

./runqemu.sh

## Exit qemu
Ctrl a x

## More examples
See src/
