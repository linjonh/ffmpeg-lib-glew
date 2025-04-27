function buildGlew() {
    if [ $1 ] ; then
        export NDK=/home/linj/Android/Sdk/ndk/26.1.10909125
        export HOST_TAG=linux-x86_64 # Mac用户为darwin-x86_64, Windows用户为windows-x86_64
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
        export API=24
        ARCH=aarch64 # arm64-v8a对应的ARCH为aarch64
        CPU=arm64
    else 
        ARCH=$2 # arm64-v8a对应的ARCH为aarch64
        CPU=$3
        API=$4
    fi
    export TARGET=$ARCH-linux-android

    # export CC=$TOOLCHAIN/bin/$TARGET$API-clang
    # export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
    
    PREFIX=$5
    FFCC=$6
    FFCXX=$7
    i=0
    for param in "$@";
    do
        echo $i=$param
        let i++ 
    done
    # cd glew
    # ${MAKE_EXECUTABLE} testDir GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX CC=$FFCC LD=$FFCXX

    #编译auto目录下的
    cd auto
    echo ">>>>  ${MAKE_EXECUTABLE}"completed build for
    ${MAKE_EXECUTABLE} clean && ${MAKE_EXECUTABLE} -j$(nproc)

    #glew目录下编译
    system_config=linux-clang-egl-android
    echo ">>>> cd ../"
    cd ../ && pwd
    ${MAKE_EXECUTABLE} clean
    echo ">>>> ${MAKE_EXECUTABLE} SYSTEM=${system_config} GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX CC=$FFCC LD=$FFCXX" -j$(nproc)
    ${MAKE_EXECUTABLE} SYSTEM=${system_config} GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX CC=$FFCC LD=$FFCXX -j$(nproc)
    echo ">>>> ${MAKE_EXECUTABLE} install GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX" CC=$FFCC LD=$FFCXX -j$(nproc)
    ${MAKE_EXECUTABLE} install GLEW_PREFIX=$PREFIX GLEW_DEST=$PREFIX CC=$FFCC LD=$FFCXX -j$(nproc)

}

echo "buildGlew command shell file"
