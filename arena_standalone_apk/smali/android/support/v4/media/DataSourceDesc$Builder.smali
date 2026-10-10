.class public Landroid/support/v4/media/DataSourceDesc$Builder;
.super Ljava/lang/Object;
.source "DataSourceDesc.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/media/DataSourceDesc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private mEndPositionMs:J

.field private mFD:Ljava/io/FileDescriptor;

.field private mFDLength:J

.field private mFDOffset:J

.field private mMedia2DataSource:Landroid/support/v4/media/Media2DataSource;

.field private mMediaId:Ljava/lang/String;

.field private mStartPositionMs:J

.field private mType:I

.field private mUri:Landroid/net/Uri;

.field private mUriContext:Landroid/content/Context;

.field private mUriCookies:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/net/HttpCookie;",
            ">;"
        }
    .end annotation
.end field

.field private mUriHeader:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 4

    .line 227
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 207
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const-wide/16 v0, 0x0

    .line 212
    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    const-wide v2, 0x7ffffffffffffffL

    .line 213
    iput-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    .line 221
    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    .line 222
    iput-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    return-void
.end method

.method public constructor <init>(Landroid/support/v4/media/DataSourceDesc;)V
    .locals 4
    .param p1    # Landroid/support/v4/media/DataSourceDesc;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 235
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 207
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const-wide/16 v0, 0x0

    .line 212
    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    const-wide v2, 0x7ffffffffffffffL

    .line 213
    iput-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    .line 221
    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    .line 222
    iput-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    .line 236
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$000(Landroid/support/v4/media/DataSourceDesc;)I

    move-result v0

    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 237
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$100(Landroid/support/v4/media/DataSourceDesc;)Landroid/support/v4/media/Media2DataSource;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMedia2DataSource:Landroid/support/v4/media/Media2DataSource;

    .line 238
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$200(Landroid/support/v4/media/DataSourceDesc;)Ljava/io/FileDescriptor;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFD:Ljava/io/FileDescriptor;

    .line 239
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$300(Landroid/support/v4/media/DataSourceDesc;)J

    move-result-wide v0

    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    .line 240
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$400(Landroid/support/v4/media/DataSourceDesc;)J

    move-result-wide v0

    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    .line 241
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$500(Landroid/support/v4/media/DataSourceDesc;)Landroid/net/Uri;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUri:Landroid/net/Uri;

    .line 242
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$600(Landroid/support/v4/media/DataSourceDesc;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriHeader:Ljava/util/Map;

    .line 243
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$700(Landroid/support/v4/media/DataSourceDesc;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriCookies:Ljava/util/List;

    .line 244
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$800(Landroid/support/v4/media/DataSourceDesc;)Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriContext:Landroid/content/Context;

    .line 246
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$900(Landroid/support/v4/media/DataSourceDesc;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMediaId:Ljava/lang/String;

    .line 247
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$1000(Landroid/support/v4/media/DataSourceDesc;)J

    move-result-wide v0

    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    .line 248
    invoke-static {p1}, Landroid/support/v4/media/DataSourceDesc;->access$1100(Landroid/support/v4/media/DataSourceDesc;)J

    move-result-wide v0

    iput-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    return-void
.end method

.method private resetDataSource()V
    .locals 3

    const/4 v0, 0x0

    .line 458
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const/4 v0, 0x0

    .line 459
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMedia2DataSource:Landroid/support/v4/media/Media2DataSource;

    .line 460
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFD:Ljava/io/FileDescriptor;

    const-wide/16 v1, 0x0

    .line 461
    iput-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    const-wide v1, 0x7ffffffffffffffL

    .line 462
    iput-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    .line 463
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUri:Landroid/net/Uri;

    .line 464
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriHeader:Ljava/util/Map;

    .line 465
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriCookies:Ljava/util/List;

    .line 466
    iput-object v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriContext:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public build()Landroid/support/v4/media/DataSourceDesc;
    .locals 4
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 259
    iget v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    iget v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    .line 262
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 264
    :cond_0
    iget-wide v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    iget-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    .line 265
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal start/end position: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v2, " : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 269
    :cond_1
    new-instance v0, Landroid/support/v4/media/DataSourceDesc;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Landroid/support/v4/media/DataSourceDesc;-><init>(Landroid/support/v4/media/DataSourceDesc$1;)V

    .line 270
    iget v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$002(Landroid/support/v4/media/DataSourceDesc;I)I

    .line 271
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMedia2DataSource:Landroid/support/v4/media/Media2DataSource;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$102(Landroid/support/v4/media/DataSourceDesc;Landroid/support/v4/media/Media2DataSource;)Landroid/support/v4/media/Media2DataSource;

    .line 272
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFD:Ljava/io/FileDescriptor;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$202(Landroid/support/v4/media/DataSourceDesc;Ljava/io/FileDescriptor;)Ljava/io/FileDescriptor;

    .line 273
    iget-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    invoke-static {v0, v1, v2}, Landroid/support/v4/media/DataSourceDesc;->access$302(Landroid/support/v4/media/DataSourceDesc;J)J

    .line 274
    iget-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    invoke-static {v0, v1, v2}, Landroid/support/v4/media/DataSourceDesc;->access$402(Landroid/support/v4/media/DataSourceDesc;J)J

    .line 275
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUri:Landroid/net/Uri;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$502(Landroid/support/v4/media/DataSourceDesc;Landroid/net/Uri;)Landroid/net/Uri;

    .line 276
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriHeader:Ljava/util/Map;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$602(Landroid/support/v4/media/DataSourceDesc;Ljava/util/Map;)Ljava/util/Map;

    .line 277
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriCookies:Ljava/util/List;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$702(Landroid/support/v4/media/DataSourceDesc;Ljava/util/List;)Ljava/util/List;

    .line 278
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriContext:Landroid/content/Context;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$802(Landroid/support/v4/media/DataSourceDesc;Landroid/content/Context;)Landroid/content/Context;

    .line 280
    iget-object v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMediaId:Ljava/lang/String;

    invoke-static {v0, v1}, Landroid/support/v4/media/DataSourceDesc;->access$902(Landroid/support/v4/media/DataSourceDesc;Ljava/lang/String;)Ljava/lang/String;

    .line 281
    iget-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    invoke-static {v0, v1, v2}, Landroid/support/v4/media/DataSourceDesc;->access$1002(Landroid/support/v4/media/DataSourceDesc;J)J

    .line 282
    iget-wide v1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    invoke-static {v0, v1, v2}, Landroid/support/v4/media/DataSourceDesc;->access$1102(Landroid/support/v4/media/DataSourceDesc;J)J

    return-object v0
.end method

.method public setDataSource(Landroid/content/Context;Landroid/net/Uri;)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/net/Uri;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    const-string v0, "context cannot be null"

    .line 401
    invoke-static {p1, v0}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "uri cannot be null"

    .line 402
    invoke-static {p2, v0}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 403
    invoke-direct {p0}, Landroid/support/v4/media/DataSourceDesc$Builder;->resetDataSource()V

    const/4 v0, 0x3

    .line 404
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 405
    iput-object p2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUri:Landroid/net/Uri;

    .line 406
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriContext:Landroid/content/Context;

    return-object p0
.end method

.method public setDataSource(Landroid/content/Context;Landroid/net/Uri;Ljava/util/Map;Ljava/util/List;)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/net/Uri;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/util/Map;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p4    # Ljava/util/List;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/net/Uri;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/net/HttpCookie;",
            ">;)",
            "Landroid/support/v4/media/DataSourceDesc$Builder;"
        }
    .end annotation

    const-string v0, "context cannot be null"

    .line 433
    invoke-static {p1, v0}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 434
    invoke-static {p2}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    if-eqz p4, :cond_0

    .line 436
    invoke-static {}, Ljava/net/CookieHandler;->getDefault()Ljava/net/CookieHandler;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 437
    instance-of v0, v0, Ljava/net/CookieManager;

    if-nez v0, :cond_0

    .line 438
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "The cookie handler has to be of CookieManager type when cookies are provided."

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 444
    :cond_0
    invoke-direct {p0}, Landroid/support/v4/media/DataSourceDesc$Builder;->resetDataSource()V

    const/4 v0, 0x3

    .line 445
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 446
    iput-object p2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUri:Landroid/net/Uri;

    if-eqz p3, :cond_1

    .line 448
    new-instance p2, Ljava/util/HashMap;

    invoke-direct {p2, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    iput-object p2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriHeader:Ljava/util/Map;

    :cond_1
    if-eqz p4, :cond_2

    .line 451
    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2, p4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object p2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriCookies:Ljava/util/List;

    .line 453
    :cond_2
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mUriContext:Landroid/content/Context;

    return-object p0
.end method

.method public setDataSource(Landroid/support/v4/media/Media2DataSource;)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 1
    .param p1    # Landroid/support/v4/media/Media2DataSource;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 337
    invoke-static {p1}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 338
    invoke-direct {p0}, Landroid/support/v4/media/DataSourceDesc$Builder;->resetDataSource()V

    const/4 v0, 0x1

    .line 339
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 340
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMedia2DataSource:Landroid/support/v4/media/Media2DataSource;

    return-object p0
.end method

.method public setDataSource(Ljava/io/FileDescriptor;)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 1
    .param p1    # Ljava/io/FileDescriptor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 354
    invoke-static {p1}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 355
    invoke-direct {p0}, Landroid/support/v4/media/DataSourceDesc$Builder;->resetDataSource()V

    const/4 v0, 0x2

    .line 356
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 357
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFD:Ljava/io/FileDescriptor;

    return-object p0
.end method

.method public setDataSource(Ljava/io/FileDescriptor;JJ)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 3
    .param p1    # Ljava/io/FileDescriptor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 377
    invoke-static {p1}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-gez v2, :cond_0

    move-wide p2, v0

    :cond_0
    cmp-long v0, p4, v0

    if-gez v0, :cond_1

    const-wide p4, 0x7ffffffffffffffL

    .line 384
    :cond_1
    invoke-direct {p0}, Landroid/support/v4/media/DataSourceDesc$Builder;->resetDataSource()V

    const/4 v0, 0x2

    .line 385
    iput v0, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mType:I

    .line 386
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFD:Ljava/io/FileDescriptor;

    .line 387
    iput-wide p2, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDOffset:J

    .line 388
    iput-wide p4, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mFDLength:J

    return-object p0
.end method

.method public setEndPosition(J)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 2
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_0

    const-wide p1, 0x7ffffffffffffffL

    .line 325
    :cond_0
    iput-wide p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mEndPositionMs:J

    return-object p0
.end method

.method public setMediaId(Ljava/lang/String;)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 0
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 294
    iput-object p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mMediaId:Ljava/lang/String;

    return-object p0
.end method

.method public setStartPosition(J)Landroid/support/v4/media/DataSourceDesc$Builder;
    .locals 3
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-gez v2, :cond_0

    move-wide p1, v0

    .line 310
    :cond_0
    iput-wide p1, p0, Landroid/support/v4/media/DataSourceDesc$Builder;->mStartPositionMs:J

    return-object p0
.end method
