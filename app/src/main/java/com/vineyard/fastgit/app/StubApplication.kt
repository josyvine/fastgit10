package com.vineyard.fastgit.app

import android.app.Application

/**
 * Standard Application class for FastGit.
 * Preserves the StubApplication entry point referenced by AndroidManifest.xml and ProGuard rules
 * without dynamic DEX loading or hidden-API reflection for Google Play Store compliance.
 */
class StubApplication : Application() {

    override fun onCreate() {
        super.onCreate()
    }
}