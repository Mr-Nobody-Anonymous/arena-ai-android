.class Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;
.super Ljava/lang/Object;
.source "ItemListActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;


# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)V
    .locals 0

    .line 78
    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 81
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    .line 82
    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;

    invoke-static {v1}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->access$000(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 83
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    const-string v1, "item_id"

    .line 84
    iget-object v0, v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->id:Ljava/lang/String;

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    new-instance v0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;

    invoke-direct {v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;-><init>()V

    .line 86
    invoke-virtual {v0, p1}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->setArguments(Landroid/os/Bundle;)V

    .line 87
    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;

    invoke-static {p0}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->access$100(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)Lorg/h4cker/omar/omarsapplication/ItemListActivity;

    move-result-object p0

    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemListActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p0

    invoke-virtual {p0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p0

    const p1, 0x7f080059

    .line 88
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object p0

    .line 89
    invoke-virtual {p0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    goto :goto_0

    .line 91
    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p0

    .line 92
    new-instance p1, Landroid/content/Intent;

    const-class v1, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;

    invoke-direct {p1, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "item_id"

    .line 93
    iget-object v0, v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->id:Ljava/lang/String;

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 95
    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :goto_0
    return-void
.end method
