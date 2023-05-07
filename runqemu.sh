sudo qemu-system-riscv64 -nographic -machine virt \
 -kernel linux/arch/riscv/boot/Image -append "root=/dev/vda ro console=ttyS0" \
 -drive file=busybox/busybox,format=raw,id=hd0 \
 -device virtio-blk-device,drive=hd0 \
 -initrd initramfs.cpio.gz
