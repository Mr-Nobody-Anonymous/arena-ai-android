.class Lorg/h4cker/omar/omarsapplication/ItemListActivity$1;
.super Ljava/lang/Object;
.source "ItemListActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/h4cker/omar/omarsapplication/ItemListActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;


# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;)V
    .locals 0

    .line 47
    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$1;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    const-string p0, "Replace with your own action"

    const/4 v0, 0x0

    .line 50
    invoke-static {p1, p0, v0}, Landroid/support/design/widget/Snackbar;->make(Landroid/view/View;Ljava/lang/CharSequence;I)Landroid/support/design/widget/Snackbar;

    move-result-object p0

    const-string p1, "Action"

    const/4 v0, 0x0

    .line 51
    invoke-virtual {p0, p1, v0}, Landroid/support/design/widget/Snackbar;->setAction(Ljava/lang/CharSequence;Landroid/view/View$OnClickListener;)Landroid/support/design/widget/Snackbar;

    move-result-object p0

    invoke-virtual {p0}, Landroid/support/design/widget/Snackbar;->show()V

    return-void
.end method
