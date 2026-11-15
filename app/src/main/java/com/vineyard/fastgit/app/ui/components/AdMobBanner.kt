package com.vineyard.fastgit.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.viewinterop.AndroidView
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.compose.LocalLifecycleOwner
import com.google.android.gms.ads.AdRequest
import com.google.android.gms.ads.AdSize
import com.google.android.gms.ads.AdView
import com.vineyard.fastgit.app.utils.NativeBridge

@Composable
fun AdMobBanner(
    modifier: Modifier = Modifier,
    adUnitId: String? = null
) {
    if (LocalInspectionMode.current) {
        return
    }

    val context = LocalContext.current
    val lifecycleOwner = LocalLifecycleOwner.current
    val screenWidthDp = LocalConfiguration.current.screenWidthDp.coerceAtLeast(320)

    val resolvedAdUnitId = remember(adUnitId) {
        adUnitId ?: NativeBridge.getAdMobBannerUnitId()
    }

    val adSize = remember(screenWidthDp) {
        AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(context, screenWidthDp)
    }

    val adView = remember(resolvedAdUnitId, adSize) {
        AdView(context).apply {
            this.adUnitId = resolvedAdUnitId
            setAdSize(adSize)
            loadAd(AdRequest.Builder().build())
        }
    }

    DisposableEffect(lifecycleOwner, adView) {
        val observer = LifecycleEventObserver { _, event ->
            when (event) {
                Lifecycle.Event.ON_RESUME -> adView.resume()
                Lifecycle.Event.ON_PAUSE -> adView.pause()
                else -> Unit
            }
        }
        lifecycleOwner.lifecycle.addObserver(observer)
        onDispose {
            lifecycleOwner.lifecycle.removeObserver(observer)
            adView.destroy()
        }
    }

    Box(
        modifier = modifier
            .fillMaxWidth()
            .wrapContentHeight()
            .background(MaterialTheme.colorScheme.surface),
        contentAlignment = Alignment.Center
    ) {
        AndroidView(
            factory = { adView },
            modifier = Modifier
                .fillMaxWidth()
                .wrapContentHeight()
        )
    }
}