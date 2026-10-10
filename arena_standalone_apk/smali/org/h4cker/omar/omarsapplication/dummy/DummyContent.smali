.class public Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;
.super Ljava/lang/Object;
.source "DummyContent.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;
    }
.end annotation


# static fields
.field private static final COUNT:I = 0x19

.field public static final ITEMS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;",
            ">;"
        }
    .end annotation
.end field

.field public static final ITEM_MAP:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 19
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->ITEMS:Ljava/util/List;

    .line 24
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->ITEM_MAP:Ljava/util/Map;

    const/4 v0, 0x1

    :goto_0
    const/16 v1, 0x19

    if-gt v0, v1, :cond_0

    .line 31
    invoke-static {v0}, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->createDummyItem(I)Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    move-result-object v1

    invoke-static {v1}, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->addItem(Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addItem(Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;)V
    .locals 2

    .line 36
    sget-object v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->ITEMS:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 37
    sget-object v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->ITEM_MAP:Ljava/util/Map;

    iget-object v1, p0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;->id:Ljava/lang/String;

    invoke-interface {v0, v1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static createDummyItem(I)Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;
    .locals 4

    .line 41
    new-instance v0, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Item "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0}, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent;->makeDetails(I)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, v1, v2, p0}, Lorg/h4cker/omar/omarsapplication/dummy/DummyContent$DummyItem;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private static makeDetails(I)Ljava/lang/String;
    .locals 3

    .line 45
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Details about Item: "

    .line 46
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p0, :cond_0

    const-string v2, "\nMore details information here."

    .line 48
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 50
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
