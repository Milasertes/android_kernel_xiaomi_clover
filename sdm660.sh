starttime=`date +'%Y-%m-%d %H:%M:%S'`

git submodule update --init --recursive
export PATH=/home/milasertes/clang/bin:${PATH}
make O=out ARCH=arm64 clover_defconfig -j$(nproc --all) LLVM=1
make LLVM=1 -j$(nproc --all) O=out \ARCH=arm64 \CC=/home/milasertes/clang/bin/clang \
	CROSS_COMPILE=/home/milasertes/clang/bin/aarch64-linux-gnu- \
	CROSS_COMPILE_ARM32=/home/milasertes/clang/bin/arm-linux-gnueabi- \
	CROSS_COMPILE_COMPAT=/home/milasertes/clang/bin/arm-linux-gnueabi- \
	OBJCOPY=/home/milasertes/clang/bin/llvm-objcopy \
	OBJDUMP=/home/milasertes/clang/bin/llvm-objdump \
	STRIP=/home/milasertes/clang/bin/llvm-strip \
	NM=/home/milasertes/clang/bin/llvm-nm \
	AR=/home/milasertes/clang/bin/llvm-ar 2>&1 | tee kernel.log\

endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo 开始时间：$starttime
echo 结束时间：$endtime
echo "本次Kernel编译用时： "$((end_seconds-start_seconds))"s"
