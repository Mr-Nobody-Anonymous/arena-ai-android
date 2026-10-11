# Proguard rules for Arena.ai Android client

# Preserve WebView client and chrome client callbacks
-keepattributes *Annotation*
-keepattributes JavascriptInterface

-keepclassmembers class * extends android.webkit.WebView {
    public *;
}

-keepclassmembers class * extends android.webkit.WebChromeClient {
    public *;
}

-keepclassmembers class * extends android.webkit.WebViewClient {
    public *;
}

# Preserve AndroidX Activity / OnBackPressedDispatcher
-keep class androidx.activity.** { *; }
-keep interface androidx.activity.** { *; }
-keep class androidx.appcompat.** { *; }

# Preserve application classes and public entrypoints
-keep public class ai.arena.mobile.** {
    public *;
}
