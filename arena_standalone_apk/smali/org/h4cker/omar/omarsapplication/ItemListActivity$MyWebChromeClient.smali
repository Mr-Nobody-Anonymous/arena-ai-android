.class Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;
.super Landroid/webkit/WebChromeClient;
.source "ItemListActivity.java"

# instance fields
.field final synthetic this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;)V
    .registers 2

    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void
.end method

# virtual methods
.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;",
            "Landroid/webkit/WebChromeClient$FileChooserParams;",
            ")Z"
        }
    .end annotation

    # Save callback in activity for onActivityResult
    iget-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    iput-object p2, v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->filePathCallback:Landroid/webkit/ValueCallback;

    # Launch file / image selection intent
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.intent.action.GET_CONTENT"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.OPENABLE"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "*/*"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    :try_start_17
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    const/16 v2, 0x3e9
    invoke-virtual {v1, v0, v2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_1e} :catch_20

    const/4 v0, 0x1
    return v0

    :catch_20
    move-exception v0
    iget-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$MyWebChromeClient;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    const/4 v1, 0x0
    iput-object v1, v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    const/4 v0, 0x0
    return v0
.end method
