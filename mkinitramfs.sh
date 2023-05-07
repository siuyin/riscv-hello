rm -rf initramfs
mkdir -p initramfs
cp init initramfs
chmod +x init

cd initramfs
mkdir -p bin sbin etc proc sys usr/bin usr/sbin
cp -a ../busybox/_install/* .

cp ../hello .

find . -print0 | cpio --null -ov --format=newc \
	| gzip -9 > ../initramfs.cpio.gz
