package com.vineyard.fastgit.app.utils

object NativeBridge {

    private val isLibraryLoaded: Boolean = try {
        System.loadLibrary("fastgit_native")
        true
    } catch (_: Throwable) {
        false
    }

    fun getOAuthClientId(): String =
        if (isLibraryLoaded) nativeGetOAuthClientId() else ""

    fun getOAuthClientSecret(): String =
        if (isLibraryLoaded) nativeGetOAuthClientSecret() else ""

    fun getContactEndpoint(): String =
        if (isLibraryLoaded) nativeGetContactEndpoint() else ""

    fun getAdMobBannerUnitId(): String =
        if (isLibraryLoaded) nativeGetAdMobBannerUnitId() else ""

    private external fun nativeGetOAuthClientId(): String
    private external fun nativeGetOAuthClientSecret(): String
    private external fun nativeGetContactEndpoint(): String
    private external fun nativeGetAdMobBannerUnitId(): String
}