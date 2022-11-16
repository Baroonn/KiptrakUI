android_armv7 {
    CONFIG += android-clang
    CONFIG += COMPILER_CLANG
    ANDROID_TARGET_ARCH = armeabi-v7a
    message(PLATFORM_ANDROID)
}

CONFIG(debug, release|debug) {
CONFIG += BUILD_DEBUG
message(BUILD_DEBUG)
} else {
CONFIG += BUILD_RELEASE
message(BUILD_RELEASE)
}
