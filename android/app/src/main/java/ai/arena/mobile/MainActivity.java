package ai.arena.mobile;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Dialog;
import android.content.ActivityNotFoundException;
import android.content.ClipData;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.ViewGroup;
import android.webkit.CookieManager;
import android.webkit.DownloadListener;
import android.webkit.MimeTypeMap;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.Toast;

import androidx.activity.OnBackPressedCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Arena.ai Unofficial Mobile Client
 * 
 * Standalone Android client providing full access to Arena (arena.ai)
 * with robust session persistence, modern back navigation, navigation allow-list,
 * file upload support, smooth in-app scroll gestures, in-app self-updater,
 * and strict client-side privacy safeguards.
 */
public class MainActivity extends AppCompatActivity {

    public static final String ARENA_HOME_URL = "https://arena.ai";

    public static final String OFFLINE_HTML = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,user-scalable=no\"><title>Arena.ai</title><style>*{box-sizing:border-box;margin:0;padding:0}body{background:#000;color:#fff;font-family:-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,sans-serif;height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:24px;text-align:center;overflow:hidden}.logo{width:76px;height:76px;margin-bottom:24px;filter:drop-shadow(0 0 16px rgba(255,255,255,.15))}h1{font-size:20px;font-weight:600;margin-bottom:8px}p{font-size:14px;color:#888;line-height:1.5;margin-bottom:24px;max-width:280px}.spinner{width:32px;height:32px;border:3px solid rgba(255,255,255,.15);border-top-color:#fff;border-radius:50%;animation:spin .8s linear infinite;margin-bottom:20px}@keyframes spin{to{transform:rotate(360deg)}}.status{font-size:13px;color:#38bdf8;font-weight:500;margin-bottom:24px}.btn{background:#fff;color:#000;border:none;padding:12px 28px;border-radius:20px;font-size:14px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(255,255,255,.15)}</style></head><body><svg class=\"logo\" viewBox=\"0 -21.5 167 167\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill=\"#fff\" d=\"M57.5364 53.3142C52.1508 53.3142 47.7887 57.6763 47.7887 63.0618V123.88H53.9963V63.0618C53.9963 61.0989 55.5902 59.505 57.5531 59.505C59.5161 59.505 61.11 61.0989 61.11 63.0618V123.88H67.3176V63.0618C67.3176 57.6763 62.9555 53.3142 57.5699 53.3142H57.5364Z\"/><path fill=\"#fff\" d=\"M109.121 53.3142C103.735 53.3142 99.3734 57.6763 99.3734 63.0618V123.88H105.581V63.0618C105.581 61.0989 107.175 59.505 109.138 59.505C111.101 59.505 112.695 61.0989 112.695 63.0618V123.88H118.902V63.0618C118.902 57.6763 114.54 53.3142 109.155 53.3142H109.121Z\"/><path fill=\"#fff\" d=\"M83.3286 53.3142C77.9431 53.3142 73.5809 57.6763 73.5809 63.0618V123.88H79.7886V63.0618C79.7886 61.0989 81.3824 59.505 83.3454 59.505C85.3083 59.505 86.9022 61.0989 86.9022 63.0618V123.88H93.1098V63.0618C93.1098 57.6763 88.7477 53.3142 83.3622 53.3142H83.3286Z\"/><path fill=\"#fff\" d=\"M143.782 28.035L148.077 20.5691H158.06L166.667 0H0L8.60681 20.5691H18.5894L22.8676 28.035C14.5292 30.8872 7.66727 38.135 7.66727 49.0571C7.66727 59.9792 15.5526 69.2235 27.3639 69.2235C29.9477 69.2235 32.3468 68.6867 34.4776 67.7471V123.901H40.6684V62.7978C42.6146 60.1637 43.7555 56.8754 43.8393 53.1508C43.8393 53.1005 43.8561 53.0333 43.8561 52.9662C43.8561 52.9159 43.8393 52.8823 43.8393 52.832C43.8393 52.7985 43.8561 52.7649 43.8561 52.7314C43.8561 52.681 43.8393 52.6307 43.8393 52.5636C43.7722 50.047 43.1011 47.6981 41.9267 45.7016H124.74C123.566 47.6981 122.894 50.047 122.827 52.5636C122.827 52.6307 122.811 52.681 122.811 52.7314V52.9662C122.811 52.9662 122.827 53.1005 122.827 53.1508C122.911 56.8754 124.052 60.1637 125.998 62.7978V123.901H132.189V67.7471C134.32 68.6867 136.702 69.2235 139.303 69.2235C151.097 69.2235 158.999 59.5765 158.999 49.0571C158.999 38.5377 152.121 30.8872 143.782 28.035ZM12.734 14.3615L9.31146 6.20764H157.355L153.933 14.3615H12.734ZM140.93 20.5691L137.491 26.5586H29.1759L25.7365 20.5691H140.93ZM139.303 63.0159C133.246 63.0159 129.085 58.9222 129.018 52.8991C129.052 48.6377 131.803 45.7855 135.796 45.7352H135.914C138.414 45.7352 140.46 47.7988 140.46 49.9631V50.0637C140.41 51.3221 139.403 52.2951 138.145 52.2951C136.434 52.2951 135.041 53.6877 135.041 55.399C135.041 57.1103 136.434 58.5028 138.145 58.5028C142.843 58.5028 146.685 54.6943 146.685 49.9631C146.685 49.8121 146.651 49.6611 146.634 49.5269C146.383 43.9736 141.836 39.5443 135.83 39.5443H83.3166L82.9139 39.5275H82.4945L30.8369 39.5443C24.8305 39.5443 20.2839 43.9736 20.0322 49.5269C20.0154 49.6611 19.9819 49.8121 19.9819 49.9631C19.9819 54.6943 23.8239 58.5028 28.5216 58.5028C30.2329 58.5028 31.6254 57.1103 31.6254 55.399C31.6254 53.6877 30.2329 52.2951 28.5216 52.2951C27.2633 52.2951 26.2566 51.3221 26.1895 50.0637C26.1895 50.0302 26.2063 49.9966 26.2063 49.9631C26.2063 47.7988 28.2364 45.7352 30.753 45.7352H30.8536C34.8634 45.7855 37.6149 48.6377 37.6485 52.8991C37.5814 58.9222 33.4038 63.0159 27.3639 63.0159C19.4114 63.0159 13.8749 56.5902 13.8749 49.0571C13.8749 38.89 21.8442 32.7495 31.6925 32.7495H134.974C144.822 32.7495 152.792 38.89 152.792 49.0571C152.792 56.5902 147.255 63.0159 139.303 63.0159Z\"/></svg><h1>Connecting to Arena</h1><p>No internet connection detected.<br>Auto-reconnecting every 5 seconds...</p><div class=\"spinner\"></div><div class=\"status\" id=\"cd\">Checking in 5s...</div><button class=\"btn\" onclick=\"retry()\">Retry Now</button><script>var c=5,t=null;function tick(){c--;if(c<=0){retry()}else{document.getElementById(\"cd\").innerText=\"Checking in \"+c+\"s...\";t=setTimeout(tick,1000)}}function retry(){if(t)clearTimeout(t);document.getElementById(\"cd\").innerText=\"Reconnecting...\";window.location.href=\"https://arena.ai\"}t=setTimeout(tick,1000)</script></body></html>";

