.class public Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;
.super Landroid/support/v4/app/Fragment;
.source "ItemDetailFragment.java"


# static fields
.field public static final ARG_ITEM_ID:Ljava/lang/String; = "item_id"


# instance fields
.field private mItem:Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Landroid/support/v4/app/Fragment;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 2

    .line 41
    invoke-super {p0, p1}, Landroid/support/v4/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    .line 43
    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->getArguments()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "item_id"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 47
    sget-object p1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->ITEM_MAP:Ljava/util/Map;

    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "item_id"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->mItem:Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    .line 49
    invoke-virtual {p0}, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0800b6

    .line 50
    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/support/design/widget/CollapsingToolbarLayout;

    if-eqz p1, :cond_0

    .line 52
    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->mItem:Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->content:Ljava/lang/String;

    invoke-virtual {p1, p0}, Landroid/support/design/widget/CollapsingToolbarLayout;->setTitle(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b002d

    const/4 v0, 0x0

    .line 60
    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    .line 63
    iget-object p2, p0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->mItem:Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    if-eqz p2, :cond_0

    const p2, 0x7f080058

    .line 64
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemDetailFragment;->mItem:Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->details:Ljava/lang/String;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    return-object p1
.end method
