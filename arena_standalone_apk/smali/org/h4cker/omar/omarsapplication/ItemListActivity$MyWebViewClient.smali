.class Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebViewClient;
.super Landroid/webkit/WebViewClient;
.source "ItemListActivity.java"

# instance fields
.field final synthetic this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;)V
    .registers 2

    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebViewClient;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void
.end method

# virtual methods
.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .registers 4

    # Allow all OAuth logins (Google, GitHub, etc.) and arena URLs to load inside WebView
    if-eqz p2, :cond_10

    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const/4 v0, 0x1
    return v0

    :cond_10
    const/4 v0, 0x0
    return v0
.end method

.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 4

    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    # Flush cookies to disk immediately so login session is held when exiting/re-entering
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    if-eqz v0, :cond_c

    invoke-virtual {v0}, Landroid/webkit/CookieManager;->flush()V

    :cond_c
    return-void
.end method