    private boolean isOfflineState = false;
    private final Handler retryHandler = new Handler(Looper.getMainLooper());
    private final ExecutorService networkExecutor = Executors.newSingleThreadExecutor();

    private final Runnable retryRunnable = new Runnable() {
        @Override
        public void run() {
            if (!isOfflineState) {
                return;
            }
            networkExecutor.execute(() -> {
                boolean reachable = false;
                try {
                    URL url = new URL(ARENA_HOME_URL);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setConnectTimeout(2500);
                    conn.setReadTimeout(2500);
                    conn.setRequestMethod("HEAD");
                    int code = conn.getResponseCode();
                    reachable = (code > 0);
                    conn.disconnect();
                } catch (Exception ignored) {
                    reachable = false;
                }

                final boolean isReachable = reachable;
                runOnUiThread(() -> {
                    if (!isOfflineState) {
                        return;
                    }
                    if (isReachable) {
                        isOfflineState = false;
                        if (webView != null) {
                            webView.loadUrl(ARENA_HOME_URL);
                        }
                    } else {
                        scheduleNetworkRetry();
                    }
                });
            });
        }
    };

    private SwipeRefreshLayout swipeRefreshLayout;
    private WebView webView;
    private ValueCallback<Uri[]> filePathCallback;
    private ActivityResultLauncher<Intent> fileChooserLauncher;

