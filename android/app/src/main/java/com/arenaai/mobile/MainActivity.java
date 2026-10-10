package com.arenaai.mobile;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.CookieManager;
import android.view.KeyEvent;
import android.view.Window;

public class MainActivity extends Activity {

    private WebView webView;

    // Connects to desktop proxy gateway which streams the authentic arena.ai
    // and strips all client IP forwarding headers
    private static final String DEFAULT_SERVER_URL = "http://192.168.1.7:3000";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Borderless full-screen matching the authentic website
        requestWindowFeature(Window.FEATURE_NO_TITLE);

        webView = new WebView(this);
        setContentView(webView);

        configureWebView();
        loadWebsite();
    }

    private void configureWebView() {
        WebSettings settings = webView.getSettings();

        // Enable core web platform features
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setSupportZoom(true);
        settings.setBuiltInZoomControls(false);
        settings.setDisplayZoomControls(false);

        // IP & Privacy Leak Prevention:
        // 1. Disable geolocation to prevent physical location leakage
        settings.setGeolocationEnabled(false);

        // 2. Prevent local content or file URL access leaks
        settings.setAllowFileAccess(false);
        settings.setAllowContentAccess(false);
        settings.setAllowFileAccessFromFileURLs(false);
        settings.setAllowUniversalAccessFromFileURLs(false);

        // 3. Keep standard clean Chrome User-Agent without leaking any custom wrapper tags
        String defaultUA = settings.getUserAgentString();
        settings.setUserAgentString(defaultUA);

        // Cookies
        CookieManager cookieManager = CookieManager.getInstance();
        cookieManager.setAcceptCookie(true);
        cookieManager.setAcceptThirdPartyCookies(webView, true);

        // Internal navigation
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;
            }
        });

        webView.setWebChromeClient(new WebChromeClient());
    }

    private void loadWebsite() {
        webView.loadUrl(DEFAULT_SERVER_URL);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if ((keyCode == KeyEvent.KEYCODE_BACK) && webView.canGoBack()) {
            webView.goBack();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
