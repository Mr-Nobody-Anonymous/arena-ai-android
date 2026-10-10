.class public Lorg/h4cker/omar/omarsapplication/ItemListActivity;
.super Landroid/app/Activity;
.source "ItemListActivity.java"

# instance fields
.field private webView:Landroid/webkit/WebView;
.field public filePathCallback:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field

# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .registers 6

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    # Pure full-screen borderless window
    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Landroid/app/Activity;->requestWindowFeature(I)Z

    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {p0, v1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v2

    # Enable full JavaScript, modern DOM APIs, and local storage for accounts/sessions
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    const/4 v0, 0x0
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    # Privacy Protection & IP Leak Shield
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setGeolocationEnabled(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    # Standard clean modern Chrome User-Agent (Enables Google / GitHub / Social OAuth login)
    const-string v0, "Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36"
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    # Persistent Cookie Management: Enable cross-session holding
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    const/4 v3, 0x1
    invoke-virtual {v0, v3}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v0, v1, v3}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    # Set custom WebViewClient with OAuth and persistent cookie flushing
    new-instance v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebViewClient;
    invoke-direct {v0, p0}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebViewClient;-><init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;)V
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    # Set custom WebChromeClient with onShowFileChooser for file/image uploads & vision tools
    new-instance v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;
    invoke-direct {v0, p0}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;-><init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;)V
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    # Direct HTTPS connection to authentic Arena.ai platform
    const-string v0, "https://arena.ai"
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method protected onPause()V
    .registers 2

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    # Flush cookies to disk when leaving/backgrounding app so session is preserved
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    if-eqz v0, :cond_c

    invoke-virtual {v0}, Landroid/webkit/CookieManager;->flush()V

    :cond_c
    return-void
.end method

.method protected onDestroy()V
    .registers 2

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    if-eqz v0, :cond_c

    invoke-virtual {v0}, Landroid/webkit/CookieManager;->flush()V

    :cond_c
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .registers 8

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    const/16 v0, 0x3e9
    if-ne p1, v0, :cond_28

    iget-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v0, :cond_28

    const/4 v0, 0x0
    const/4 v1, -0x1
    if-ne p2, v1, :cond_20

    if-eqz p3, :cond_20

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v1

    if-eqz v1, :cond_20

    const/4 v0, 0x1
    new-array v0, v0, [Landroid/net/Uri;

    const/4 v2, 0x0

    aput-object v1, v0, v2

    :cond_20
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->filePathCallback:Landroid/webkit/ValueCallback;

    invoke-interface {v1, v0}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->filePathCallback:Landroid/webkit/ValueCallback;

    :cond_28
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .registers 4

    const/4 v0, 0x4
    if-ne p1, v0, :cond_13

    iget-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    if-eqz v0, :cond_13

    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z
    move-result v0

    if-eqz v0, :cond_13

    iget-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V

    const/4 v0, 0x1
    return v0

    :cond_13
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z
    move-result v0

    return v0
.end method
