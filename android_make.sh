#!/bin/bash
export ANDROID_NDK=/opt/android-ndk # or your Android NDK root directory
export CC=${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc
export CCOPT="-O2 -fpic --sysroot=/opt/android-ndk/platforms/android-16/arch-arm -DANDROID -DOS_ANDROID"
export CFLAGS="--sysroot=${ANDROID_NDK}/platforms/android-16/arch-arm -DANDROID -DOS_ANDROID"
export LDFLAGS="--sysroot=${ANDROID_NDK}/platforms/android-16/arch-arm -fPIC -mandroid -L${ANDROID_NDK}/platforms/android-16/arch-arm/usr/lib"
./configure --host=arm-linux --with-pcap=linux --prefix=${ANDROID_NDK}/platforms/android-16/arch-arm/usr
make
