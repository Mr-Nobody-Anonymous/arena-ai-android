.class public Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;
.super Ljava/lang/Object;
.source "DummyContent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DummyItem"
.end annotation


# instance fields
.field public final content:Ljava/lang/String;

.field public final details:Ljava/lang/String;

.field public final id:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput-object p1, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->id:Ljava/lang/String;

    .line 63
    iput-object p2, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->content:Ljava/lang/String;

    .line 64
    iput-object p3, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->details:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 0

    .line 69
    iget-object p0, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->content:Ljava/lang/String;

    return-object p0
.end method
