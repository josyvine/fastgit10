# ===================================================================
# 1. Anti-Debugging, Package Flattening & Metadata Stripping
# ===================================================================

# Strip all standard Android system Logcat calls from release bytecode
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
    public static *** println(...);
}

# Flatten all obfuscated classes into a single short package and allow access optimization
-repackageclasses 'o'
-allowaccessmodification

# Obfuscate source file names (replaces all original .kt/.java file names with 'SourceFile' in decompilers)
-renamesourcefileattribute 'SourceFile'

# Strip local variables and parameter names so decompilers only see p0, p1, v0
# Keeps LineNumberTable so AppLogger can generate stack traces without failing
-keepattributes SourceFile,LineNumberTable,!LocalVariableTable,!LocalVariableTypeTable,!MethodParameters

# Preserve required annotations and generic signatures
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# ===================================================================
# 2. Application Entry Components
# ===================================================================

-keep class com.vineyard.fastgit.app.StubApplication {
    public <init>();
}
-keep class * extends android.app.Application
-keep class * extends android.app.Activity
-keep class * extends androidx.core.content.FileProvider

# ===================================================================
# 3. Model Serialization & Networking (Moshi, Retrofit, & OkHttp)
# ===================================================================

# Moshi JSON adapters, Kotlin metadata, and model classes
-keep class kotlin.Metadata { *; }
-keepclassmembers class * {
    @com.squareup.moshi.Json *;
}
-keep class com.vineyard.fastgit.app.models.** { *; }
-keepclassmembers class com.vineyard.fastgit.app.models.** { *; }
-keep class * extends com.squareup.moshi.JsonAdapter
-keep class com.squareup.moshi.** { *; }

# Network response data classes used by Retrofit/Moshi
-keep class com.vineyard.fastgit.app.network.WorkflowRunJobsResponse { *; }
-keep class com.vineyard.fastgit.app.network.WorkflowJob { *; }
-keep class com.vineyard.fastgit.app.network.WorkflowStep { *; }

# Retrofit service interfaces, proxy methods, and OkHttp streams
-keep class retrofit2.** { *; }
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}
-keep class okhttp3.** { *; }

# Coil Image Loader
-keep class coil.** { *; }

# ===================================================================
# 4. Database & Cryptographic Libraries (Room & LazySodium / JNA)
# ===================================================================

# Room database abstractions, entities, and DAOs
-keep class androidx.room.** { *; }
-dontwarn androidx.room.**
-keep class * extends androidx.room.RoomDatabase
-keep @androidx.room.Entity class * { *; }
-keep @androidx.room.Dao interface * { *; }

# LazySodium and Java Native Access (JNA) native bindings
-keep class com.goterl.lazysodium.** { *; }
-keep class com.sun.jna.** { *; }
-keepclassmembers class * extends com.sun.jna.** { *; }

# FIX FOR JNA DESKTOP AWT DEPENDENCY:
# Tell R8 to ignore missing desktop Java AWT classes that don't exist on Android
-dontwarn java.awt.**
-dontwarn com.sun.jna.**

# ===================================================================
# 5. Native C++ JNI Bridge (Level 2 NDK Protection)
# ===================================================================

# Preserve JNI class and native method names for libfastgit_native.so lookup
-keep class com.vineyard.fastgit.app.utils.NativeBridge {
    *;
}

# ===================================================================
# 6. ViewModel Constructors & Library Warning Suppressions
# ===================================================================

# Allow ViewModelProvider reflection on constructors while obfuscating ViewModel names & methods
-keepclassmembers class * extends androidx.lifecycle.ViewModel {
    public <init>(...);
}

-dontwarn kotlinx.coroutines.**
-dontwarn kotlin.**
-dontwarn androidx.core.**
-dontwarn androidx.activity.**
-dontwarn androidx.lifecycle.**
-dontwarn androidx.compose.**

# ===================================================================
# 7. Android Generated Resource IDs (R Classes)
# ===================================================================

# Prevent R8 from inlining and discarding generated R inner classes
-keep class com.vineyard.fastgit.app.R { *; }
-keep class com.vineyard.fastgit.app.R$* { *; }
-keepclassmembers class com.vineyard.fastgit.app.R$* {
    public static <fields>;
}

# ===================================================================
# 8. Google Mobile Ads (AdMob) SDK Protection
# ===================================================================

-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }
-dontwarn com.google.android.gms.ads.**
-dontwarn com.google.ads.**