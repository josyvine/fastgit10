#include <jni.h>
#include <cstddef>
#include <cstdint>
#include <string>

namespace {
    constexpr uint8_t kMask[4] = {0x3C, 0x7A, 0x55, 0xA9};

    std::string decode(const uint8_t* data, size_t len) {
        std::string out(len, '\0');
        for (size_t i = 0; i < len; ++i) {
            out[i] = static_cast<char>(data[i] ^ kMask[i & 3]);
        }
        return out;
    }
}

extern "C" {

JNIEXPORT jstring JNICALL
Java_com_vineyard_fastgit_app_utils_NativeBridge_nativeGetOAuthClientId(
        JNIEnv* env,
        jobject /* thiz */) {
    static const uint8_t kData[] = {
        0x73, 0x0C, 0x67, 0x9A, 0x50, 0x13, 0x3F, 0xFC, 0x59, 0x08,
        0x61, 0xF1, 0x7F, 0x03, 0x3A, 0xEE, 0x58, 0x17, 0x23, 0xDE
    };
    const std::string value = decode(kData, sizeof(kData));
    return env->NewStringUTF(value.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_vineyard_fastgit_app_utils_NativeBridge_nativeGetOAuthClientSecret(
        JNIEnv* env,
        jobject /* thiz */) {
    static const uint8_t kData[] = {
        0x5A, 0x1B, 0x26, 0xDD, 0x5B, 0x13, 0x21, 0xF6, 0x53, 0x1B,
        0x20, 0xDD, 0x54, 0x25, 0x34, 0xD9, 0x4C, 0x25, 0x26, 0xCC,
        0x5F, 0x08, 0x30, 0xDD
    };
    const std::string value = decode(kData, sizeof(kData));
    return env->NewStringUTF(value.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_vineyard_fastgit_app_utils_NativeBridge_nativeGetContactEndpoint(
        JNIEnv* env,
        jobject /* thiz */) {
    static const uint8_t kData[] = {
        0x54, 0x0E, 0x21, 0xD9, 0x4F, 0x40, 0x7A, 0x86, 0x5A, 0x15,
        0x27, 0xC4, 0x4F, 0x0A, 0x27, 0xCC, 0x59, 0x54, 0x3C, 0xC6,
        0x13, 0x1C, 0x7A, 0xD1, 0x45, 0x00, 0x30, 0xC7, 0x50, 0x1B,
        0x3A
    };
    const std::string value = decode(kData, sizeof(kData));
    return env->NewStringUTF(value.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_vineyard_fastgit_app_utils_NativeBridge_nativeGetAdMobBannerUnitId(
        JNIEnv* env,
        jobject /* thiz */) {
    static const uint8_t kData[] = {
        0x5F, 0x1B, 0x78, 0xC8, 0x4C, 0x0A, 0x78, 0xD9, 0x49, 0x18,
        0x78, 0x9B, 0x0E, 0x48, 0x66, 0x91, 0x0C, 0x49, 0x61, 0x99,
        0x09, 0x4E, 0x65, 0x9A, 0x0B, 0x48, 0x62, 0x86, 0x09, 0x43,
        0x67, 0x9A, 0x09, 0x4F, 0x6C, 0x9B, 0x0D, 0x4E
    };
    const std::string value = decode(kData, sizeof(kData));
    return env->NewStringUTF(value.c_str());
}

}