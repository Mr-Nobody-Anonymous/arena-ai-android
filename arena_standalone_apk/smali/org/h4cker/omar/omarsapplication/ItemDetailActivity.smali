.class public Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;
.super Landroid/support/v7/app/AppCompatActivity;
.source "ItemDetailActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 23
    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    const v0, 0x7f0b001c

    .line 24
    invoke-virtual {p0, v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->setContentView(I)V

    const v0, 0x7f08003b

    .line 25
    invoke-virtual {p0, v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v7/widget/Toolbar;

    .line 26
    invoke-virtual {p0, v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->setSupportActionBar(Landroid/support/v7/widget/Toolbar;)V

    const v0, 0x7f080045

    .line 28
    invoke-virtual {p0, v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/design/widget/FloatingActionButton;

    .line 29
    new-instance v1, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity$1;

    invoke-direct {v1, p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity$1;-><init>(Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;)V

    invoke-virtual {v0, v1}, Landroid/support/design/widget/FloatingActionButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 38
    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->getSupportActionBar()Landroid/support/v7/app/ActionBar;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 40
    invoke-virtual {v0, v1}, Landroid/support/v7/app/ActionBar;->setDisplayHomeAsUpEnabled(Z)V

    :cond_0
    if-nez p1, :cond_1

    .line 55
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    const-string v0, "item_id"

    .line 57
    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "item_id"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 56
    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    new-instance v0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;

    invoke-direct {v0}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;-><init>()V

    .line 59
    invoke-virtual {v0, p1}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->setArguments(Landroid/os/Bundle;)V

    .line 60
    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p0

    invoke-virtual {p0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p0

    const p1, 0x7f080059

    .line 61
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object p0

    .line 62
    invoke-virtual {p0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    :cond_1
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 2

    .line 68
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_0

    .line 76
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Lorg/h4cker/omar/omarsapplication/ItemDetailActivity;->navigateUpTo(Landroid/content/Intent;)Z

    const/4 p0, 0x1

    return p0

    .line 79
    :cond_0
    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result p0

    return p0
.end method
