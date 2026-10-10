.class public Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;
.super Landroid/support/v7/widget/RecyclerView$Adapter;
.source "ItemListActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/h4cker/omar/omarsapplication/ItemListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SimpleItemRecyclerViewAdapter"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/support/v7/widget/RecyclerView$Adapter<",
        "Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;",
        ">;"
    }
.end annotation


# instance fields
.field private final mOnClickListener:Landroid/view/View$OnClickListener;

.field private final mParentActivity:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

.field private final mTwoPane:Z

.field private final mValues:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity;Ljava/util/List;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/h4cker/omar/omarsapplication/ItemListActivity;",
            "Ljava/util/List<",
            "Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;",
            ">;Z)V"
        }
    .end annotation

    .line 102
    invoke-direct {p0}, Landroid/support/v7/widget/RecyclerView$Adapter;-><init>()V

    .line 78
    new-instance v0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;

    invoke-direct {v0, p0}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$1;-><init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)V

    iput-object v0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mOnClickListener:Landroid/view/View$OnClickListener;

    .line 103
    iput-object p2, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mValues:Ljava/util/List;

    .line 104
    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mParentActivity:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

    .line 105
    iput-boolean p3, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mTwoPane:Z

    return-void
.end method

.method static synthetic access$000(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)Z
    .locals 0

    .line 72
    iget-boolean p0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mTwoPane:Z

    return p0
.end method

.method static synthetic access$100(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;)Lorg/h4cker/omar/omarsapplication/ItemListActivity;
    .locals 0

    .line 72
    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mParentActivity:Lorg/h4cker/omar/omarsapplication/ItemListActivity;

    return-object p0
.end method


# virtual methods
.method public getItemCount()I
    .locals 0

    .line 126
    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mValues:Ljava/util/List;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result p0

    return p0
.end method

.method public bridge synthetic onBindViewHolder(Landroid/support/v7/widget/RecyclerView$ViewHolder;I)V
    .locals 0

    .line 72
    check-cast p1, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;

    invoke-virtual {p0, p1, p2}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->onBindViewHolder(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;I)V
    .locals 2

    .line 117
    iget-object v0, p1, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->mIdView:Landroid/widget/TextView;

    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mValues:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    iget-object v1, v1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->id:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 118
    iget-object v0, p1, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->mContentView:Landroid/widget/TextView;

    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mValues:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    iget-object v1, v1, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->content:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 120
    iget-object v0, p1, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->itemView:Landroid/view/View;

    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mValues:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 121
    iget-object p1, p1, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;->itemView:Landroid/view/View;

    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->mOnClickListener:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroid/support/v7/widget/RecyclerView$ViewHolder;
    .locals 0

    .line 72
    invoke-virtual {p0, p1, p2}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;

    move-result-object p0

    return-object p0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;
    .locals 2

    .line 110
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0b002f

    const/4 v1, 0x0

    .line 111
    invoke-virtual {p2, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    .line 112
    new-instance p2, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;

    invoke-direct {p2, p0, p1}, Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter$ViewHolder;-><init>(Lorg/h4cker/omar/omarsapplication/ItemListActivity$SimpleItemRecyclerViewAdapter;Landroid/view/View;)V

    return-object p2
.end method
