.class public final Landroid/support/v4/media/MediaPlayer2Impl;
.super Landroid/support/v4/media/MediaPlayer2;
.source "MediaPlayer2Impl.java"


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x1c
.end annotation

.annotation build Landroid/support/annotation/RestrictTo;
    value = {
        .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;,
        Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;,
        Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;,
        Landroid/support/v4/media/MediaPlayer2Impl$DataSourceError;,
        Landroid/support/v4/media/MediaPlayer2Impl$Task;,
        Landroid/support/v4/media/MediaPlayer2Impl$ProvisioningServerErrorExceptionImpl;,
        Landroid/support/v4/media/MediaPlayer2Impl$ProvisioningNetworkErrorExceptionImpl;,
        Landroid/support/v4/media/MediaPlayer2Impl$NoDrmSchemeExceptionImpl;,
        Landroid/support/v4/media/MediaPlayer2Impl$DrmInfoImpl;,
        Landroid/support/v4/media/MediaPlayer2Impl$DrmEventNotifier;,
        Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;,
        Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;,
        Landroid/support/v4/media/MediaPlayer2Impl$TrackInfoImpl;
    }
.end annotation


# static fields
.field private static final SOURCE_STATE_ERROR:I = -0x1

.field private static final SOURCE_STATE_INIT:I = 0x0

.field private static final SOURCE_STATE_PREPARED:I = 0x2

.field private static final SOURCE_STATE_PREPARING:I = 0x1

.field private static final TAG:Ljava/lang/String; = "MediaPlayer2Impl"

.field private static sErrorEventMap:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static sInfoEventMap:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static sStateMap:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mBaseMediaPlayerImpl:Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

.field private mCurrentTask:Landroid/support/v4/media/MediaPlayer2Impl$Task;
    .annotation build Landroid/support/annotation/GuardedBy;
        value = "mTaskLock"
    .end annotation
.end field

.field private mDrmEventCallbackRecord:Landroid/util/Pair;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/Pair<",
            "Ljava/util/concurrent/Executor;",
            "Landroid/support/v4/media/MediaPlayer2$DrmEventCallback;",
            ">;"
        }
    .end annotation
.end field

.field private final mEndPositionHandler:Landroid/os/Handler;

.field private mHandlerThread:Landroid/os/HandlerThread;

.field private final mLock:Ljava/lang/Object;

.field private mMp2EventCallbackRecord:Landroid/util/Pair;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/Pair<",
            "Ljava/util/concurrent/Executor;",
            "Landroid/support/v4/media/MediaPlayer2$EventCallback;",
            ">;"
        }
    .end annotation
.end field

.field private final mPendingTasks:Ljava/util/ArrayDeque;
    .annotation build Landroid/support/annotation/GuardedBy;
        value = "mTaskLock"
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayDeque<",
            "Landroid/support/v4/media/MediaPlayer2Impl$Task;",
            ">;"
        }
    .end annotation
.end field

.field private mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

.field private mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/support/v4/util/ArrayMap<",
            "Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;",
            "Ljava/util/concurrent/Executor;",
            ">;"
        }
    .end annotation
.end field

.field private final mTaskHandler:Landroid/os/Handler;

.field private final mTaskLock:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 87
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    sput-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    .line 88
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 90
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/4 v3, 0x3

    .line 91
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 90
    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 92
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x2bc

    .line 93
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    .line 92
    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 94
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x2bd

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 95
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x2be

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 96
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x320

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 97
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x321

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 98
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x322

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 99
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x324

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x325

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x385

    .line 102
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    .line 101
    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 103
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x386

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    sput-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    .line 106
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 107
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0xc8

    .line 108
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 109
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    .line 107
    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, -0x3ec

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 v5, -0x3ec

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, -0x3ef

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 v5, -0x3ef

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 112
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, -0x3f2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 v5, -0x3f2

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 113
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, -0x6e

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 v5, -0x6e

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 115
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    sput-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    .line 116
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    const/4 v4, 0x0

    .line 117
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 116
    invoke-virtual {v0, v5, v6}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 118
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    .line 119
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 120
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 118
    invoke-virtual {v0, v5, v6}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 121
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    .line 122
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 123
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 121
    invoke-virtual {v0, v5, v6}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 124
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    .line 125
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 126
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 124
    invoke-virtual {v0, v5, v6}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    sput-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    .line 129
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    const/16 v5, 0x3e9

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v0, v5, v4}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x3ea

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 131
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    const/16 v4, 0x3eb

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    const/16 v1, 0x3ec

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    const/16 v1, 0x3ed

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 174
    invoke-direct {p0}, Landroid/support/v4/media/MediaPlayer2;-><init>()V

    .line 141
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskLock:Ljava/lang/Object;

    .line 142
    new-instance v0, Ljava/util/ArrayDeque;

    invoke-direct {v0}, Ljava/util/ArrayDeque;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPendingTasks:Ljava/util/ArrayDeque;

    .line 147
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    .line 150
    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;

    .line 175
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "MediaPlayer2TaskThread"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    .line 176
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 177
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    .line 178
    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mEndPositionHandler:Landroid/os/Handler;

    .line 179
    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskHandler:Landroid/os/Handler;

    .line 183
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-direct {v0, p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;)V

    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    return-void
