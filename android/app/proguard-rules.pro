# ProGuard / R8 rules for the Arena.ai Android client.

-keepattributes *Annotation*
-keepattributes JavascriptInterface
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Platform APIs referenced by name only (never bundled).
-dontwarn org.w3c.dom.**
-dontwarn javax.annotation.**
-dontwarn kotlin.**

# Keep anything exposed to JavaScript through a WebView bridge.
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Preserve WebView callbacks.
-keepclassmembers class * extends android.webkit.WebView {
    public *;
}

-keepclassmembers class * extends android.webkit.WebChromeClient {
    public *;
}

-keepclassmembers class * extends android.webkit.WebViewClient {
    public *;
}

# Preserve AndroidX Activity / OnBackPressedDispatcher and AppCompat.
-keep class androidx.activity.** { *; }
-keep interface androidx.activity.** { *; }
-keep class androidx.appcompat.** { *; }
-keep class androidx.webkit.** { *; }

# Application classes and public entry points (including the update verifier,
# which is driven by the PackageManager).
-keep public class ai.arena.mobile.** {
    public *;
}
-keep class ai.arena.mobile.UpdateVerifier { *; }
-keep class ai.arena.mobile.DownloadHandler { *; }
