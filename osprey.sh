KERNEL_DIR=$PWD
CCACHEDIR=/home/ccache
Anykernel_DIR=$KERNEL_DIR/Anykernel2/osprey
TOOLCHAINDIR=$(pwd)/toolchain/linaro-7.2
DATE=$(date +"%d%m%Y")
KERNEL_NAME="HybridX-Kernel"
DEVICE="-osprey-"
VER="-v69"
TYPE="-OREO"
FINAL_ZIP="$KERNEL_NAME""$DEVICE""$DATE""$TYPE""$VER".zip

export ARCH=arm
export KBUILD_BUILD_USER="Aki"
export KBUILD_BUILD_HOST="69"
export CROSS_COMPILE=$TOOLCHAINDIR/bin/arm-eabi-
export USE_CCACHE=1
export CCACHE_DIR=$CCACHEDIR

make osprey_defconfig
make -j$( nproc --all )

echo "Kernel compilation completed"

cp $KERNEL_DIR/arch/arm/boot/zImage $Anykernel_DIR/
cd $Anykernel_DIR
echo "Making Flashable zip"
zip -r9 $FINAL_ZIP * -x *.zip $FINAL_ZIP
echo "Flashable zip Created"
echo "Flashable zip is stored in Anykernel folder"