.end method

.method static synthetic access$100(Landroid/support/v4/media/MediaPlayer2Impl;)Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;
    .locals 0

    .line 72
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    return-object p0
.end method

.method static synthetic access$1400(Landroid/support/v4/media/MediaPlayer2Impl;)V
    .locals 0

    .line 72
    invoke-direct {p0}, Landroid/support/v4/media/MediaPlayer2Impl;->processPendingTask_l()V

    return-void
.end method

.method static synthetic access$1500()Landroid/support/v4/util/ArrayMap;
    .locals 1

    .line 72
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sErrorEventMap:Landroid/support/v4/util/ArrayMap;

    return-object v0
.end method

.method static synthetic access$1600()Landroid/support/v4/util/ArrayMap;
    .locals 1

    .line 72
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sInfoEventMap:Landroid/support/v4/util/ArrayMap;

    return-object v0
.end method

.method static synthetic access$1700(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/media/MediaPlayer$OnCompletionListener;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaTimestamp;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1, p2, p3}, Landroid/support/v4/media/MediaPlayer2Impl;->setEndPositionTimerIfNeeded(Landroid/media/MediaPlayer$OnCompletionListener;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaTimestamp;)V

    return-void
.end method

.method static synthetic access$1800(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$DrmEventNotifier;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->notifyDrmEvent(Landroid/support/v4/media/MediaPlayer2Impl$DrmEventNotifier;)V

    return-void
.end method

.method static synthetic access$1900()Landroid/support/v4/util/ArrayMap;
    .locals 1

    .line 72
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sPrepareDrmStatusMap:Landroid/support/v4/util/ArrayMap;

    return-object v0
.end method

.method static synthetic access$200(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$DataSourceError;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->handleDataSourceError(Landroid/support/v4/media/MediaPlayer2Impl$DataSourceError;)V

    return-void
.end method

.method static synthetic access$2000(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->setUpListeners(Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    return-void
.end method

.method static synthetic access$2100(Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 72
    invoke-static {p0}, Landroid/support/v4/media/MediaPlayer2Impl;->handleDataSource(Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    return-void
.end method

.method static synthetic access$2200()Landroid/support/v4/util/ArrayMap;
    .locals 1

    .line 72
    sget-object v0, Landroid/support/v4/media/MediaPlayer2Impl;->sStateMap:Landroid/support/v4/util/ArrayMap;

    return-object v0
.end method

.method static synthetic access$2300(Landroid/support/v4/media/MediaPlayer2Impl;)I
    .locals 0

    .line 72
    invoke-direct {p0}, Landroid/support/v4/media/MediaPlayer2Impl;->getPlayerState()I

    move-result p0

    return p0
.end method

.method static synthetic access$2400(Landroid/support/v4/media/MediaPlayer2Impl;)I
    .locals 0

    .line 72
    invoke-direct {p0}, Landroid/support/v4/media/MediaPlayer2Impl;->getBufferingState()I

    move-result p0

    return p0
.end method

.method static synthetic access$2500(Landroid/support/v4/media/MediaPlayer2Impl;Ljava/util/concurrent/Executor;Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1, p2}, Landroid/support/v4/media/MediaPlayer2Impl;->registerPlayerEventCallback(Ljava/util/concurrent/Executor;Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V

    return-void
.end method

.method static synthetic access$2600(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->unregisterPlayerEventCallback(Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V

    return-void
.end method

.method static synthetic access$300(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->notifyMediaPlayer2Event(Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;)V

    return-void
.end method

.method static synthetic access$400(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/media/PlaybackParams;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->setPlaybackParamsInternal(Landroid/media/PlaybackParams;)V

    return-void
.end method

.method static synthetic access$600(Landroid/support/v4/media/MediaPlayer2Impl;)Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;
    .locals 0

    .line 72
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mBaseMediaPlayerImpl:Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

    return-object p0
.end method

.method static synthetic access$700(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;)V
    .locals 0

    .line 72
    invoke-direct {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl;->notifyPlayerEvent(Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;)V

    return-void
.end method

.method static synthetic access$800(Landroid/support/v4/media/MediaPlayer2Impl;)Ljava/lang/Object;
    .locals 0

    .line 72
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskLock:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic access$900(Landroid/support/v4/media/MediaPlayer2Impl;)Landroid/support/v4/media/MediaPlayer2Impl$Task;
    .locals 0

    .line 72
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mCurrentTask:Landroid/support/v4/media/MediaPlayer2Impl$Task;

    return-object p0
.end method

.method static synthetic access$902(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$Task;)Landroid/support/v4/media/MediaPlayer2Impl$Task;
    .locals 0

    .line 72
    iput-object p1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mCurrentTask:Landroid/support/v4/media/MediaPlayer2Impl$Task;

    return-object p1
.end method

.method private addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V
    .locals 2

    .line 593
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskLock:Ljava/lang/Object;

    monitor-enter v0

    .line 594
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPendingTasks:Ljava/util/ArrayDeque;

    invoke-virtual {v1, p1}, Ljava/util/ArrayDeque;->add(Ljava/lang/Object;)Z

    .line 595
    invoke-direct {p0}, Landroid/support/v4/media/MediaPlayer2Impl;->processPendingTask_l()V

    .line 596
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private getBufferingState()I
    .locals 0

    .line 356
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getBufferingState()I

    move-result p0

    return p0
.end method

.method private getPlayerState()I
    .locals 0

    .line 347
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getPlayerState()I

    move-result p0

    return p0
.end method

.method private static handleDataSource(Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 613
    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;->getDSD()Landroid/support/v4/media/DataSourceDesc;

    move-result-object v0

    const-string v1, "the DataSourceDesc cannot be null"

    .line 614
    invoke-static {v0, v1}, Landroid/support/v4/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 616
    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;->getPlayer()Landroid/media/MediaPlayer;

    move-result-object v2

    .line 617
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getType()I

    move-result p0

    packed-switch p0, :pswitch_data_0

    goto :goto_0

    .line 648
    :pswitch_0
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getUriContext()Landroid/content/Context;

    move-result-object p0

    .line 649
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getUri()Landroid/net/Uri;

    move-result-object v1

    .line 650
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getUriHeaders()Ljava/util/Map;

    move-result-object v3

    .line 651
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getUriCookies()Ljava/util/List;

    move-result-object v0

    .line 647
    invoke-virtual {v2, p0, v1, v3, v0}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;Ljava/util/Map;Ljava/util/List;)V

    goto :goto_0

    .line 641
    :pswitch_1
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v3

    .line 642
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getFileDescriptorOffset()J

    move-result-wide v4

    .line 643
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getFileDescriptorLength()J

    move-result-wide v6

    .line 640
    invoke-virtual/range {v2 .. v7}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V

    goto :goto_0

    .line 619
    :pswitch_2
    new-instance p0, Landroid/support/v4/media/MediaPlayer2Impl$14;

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl$14;-><init>(Landroid/support/v4/media/DataSourceDesc;)V

    invoke-virtual {v2, p0}, Landroid/media/MediaPlayer;->setDataSource(Landroid/media/MediaDataSource;)V

    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private handleDataSourceError(Landroid/support/v4/media/MediaPlayer2Impl$DataSourceError;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 160
    :cond_0
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$1;

    invoke-direct {v0, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$1;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$DataSourceError;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->notifyMediaPlayer2Event(Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;)V

    return-void
.end method

.method private notifyDrmEvent(Landroid/support/v4/media/MediaPlayer2Impl$DrmEventNotifier;)V
    .locals 3

    .line 1427
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 1428
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mDrmEventCallbackRecord:Landroid/util/Pair;

    .line 1429
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    .line 1431
    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/util/concurrent/Executor;

    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$26;

    invoke-direct {v2, p0, p1, v1}, Landroid/support/v4/media/MediaPlayer2Impl$26;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$DrmEventNotifier;Landroid/util/Pair;)V

    invoke-interface {v0, v2}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return-void

    :catchall_0
    move-exception p0

    .line 1429
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private notifyMediaPlayer2Event(Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;)V
    .locals 3

    .line 1394
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 1395
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mMp2EventCallbackRecord:Landroid/util/Pair;

    .line 1396
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    .line 1398
    iget-object v0, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/util/concurrent/Executor;

    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$24;

    invoke-direct {v2, p0, p1, v1}, Landroid/support/v4/media/MediaPlayer2Impl$24;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$Mp2EventNotifier;Landroid/util/Pair;)V

    invoke-interface {v0, v2}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return-void

    :catchall_0
    move-exception p0

    .line 1396
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private notifyPlayerEvent(Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;)V
    .locals 6

    .line 1409
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 1410
    :try_start_0
    new-instance v1, Landroid/support/v4/util/ArrayMap;

    iget-object v2, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;

    invoke-direct {v1, v2}, Landroid/support/v4/util/ArrayMap;-><init>(Landroid/support/v4/util/SimpleArrayMap;)V

    .line 1411
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1412
    invoke-virtual {v1}, Landroid/support/v4/util/ArrayMap;->size()I

    move-result v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    .line 1414
    invoke-virtual {v1, v2}, Landroid/support/v4/util/ArrayMap;->valueAt(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/concurrent/Executor;

    .line 1415
    invoke-virtual {v1, v2}, Landroid/support/v4/util/ArrayMap;->keyAt(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;

    .line 1416
    new-instance v5, Landroid/support/v4/media/MediaPlayer2Impl$25;

    invoke-direct {v5, p0, p1, v4}, Landroid/support/v4/media/MediaPlayer2Impl$25;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V

    invoke-interface {v3, v5}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void

    :catchall_0
    move-exception p0

    .line 1411
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private processPendingTask_l()V
    .locals 1
    .annotation build Landroid/support/annotation/GuardedBy;
        value = "mTaskLock"
    .end annotation

    .line 601
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mCurrentTask:Landroid/support/v4/media/MediaPlayer2Impl$Task;

    if-eqz v0, :cond_0

    return-void

    .line 604
    :cond_0
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPendingTasks:Ljava/util/ArrayDeque;

    invoke-virtual {v0}, Ljava/util/ArrayDeque;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 605
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPendingTasks:Ljava/util/ArrayDeque;

    invoke-virtual {v0}, Ljava/util/ArrayDeque;->removeFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/v4/media/MediaPlayer2Impl$Task;

    .line 606
    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mCurrentTask:Landroid/support/v4/media/MediaPlayer2Impl$Task;

    .line 607
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskHandler:Landroid/os/Handler;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    return-void
.end method

.method private registerPlayerEventCallback(Ljava/util/concurrent/Executor;Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V
    .locals 1
    .param p1    # Ljava/util/concurrent/Executor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    if-nez p2, :cond_0

    .line 514
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null PlayerEventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    if-nez p1, :cond_1

    .line 517
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null Executor for the PlayerEventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 520
    :cond_1
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 521
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {p0, p2, p1}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 522
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private setEndPositionTimerIfNeeded(Landroid/media/MediaPlayer$OnCompletionListener;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaTimestamp;)V
    .locals 7

    .line 1455
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {v0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getFirst()Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;

    move-result-object v0

    if-ne p2, v0, :cond_1

    .line 1456
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mEndPositionHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 1457
    invoke-virtual {p2}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;->getDSD()Landroid/support/v4/media/DataSourceDesc;

    move-result-object v0

    .line 1458
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getEndPosition()J

    move-result-wide v1

    const-wide v3, 0x7ffffffffffffffL

    cmp-long v1, v1, v3

    if-eqz v1, :cond_1

    .line 1459
    invoke-virtual {p3}, Landroid/media/MediaTimestamp;->getMediaClockRate()F

    move-result v1

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-lez v1, :cond_1

    .line 1460
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v1

    .line 1461
    invoke-virtual {p3}, Landroid/media/MediaTimestamp;->getAnchorSytemNanoTime()J

    move-result-wide v3

    sub-long/2addr v1, v3

    const-wide/16 v3, 0x3e8

    div-long/2addr v1, v3

    .line 1462
    invoke-virtual {p3}, Landroid/media/MediaTimestamp;->getAnchorMediaTimeUs()J

    move-result-wide v5

    add-long/2addr v5, v1

    div-long/2addr v5, v3

    .line 1463
    invoke-virtual {v0}, Landroid/support/v4/media/DataSourceDesc;->getEndPosition()J

    move-result-wide v0

    sub-long/2addr v0, v5

    long-to-float v0, v0

    .line 1464
    invoke-virtual {p3}, Landroid/media/MediaTimestamp;->getMediaClockRate()F

    move-result p3

    div-float/2addr v0, p3

    float-to-long v0, v0

    .line 1465
    iget-object p3, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mEndPositionHandler:Landroid/os/Handler;

    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$27;

    invoke-direct {v2, p0, p2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$27;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaPlayer$OnCompletionListener;)V

    const-wide/16 p0, 0x0

    cmp-long p2, v0, p0

    if-gez p2, :cond_0

    goto :goto_0

    :cond_0
    move-wide p0, v0

    :goto_0
    invoke-virtual {p3, v2, p0, p1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_1
    return-void
.end method

.method private setPlaybackParamsInternal(Landroid/media/PlaybackParams;)V
    .locals 2

    .line 1377
    :try_start_0
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {v0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getPlaybackParams()Landroid/media/PlaybackParams;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    .line 1381
    :goto_0
    iget-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {v1, p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->setPlaybackParams(Landroid/media/PlaybackParams;)V

    if-eqz v0, :cond_0

    .line 1382
    invoke-virtual {v0}, Landroid/media/PlaybackParams;->getSpeed()F

    move-result v0

    invoke-virtual {p1}, Landroid/media/PlaybackParams;->getSpeed()F

    move-result v1

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_0

    .line 1383
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$23;

    invoke-direct {v0, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$23;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/media/PlaybackParams;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->notifyPlayerEvent(Landroid/support/v4/media/MediaPlayer2Impl$PlayerEventNotifier;)V

    :cond_0
    return-void
.end method

.method private setUpListeners(Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V
    .locals 4

    .line 1481
    invoke-virtual {p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;->getPlayer()Landroid/media/MediaPlayer;

    move-result-object v0

    .line 1482
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$28;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$28;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    .line 1513
    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$29;

    invoke-direct {v2, p0, p1, v1}, Landroid/support/v4/media/MediaPlayer2Impl$29;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaPlayer$OnPreparedListener;)V

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 1525
    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$30;

    invoke-direct {v2, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$30;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnVideoSizeChangedListener(Landroid/media/MediaPlayer$OnVideoSizeChangedListener;)V

    .line 1536
    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$31;

    invoke-direct {v2, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$31;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnInfoListener(Landroid/media/MediaPlayer$OnInfoListener;)V

    .line 1561
    new-instance v2, Landroid/support/v4/media/MediaPlayer2Impl$32;

    invoke-direct {v2, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$32;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    .line 1576
    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 1577
    new-instance v3, Landroid/support/v4/media/MediaPlayer2Impl$33;

    invoke-direct {v3, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$33;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v3}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 1599
    new-instance v3, Landroid/support/v4/media/MediaPlayer2Impl$34;

    invoke-direct {v3, p0, p1, v1}, Landroid/support/v4/media/MediaPlayer2Impl$34;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaPlayer$OnPreparedListener;)V

    invoke-virtual {v0, v3}, Landroid/media/MediaPlayer;->setOnSeekCompleteListener(Landroid/media/MediaPlayer$OnSeekCompleteListener;)V

    .line 1629
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$35;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$35;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnTimedMetaDataAvailableListener(Landroid/media/MediaPlayer$OnTimedMetaDataAvailableListener;)V

    .line 1642
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$36;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$36;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnInfoListener(Landroid/media/MediaPlayer$OnInfoListener;)V

    .line 1655
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$37;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$37;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnBufferingUpdateListener(Landroid/media/MediaPlayer$OnBufferingUpdateListener;)V

    .line 1672
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$38;

    invoke-direct {v1, p0, p1, v2}, Landroid/support/v4/media/MediaPlayer2Impl$38;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;Landroid/media/MediaPlayer$OnCompletionListener;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnMediaTimeDiscontinuityListener(Landroid/media/MediaPlayer$OnMediaTimeDiscontinuityListener;)V

    .line 1688
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$39;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$39;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnSubtitleDataListener(Landroid/media/MediaPlayer$OnSubtitleDataListener;)V

    .line 1700
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$40;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$40;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnDrmInfoListener(Landroid/media/MediaPlayer$OnDrmInfoListener;)V

    .line 1712
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$41;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$41;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnDrmPreparedListener(Landroid/media/MediaPlayer$OnDrmPreparedListener;)V

    return-void
.end method

.method private unregisterPlayerEventCallback(Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;)V
    .locals 1
    .param p1    # Landroid/support/v4/media/BaseMediaPlayer$PlayerEventCallback;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    if-nez p1, :cond_0

    .line 531
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null PlayerEventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 533
    :cond_0
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 534
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {p0, p1}, Landroid/support/v4/util/ArrayMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 535
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method


# virtual methods
.method public attachAuxEffect(I)V
    .locals 3

    .line 857
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$18;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$18;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZI)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public clearDrmEventCallback()V
    .locals 2

    .line 1146
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 1147
    :try_start_0
    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mDrmEventCallbackRecord:Landroid/util/Pair;

    .line 1148
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public clearEventCallback()V
    .locals 2

    .line 1092
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 1093
    :try_start_0
    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mMp2EventCallbackRecord:Landroid/util/Pair;

    .line 1094
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public clearPendingCommands()V
    .locals 1

    .line 587
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mTaskLock:Ljava/lang/Object;

    monitor-enter v0

    .line 588
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPendingTasks:Ljava/util/ArrayDeque;

    invoke-virtual {p0}, Ljava/util/ArrayDeque;->clear()V

    .line 589
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public close()V
    .locals 1

    .line 225
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {v0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->release()V

    .line 226
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    if-eqz v0, :cond_0

    .line 227
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quitSafely()Z

    const/4 v0, 0x0

    .line 228
    iput-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mHandlerThread:Landroid/os/HandlerThread;

    :cond_0
    return-void
.end method

.method public deselectTrack(I)V
    .locals 3

    .line 1057
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$21;

    const/4 v1, 0x2

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$21;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZI)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public getAudioAttributes()Landroid/support/v4/media/AudioAttributesCompat;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .line 379
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getAudioAttributes()Landroid/support/v4/media/AudioAttributesCompat;

    move-result-object p0

    return-object p0
.end method

.method public getAudioSessionId()I
    .locals 0

    .line 838
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getAudioSessionId()I

    move-result p0

    return p0
.end method

.method public getBaseMediaPlayer()Landroid/support/v4/media/BaseMediaPlayer;
    .locals 3

    .line 192
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 193
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mBaseMediaPlayerImpl:Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

    if-nez v1, :cond_0

    .line 194
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2Impl$1;)V

    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mBaseMediaPlayerImpl:Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

    .line 196
    :cond_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mBaseMediaPlayerImpl:Landroid/support/v4/media/MediaPlayer2Impl$BaseMediaPlayerImpl;

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    .line 197
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public getBufferedPosition()J
    .locals 2

    .line 333
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getBufferedPosition()J

    move-result-wide v0

    return-wide v0
.end method

.method public getCurrentDataSource()Landroid/support/v4/media/DataSourceDesc;
    .locals 0
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 452
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getFirst()Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;

    move-result-object p0

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSource;->getDSD()Landroid/support/v4/media/DataSourceDesc;

    move-result-object p0

    return-object p0
.end method

.method public getCurrentPosition()J
    .locals 2

    .line 307
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getCurrentPosition()J

    move-result-wide v0

    return-wide v0
.end method

.method public getDrmInfo()Landroid/support/v4/media/MediaPlayer2$DrmInfo;
    .locals 3

    .line 1159
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getDrmInfo()Landroid/media/MediaPlayer$DrmInfo;

    move-result-object p0

    const/4 v0, 0x0

    if-nez p0, :cond_0

    goto :goto_0

    .line 1160
    :cond_0
    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$DrmInfoImpl;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$DrmInfo;->getPssh()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {p0}, Landroid/media/MediaPlayer$DrmInfo;->getSupportedSchemes()[Ljava/util/UUID;

    move-result-object p0

    invoke-direct {v1, v2, p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl$DrmInfoImpl;-><init>(Ljava/util/Map;[Ljava/util/UUID;Landroid/support/v4/media/MediaPlayer2Impl$1;)V

    move-object v0, v1

    :goto_0
    return-object v0
.end method

.method public getDrmKeyRequest([B[BLjava/lang/String;ILjava/util/Map;)Landroid/media/MediaDrm$KeyRequest;
    .locals 6
    .param p1    # [B
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # [B
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p5    # Ljava/util/Map;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B[B",
            "Ljava/lang/String;",
            "I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Landroid/media/MediaDrm$KeyRequest;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;
        }
    .end annotation

    .line 1275
    :try_start_0
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getKeyRequest([B[BLjava/lang/String;ILjava/util/Map;)Landroid/media/MediaDrm$KeyRequest;

    move-result-object p0
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 1277
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public getDrmPropertyString(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;
        }
    .end annotation

    .line 1345
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getDrmPropertyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 1347
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public getDuration()J
    .locals 2

    .line 318
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getDuration()J

    move-result-wide v0

    return-wide v0
.end method

.method public getMaxPlayerVolume()F
    .locals 0

    const/high16 p0, 0x3f800000    # 1.0f

    return p0
.end method

.method public getMetrics()Landroid/os/PersistableBundle;
    .locals 0

    .line 691
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getMetrics()Landroid/os/PersistableBundle;

    move-result-object p0

    return-object p0
.end method

.method public getPlaybackParams()Landroid/support/v4/media/PlaybackParams2;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .line 728
    new-instance v0, Landroid/support/v4/media/PlaybackParams2$Builder;

    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getPlaybackParams()Landroid/media/PlaybackParams;

    move-result-object p0

    invoke-direct {v0, p0}, Landroid/support/v4/media/PlaybackParams2$Builder;-><init>(Landroid/media/PlaybackParams;)V

    invoke-virtual {v0}, Landroid/support/v4/media/PlaybackParams2$Builder;->build()Landroid/support/v4/media/PlaybackParams2;

    move-result-object p0

    return-object p0
.end method

.method public getPlayerVolume()F
    .locals 0

    .line 495
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getVolume()F

    move-result p0

    return p0
.end method

.method public getSelectedTrack(I)I
    .locals 0

    .line 1000
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getSelectedTrack(I)I

    move-result p0

    return p0
.end method

.method public getState()I
    .locals 0

    .line 343
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getMediaPlayer2State()I

    move-result p0

    return p0
.end method

.method public getTimestamp()Landroid/support/v4/media/MediaTimestamp2;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .line 791
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getTimestamp()Landroid/support/v4/media/MediaTimestamp2;

    move-result-object p0

    return-object p0
.end method

.method public getTrackInfo()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/support/v4/media/MediaPlayer2$TrackInfo;",
            ">;"
        }
    .end annotation

    .line 973
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getTrackInfo()[Landroid/media/MediaPlayer$TrackInfo;

    move-result-object p0

    .line 974
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 975
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p0, v2

    .line 976
    new-instance v4, Landroid/support/v4/media/MediaPlayer2Impl$TrackInfoImpl;

    invoke-virtual {v3}, Landroid/media/MediaPlayer$TrackInfo;->getTrackType()I

    move-result v5

    invoke-virtual {v3}, Landroid/media/MediaPlayer$TrackInfo;->getFormat()Landroid/media/MediaFormat;

    move-result-object v3

    invoke-direct {v4, v5, v3}, Landroid/support/v4/media/MediaPlayer2Impl$TrackInfoImpl;-><init>(ILandroid/media/MediaFormat;)V

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public getVideoHeight()I
    .locals 0

    .line 686
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getVideoHeight()I

    move-result p0

    return p0
.end method

.method public getVideoWidth()I
    .locals 0

    .line 671
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->getVideoWidth()I

    move-result p0

    return p0
.end method

.method public loopCurrent(Z)V
    .locals 3

    .line 461
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$10;

    const/4 v1, 0x3

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$10;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZZ)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public notifyWhenCommandLabelReached(Ljava/lang/Object;)V
    .locals 3

    .line 540
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$12;

    const/16 v1, 0x3eb

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$12;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLjava/lang/Object;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public pause()V
    .locals 3

    .line 277
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$4;

    const/4 v1, 0x4

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Landroid/support/v4/media/MediaPlayer2Impl$4;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZ)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public play()V
    .locals 3

    .line 242
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$2;

    const/4 v1, 0x5

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Landroid/support/v4/media/MediaPlayer2Impl$2;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZ)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public prepare()V
    .locals 3

    .line 262
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$3;

    const/4 v1, 0x6

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Landroid/support/v4/media/MediaPlayer2Impl$3;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZ)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public prepareDrm(Ljava/util/UUID;)V
    .locals 0
    .param p1    # Ljava/util/UUID;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/media/UnsupportedSchemeException;,
            Landroid/media/ResourceBusyException;,
            Landroid/support/v4/media/MediaPlayer2$ProvisioningNetworkErrorException;,
            Landroid/support/v4/media/MediaPlayer2$ProvisioningServerErrorException;
        }
    .end annotation

    .line 1204
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->prepareDrm(Ljava/util/UUID;)V
    :try_end_0
    .catch Landroid/media/MediaPlayer$ProvisioningNetworkErrorException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/media/MediaPlayer$ProvisioningServerErrorException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 1208
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$ProvisioningServerErrorException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$ProvisioningServerErrorException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$ProvisioningServerErrorException;-><init>(Ljava/lang/String;)V

    throw p1

    :catch_1
    move-exception p0

    .line 1206
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$ProvisioningNetworkErrorException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$ProvisioningNetworkErrorException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$ProvisioningNetworkErrorException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public provideDrmKeyResponse([B[B)[B
    .locals 0
    .param p1    # [B
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # [B
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;,
            Landroid/media/DeniedByServerException;
        }
    .end annotation

    .line 1305
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->provideKeyResponse([B[B)[B

    move-result-object p0
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 1307
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public releaseDrm()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;
        }
    .end annotation

    .line 1224
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->releaseDrm()V
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 1226
    new-instance v0, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public reset()V
    .locals 3

    .line 801
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {v0}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->reset()V

    .line 802
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 803
    :try_start_0
    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mMp2EventCallbackRecord:Landroid/util/Pair;

    .line 804
    iget-object v2, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayerEventCallbackMap:Landroid/support/v4/util/ArrayMap;

    invoke-virtual {v2}, Landroid/support/v4/util/ArrayMap;->clear()V

    .line 805
    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mDrmEventCallbackRecord:Landroid/util/Pair;

    .line 806
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public restoreDrmKeys([B)V
    .locals 0
    .param p1    # [B
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;
        }
    .end annotation

    .line 1322
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->restoreKeys([B)V
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 1324
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public seekTo(JI)V
    .locals 8

    .line 763
    new-instance v7, Landroid/support/v4/media/MediaPlayer2Impl$16;

    const/16 v2, 0xe

    const/4 v3, 0x1

    move-object v0, v7

    move-object v1, p0

    move-wide v4, p1

    move v6, p3

    invoke-direct/range {v0 .. v6}, Landroid/support/v4/media/MediaPlayer2Impl$16;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZJI)V

    invoke-direct {p0, v7}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public selectTrack(I)V
    .locals 3

    .line 1033
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$20;

    const/16 v1, 0xf

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$20;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZI)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setAudioAttributes(Landroid/support/v4/media/AudioAttributesCompat;)V
    .locals 3
    .param p1    # Landroid/support/v4/media/AudioAttributesCompat;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 369
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$6;

    const/16 v1, 0x10

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$6;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLandroid/support/v4/media/AudioAttributesCompat;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setAudioSessionId(I)V
    .locals 3

    .line 828
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$17;

    const/16 v1, 0x11

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$17;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZI)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setAuxEffectSendLevel(F)V
    .locals 3

    .line 879
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$19;

    const/16 v1, 0x12

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$19;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZF)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setDataSource(Landroid/support/v4/media/DataSourceDesc;)V
    .locals 3
    .param p1    # Landroid/support/v4/media/DataSourceDesc;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 391
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$7;

    const/16 v1, 0x13

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$7;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLandroid/support/v4/media/DataSourceDesc;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setDrmEventCallback(Ljava/util/concurrent/Executor;Landroid/support/v4/media/MediaPlayer2$DrmEventCallback;)V
    .locals 2
    .param p1    # Ljava/util/concurrent/Executor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/v4/media/MediaPlayer2$DrmEventCallback;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    if-nez p2, :cond_0

    .line 1130
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null EventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    if-nez p1, :cond_1

    .line 1133
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null Executor for the EventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1136
    :cond_1
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 1137
    :try_start_0
    new-instance v1, Landroid/util/Pair;

    invoke-direct {v1, p1, p2}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mDrmEventCallbackRecord:Landroid/util/Pair;

    .line 1138
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public setDrmPropertyString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;
        }
    .end annotation

    .line 1368
    :try_start_0
    iget-object p0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->setDrmPropertyString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/media/MediaPlayer$NoDrmSchemeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 1370
    new-instance p1, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;

    invoke-virtual {p0}, Landroid/media/MediaPlayer$NoDrmSchemeException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Landroid/support/v4/media/MediaPlayer2$NoDrmSchemeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setEventCallback(Ljava/util/concurrent/Executor;Landroid/support/v4/media/MediaPlayer2$EventCallback;)V
    .locals 2
    .param p1    # Ljava/util/concurrent/Executor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/support/v4/media/MediaPlayer2$EventCallback;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    if-nez p2, :cond_0

    .line 1076
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null EventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    if-nez p1, :cond_1

    .line 1079
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Illegal null Executor for the EventCallback"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1082
    :cond_1
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 1083
    :try_start_0
    new-instance v1, Landroid/util/Pair;

    invoke-direct {v1, p1, p2}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    iput-object v1, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mMp2EventCallbackRecord:Landroid/util/Pair;

    .line 1084
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method public setNextDataSource(Landroid/support/v4/media/DataSourceDesc;)V
    .locals 3
    .param p1    # Landroid/support/v4/media/DataSourceDesc;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 415
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$8;

    const/16 v1, 0x16

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$8;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLandroid/support/v4/media/DataSourceDesc;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setNextDataSources(Ljava/util/List;)V
    .locals 3
    .param p1    # Ljava/util/List;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/support/v4/media/DataSourceDesc;",
            ">;)V"
        }
    .end annotation

    .line 433
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$9;

    const/16 v1, 0x17

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$9;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLjava/util/List;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setOnDrmConfigHelper(Landroid/support/v4/media/MediaPlayer2$OnDrmConfigHelper;)V
    .locals 2

    .line 1109
    iget-object v0, p0, Landroid/support/v4/media/MediaPlayer2Impl;->mPlayer:Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;

    new-instance v1, Landroid/support/v4/media/MediaPlayer2Impl$22;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/MediaPlayer2Impl$22;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;Landroid/support/v4/media/MediaPlayer2$OnDrmConfigHelper;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/media/MediaPlayer2Impl$MediaPlayerSourceQueue;->setOnDrmConfigHelper(Landroid/media/MediaPlayer$OnDrmConfigHelper;)V

    return-void
.end method

.method public setPlaybackParams(Landroid/support/v4/media/PlaybackParams2;)V
    .locals 3
    .param p1    # Landroid/support/v4/media/PlaybackParams2;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    .line 710
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$15;

    const/16 v1, 0x18

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$15;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLandroid/support/v4/media/PlaybackParams2;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setPlayerVolume(F)V
    .locals 3

    .line 480
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$11;

    const/16 v1, 0x1a

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$11;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZF)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public setSurface(Landroid/view/Surface;)V
    .locals 3

    .line 574
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$13;

    const/16 v1, 0x1b

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2, p1}, Landroid/support/v4/media/MediaPlayer2Impl$13;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZLandroid/view/Surface;)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method

.method public skipToNext()V
    .locals 3

    .line 292
    new-instance v0, Landroid/support/v4/media/MediaPlayer2Impl$5;

    const/16 v1, 0x1d

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Landroid/support/v4/media/MediaPlayer2Impl$5;-><init>(Landroid/support/v4/media/MediaPlayer2Impl;IZ)V

    invoke-direct {p0, v0}, Landroid/support/v4/media/MediaPlayer2Impl;->addTask(Landroid/support/v4/media/MediaPlayer2Impl$Task;)V

    return-void
.end method