    // Allowed domains for in-app WebView rendering (Arena site and OAuth providers)
    private static final List<String> ALLOWED_HOST_SUFFIXES = Arrays.asList(
            "arena.ai",
            "lmarena.ai",
            "accounts.google.com",
            "google.com",
            "github.com",
            "appleid.apple.com",
            "auth0.com"
    );

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Modern back navigation using OnBackPressedDispatcher (compatible with API 34, 35, 36)
        getOnBackPressedDispatcher().addCallback(this, new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                if (webView != null && webView.canGoBack()) {
                    webView.goBack();
                } else {
                    setEnabled(false);
                    getOnBackPressedDispatcher().onBackPressed();
                }
            }
        });

        // Register modern ActivityResultLauncher for HTML5 file chooser / uploads
        fileChooserLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                result -> {
                    if (filePathCallback == null) {
                        return;
                    }
                    Uri[] results = null;
                    if (result.getResultCode() == Activity.RESULT_OK && result.getData() != null) {
                        Intent data = result.getData();
                        ClipData clipData = data.getClipData();
                        if (clipData != null && clipData.getItemCount() > 0) {
                            results = new Uri[clipData.getItemCount()];
                            for (int i = 0; i < clipData.getItemCount(); i++) {
                                results[i] = clipData.getItemAt(i).getUri();
                            }
                        } else if (data.getData() != null) {
                            results = new Uri[]{data.getData()};
                        } else if (data.getDataString() != null) {
                            try {
                                results = new Uri[]{Uri.parse(data.getDataString())};
                            } catch (Exception ignored) {}
                        }
                    }
                    filePathCallback.onReceiveValue(results);
                    filePathCallback = null;
                }
        );

        // Root container with dark styling matching Arena
        FrameLayout rootLayout = new FrameLayout(this);
        rootLayout.setBackgroundColor(Color.BLACK);

        swipeRefreshLayout = new SwipeRefreshLayout(this);
        swipeRefreshLayout.setColorSchemeColors(Color.WHITE);
        swipeRefreshLayout.setProgressBackgroundColorSchemeColor(Color.BLACK);

        // Disable pull-to-refresh swipe gestures so vertical scrolling in chat/battle views is never hijacked
        swipeRefreshLayout.setEnabled(false);
        swipeRefreshLayout.setOnChildScrollUpCallback((parent, child) -> true);

        webView = new WebView(this);
        webView.setBackgroundColor(Color.BLACK);

        swipeRefreshLayout.addView(
                webView,
                new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        );
        rootLayout.addView(
                swipeRefreshLayout,
                new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        );

        setContentView(rootLayout);

        configureWebView();

        if (savedInstanceState != null) {
            webView.restoreState(savedInstanceState);
        } else {
            webView.loadUrl(ARENA_HOME_URL);
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    private void configureWebView() {
        WebSettings settings = webView.getSettings();

        // 1. Core Web Platform Capabilities
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setSupportZoom(true);
        settings.setBuiltInZoomControls(false);
        settings.setDisplayZoomControls(false);

        // 2. Window / Popup Management for OAuth Authentication
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        settings.setSupportMultipleWindows(true);

        // 3. Client-Side Privacy Controls
        // Disables browser geolocation API to prevent location leaks
        settings.setGeolocationEnabled(false);
        // Restricts local file access schemes
        settings.setAllowFileAccess(false);
        settings.setAllowContentAccess(false);
        settings.setAllowFileAccessFromFileURLs(false);
        settings.setAllowUniversalAccessFromFileURLs(false);

        // 4. Clean Chrome User-Agent (avoids custom wrapper signature)
        String currentUA = settings.getUserAgentString();
        if (currentUA != null && currentUA.contains("; wv")) {
            settings.setUserAgentString(currentUA.replace("; wv", ""));
        }

        // 5. Session & Cookie Persistence
        CookieManager cookieManager = CookieManager.getInstance();
        cookieManager.setAcceptCookie(true);
        cookieManager.setAcceptThirdPartyCookies(webView, true);

        // 6. Pull-To-Refresh Listener (configured for programmatic triggers)
        swipeRefreshLayout.setOnRefreshListener(() -> {
            isOfflineState = false;
            retryHandler.removeCallbacks(retryRunnable);
            webView.loadUrl(ARENA_HOME_URL);
        });

        // 7. Navigation & Security Allow-List
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                Uri uri = request.getUrl();
                return handleNavigation(view, uri);
            }

            @SuppressWarnings("deprecation")
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                if (url == null) return false;
                return handleNavigation(view, Uri.parse(url));
            }

            private boolean handleNavigation(WebView view, Uri uri) {
                if (uri == null) return false;
                String scheme = uri.getScheme();
                String host = uri.getHost();

                // Open non-HTTP schemes (mailto, tel, intent) in system apps
                if (scheme != null && !scheme.equalsIgnoreCase("http") && !scheme.equalsIgnoreCase("https")) {
                    try {
                        Intent externalIntent = new Intent(Intent.ACTION_VIEW, uri);
                        startActivity(externalIntent);
                    } catch (ActivityNotFoundException ignored) {}
                    return true;
                }

                // Check host against allowed list
                if (isHostAllowed(host)) {
                    return false; // Render inside WebView
                }

                // Any outside URL opens securely in the device's default browser
                try {
                    Intent browserIntent = new Intent(Intent.ACTION_VIEW, uri);
                    startActivity(browserIntent);
                } catch (ActivityNotFoundException ignored) {}
                return true;
            }

            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                swipeRefreshLayout.setRefreshing(false);
                if (url != null && url.startsWith("https://") && !url.contains("data:")) {
                    onPageSuccess();
                    // Background check for GitHub release updates without blocking UI
                    AppUpdateManager.checkForUpdates(MainActivity.this, BuildConfig.VERSION_NAME);
                }
                // Flush cookies to persistent storage on every page transition
                CookieManager.getInstance().flush();
            }

            @Override
            public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
                super.onReceivedError(view, request, error);
                if (request != null && request.isForMainFrame()) {
                    swipeRefreshLayout.setRefreshing(false);
                    handleNetworkError();
                }
            }

            @SuppressWarnings("deprecation")
            @Override
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                super.onReceivedError(view, errorCode, description, failingUrl);
                swipeRefreshLayout.setRefreshing(false);
                handleNetworkError();
            }
        });

        // 8. Chrome Client: File Chooser, Progress, Secondary Windows
        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                if (newProgress == 100) {
                    swipeRefreshLayout.setRefreshing(false);
                }
            }

            @Override
            public boolean onShowFileChooser(
                    WebView webView,
                    ValueCallback<Uri[]> filePathCallback,
                    FileChooserParams fileChooserParams
            ) {
                // Cancel any pending callback before opening a new chooser
                if (MainActivity.this.filePathCallback != null) {
                    MainActivity.this.filePathCallback.onReceiveValue(null);
                    MainActivity.this.filePathCallback = null;
                }
                MainActivity.this.filePathCallback = filePathCallback;

                Intent intent = buildFileChooserIntent(fileChooserParams);

                try {
                    fileChooserLauncher.launch(Intent.createChooser(intent, "Upload File or Image"));
                    return true;
                } catch (ActivityNotFoundException e) {
                    if (MainActivity.this.filePathCallback != null) {
                        MainActivity.this.filePathCallback.onReceiveValue(null);
                        MainActivity.this.filePathCallback = null;
                    }
                    Toast.makeText(MainActivity.this, "No file manager found", Toast.LENGTH_SHORT).show();
                    return false;
                }
            }

            @Override
            public boolean onCreateWindow(
                    WebView view,
                    boolean isDialog,
                    boolean isUserGesture,
                    Message resultMsg
            ) {
                // Handle popups (such as OAuth login flows) inside a clean dialog WebView
                WebView popupWebView = new WebView(MainActivity.this);
                popupWebView.getSettings().setJavaScriptEnabled(true);
                popupWebView.getSettings().setDomStorageEnabled(true);
                CookieManager.getInstance().setAcceptThirdPartyCookies(popupWebView, true);

                Dialog dialog = new Dialog(MainActivity.this, android.R.style.Theme_Black_NoTitleBar_Fullscreen);
                dialog.setContentView(popupWebView);
                dialog.show();

                popupWebView.setWebChromeClient(new WebChromeClient() {
                    @Override
                    public void onCloseWindow(WebView window) {
                        dialog.dismiss();
                    }
                });

                popupWebView.setWebViewClient(new WebViewClient() {
                    @Override
                    public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                        Uri uri = request.getUrl();
                        if (uri != null && isHostAllowed(uri.getHost())) {
                            return false;
                        }
                        try {
                            startActivity(new Intent(Intent.ACTION_VIEW, uri));
                        } catch (ActivityNotFoundException ignored) {}
                        return true;
                    }

                    @Override
                    public void onPageFinished(WebView view, String url) {
                        super.onPageFinished(view, url);
                        CookieManager.getInstance().flush();
                    }
                });

                WebView.WebViewTransport transport = (WebView.WebViewTransport) resultMsg.obj;
                transport.setWebView(popupWebView);
                resultMsg.sendToTarget();
                return true;
            }
        });

        // 9. Download Handler
        webView.setDownloadListener(new DownloadListener() {
            @Override
            public void onDownloadStart(String url, String userAgent, String contentDisposition, String mimeType, long contentLength) {
                try {
                    Intent downloadIntent = new Intent(Intent.ACTION_VIEW);
                    downloadIntent.setData(Uri.parse(url));
                    startActivity(downloadIntent);
                } catch (ActivityNotFoundException e) {
                    Toast.makeText(MainActivity.this, "No app available to handle download", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    /**
     * Constructs a safe, clean file chooser Intent with support for multi-select,
     * parsed MIME types, image types, and extension mappings.
     */
    private Intent buildFileChooserIntent(WebChromeClient.FileChooserParams fileChooserParams) {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);

        String[] acceptTypes = fileChooserParams != null ? fileChooserParams.getAcceptTypes() : null;
        List<String> validMimeTypes = new ArrayList<>();

        if (acceptTypes != null) {
            for (String rawType : acceptTypes) {
                if (rawType != null && !rawType.trim().isEmpty()) {
                    String[] parts = rawType.split(",");
                    for (String part : parts) {
                        String clean = part.trim();
                        if (!clean.isEmpty()) {
                            if (clean.startsWith(".")) {
                                String ext = clean.substring(1).toLowerCase();
                                String mime = MimeTypeMap.getSingleton().getMimeTypeFromExtension(ext);
                                if (mime != null) {
                                    validMimeTypes.add(mime);
                                }
                            } else {
                                validMimeTypes.add(clean);
                            }
                        }
                    }
                }
            }
        }

        if (validMimeTypes.isEmpty()) {
            intent.setType("*/*");
        } else if (validMimeTypes.size() == 1) {
            intent.setType(validMimeTypes.get(0));
        } else {
            boolean allImages = true;
            for (String mime : validMimeTypes) {
                if (!mime.startsWith("image/")) {
                    allImages = false;
                    break;
                }
            }
            if (allImages) {
                intent.setType("image/*");
            } else {
                intent.setType("*/*");
            }
            intent.putExtra(Intent.EXTRA_MIME_TYPES, validMimeTypes.toArray(new String[0]));
        }

        if (fileChooserParams != null && fileChooserParams.getMode() == WebChromeClient.FileChooserParams.MODE_OPEN_MULTIPLE) {
            intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        }

        return intent;
    }

    private void handleNetworkError() {
        if (isOfflineState) {
            return;
        }
        isOfflineState = true;
        if (webView != null) {
            webView.loadDataWithBaseURL(ARENA_HOME_URL, OFFLINE_HTML, "text/html", "UTF-8", null);
        }
        scheduleNetworkRetry();
    }

    private void scheduleNetworkRetry() {
        if (!isOfflineState) {
            return;
        }
        retryHandler.removeCallbacks(retryRunnable);
        retryHandler.postDelayed(retryRunnable, 5000);
    }

    private void onPageSuccess() {
        isOfflineState = false;
        retryHandler.removeCallbacks(retryRunnable);
    }

    private boolean isHostAllowed(@Nullable String host) {
        if (host == null) return false;
        String lowerHost = host.toLowerCase();
        for (String allowed : ALLOWED_HOST_SUFFIXES) {
            if (lowerHost.equals(allowed) || lowerHost.endsWith("." + allowed)) {
                return true;
            }
        }
        return false;
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        if (webView != null) {
            webView.saveState(outState);
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (webView != null) {
            webView.onPause();
        }
        CookieManager.getInstance().flush();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (webView != null) {
            webView.onResume();
        }
        AppUpdateManager.checkPendingInstall(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        CookieManager.getInstance().flush();
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.destroy();
            webView = null;
        }
        if (filePathCallback != null) {
            filePathCallback.onReceiveValue(null);
            filePathCallback = null;
        }
        super.onDestroy();
        retryHandler.removeCallbacks(retryRunnable);
        networkExecutor.shutdown();
    }
}
