.class Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;
.super Landroid/support/v7/widget/RecyclerView$ViewHolder;
.source "ItemListActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ViewHolder"
.end annotation


# instance fields
.field final mContentView:Landroid/widget/TextView;

.field final mIdView:Landroid/widget/TextView;

.field final synthetic this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;


# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;Landroid/view/View;)V
    .locals 0

    .line 133
    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->this$0:Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;

    .line 134
    invoke-direct {p0, p2}, Landroid/support/v7/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    const p1, 0x7f080053

    .line 135
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->mIdView:Landroid/widget/TextView;

    const p1, 0x7f08002f

    .line 136
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->mContentView:Landroid/widget/TextView;

    return-void
.end method
