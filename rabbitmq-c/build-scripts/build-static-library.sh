#!/usr/bin/env bash

#This script builds the static library of the rabbitmq-c library (https://github.com/alanxz/rabbitmq-c/releases).
#As of the time of writing v0.5.0 builds successfully.
#Libraries for different architectures are merged into a single .a file with lipo.
#Supported architectures are i386 x86_64 armv7 armv7s arm64 and the weight of the output file is about 1.3 Mb.

echo "Will build i386 rabbitmq-c library for iOS Simulator"
make clean

./configure --host=i386-apple-darwin --with-ssl=no --enable-static \
  CC="/usr/bin/clang -arch i386" \
  LD=$DEVROOT/usr/bin/ld

make
lipo -info librabbitmq/.libs/librabbitmq.a
mv librabbitmq/.libs/librabbitmq.a librabbitmq.a.i386

echo "Will build x86_64 rabbitmq-c library for iOS Simulator"
make clean

./configure --host=x86_64-apple-darwin --with-ssl=no --enable-static \
  CC="/usr/bin/clang -arch x86_64" \
  LD=$DEVROOT/usr/bin/ld

make
lipo -info librabbitmq/.libs/librabbitmq.a
mv librabbitmq/.libs/librabbitmq.a librabbitmq.a.x86_64

echo "Will build armv7 rabbitmq-c library for iOS Devices"
make clean

DEVROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
SDKROOT=$DEVROOT/SDKs/iPhoneOS7.0.sdk
./configure --host=armv7-apple-darwin --enable-static --with-ssl=no \
  CC="/usr/bin/clang -arch armv7" \
  CPPFLAGS="-I$SDKROOT/usr/include/" \
  CFLAGS="$CPPFLAGS -pipe -no-cpp-precomp -isysroot $SDKROOT" \
  LD=$DEVROOT/usr/bin/ld

make
lipo -info librabbitmq/.libs/librabbitmq.a
mv librabbitmq/.libs/librabbitmq.a librabbitmq.a.armv7

echo "Will build armv7s rabbitmq-c library for iOS Devices"
make clean

DEVROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
SDKROOT=$DEVROOT/SDKs/iPhoneOS7.0.sdk
./configure --host=armv7s-apple-darwin --enable-static --with-ssl=no \
  CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch armv7s" \
  CPPFLAGS="-I$SDKROOT/usr/include/" \
  CFLAGS="$CPPFLAGS -pipe -no-cpp-precomp -isysroot $SDKROOT" \
  LD=$DEVROOT/usr/bin/ld

make
lipo -info librabbitmq/.libs/librabbitmq.a
mv librabbitmq/.libs/librabbitmq.a librabbitmq.a.armv7s

echo "Will build arm64 rabbitmq-c library for iOS Devices"
make clean

DEVROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
SDKROOT=$DEVROOT/SDKs/iPhoneOS7.0.sdk
./configure --host=arm-apple-darwin --enable-static --with-ssl=no \
  CC="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch arm64" \
  CPPFLAGS="-I$SDKROOT/usr/include/" \
  CFLAGS="$CPPFLAGS -pipe -no-cpp-precomp -isysroot $SDKROOT" \
  LD=$DEVROOT/usr/bin/ld

make
lipo -info librabbitmq/.libs/librabbitmq.a
mv librabbitmq/.libs/librabbitmq.a librabbitmq.a.arm64

echo "Will merge libs"

DEVROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
$DEVROOT/usr/bin/lipo -arch i386 librabbitmq.a.i386 -arch x86_64 librabbitmq.a.x86_64 -arch armv7 librabbitmq.a.armv7 -arch armv7s librabbitmq.a.armv7s -arch arm64 librabbitmq.a.arm64 -create -output librabbitmq.a
file librabbitmq.a
$DEVROOT/usr/bin/lipo -info librabbitmq.a
