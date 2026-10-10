.class Landroid/support/v4/media/MediaSession2Stub$3;
.super Ljava/lang/Object;
.source "MediaSession2Stub.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/v4/media/MediaSession2Stub;->connect(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/v4/media/MediaSession2Stub;

.field final synthetic val$caller:Landroid/support/v4/media/IMediaController2;

.field final synthetic val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;


# direct methods
.method constructor <init>(Landroid/support/v4/media/MediaSession2Stub;Landroid/support/v4/media/MediaSession2$ControllerInfo;Landroid/support/v4/media/IMediaController2;)V
    .locals 0

    .line 243
    iput-object p1, p0, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iput-object p2, p0, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    iput-object p3, p0, Landroid/support/v4/media/MediaSession2Stub$3;->val$caller:Landroid/support/v4/media/IMediaController2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 21

    move-object/from16 v1, p0

    .line 246
    iget-object v2, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v2, v2, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v2}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->isClosed()Z

    move-result v2

    if-eqz v2, :cond_0

    return-void

    .line 249
    :cond_0
    iget-object v2, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v2}, Landroid/support/v4/media/MediaSession2Stub;->access$000(Landroid/support/v4/media/MediaSession2Stub;)Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 253
    :try_start_0
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v3}, Landroid/support/v4/media/MediaSession2Stub;->access$500(Landroid/support/v4/media/MediaSession2Stub;)Ljava/util/Set;

    move-result-object v3

    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v4}, Landroid/support/v4/media/MediaSession2$ControllerInfo;->getId()Landroid/os/IBinder;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 254
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 255
    iget-object v2, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v2, v2, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v2}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getCallback()Landroid/support/v4/media/MediaSession2$SessionCallback;

    move-result-object v2

    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    .line 256
    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getInstance()Landroid/support/v4/media/MediaSession2;

    move-result-object v3

    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    .line 255
    invoke-virtual {v2, v3, v4}, Landroid/support/v4/media/MediaSession2$SessionCallback;->onConnect(Landroid/support/v4/media/MediaSession2;Landroid/support/v4/media/MediaSession2$ControllerInfo;)Landroid/support/v4/media/SessionCommandGroup2;

    move-result-object v2

    if-nez v2, :cond_2

    .line 260
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v3}, Landroid/support/v4/media/MediaSession2$ControllerInfo;->isTrusted()Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v3, 0x1

    :goto_1
    if-eqz v3, :cond_7

    const-string v3, "MediaSession2Stub"

    .line 263
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Accepting connection, controllerInfo="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v5, " allowedCommands="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v2, :cond_3

    .line 269
    new-instance v2, Landroid/support/v4/media/SessionCommandGroup2;

    invoke-direct {v2}, Landroid/support/v4/media/SessionCommandGroup2;-><init>()V

    .line 271
    :cond_3
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v3}, Landroid/support/v4/media/MediaSession2Stub;->access$000(Landroid/support/v4/media/MediaSession2Stub;)Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3

    .line 272
    :try_start_1
    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v4}, Landroid/support/v4/media/MediaSession2Stub;->access$500(Landroid/support/v4/media/MediaSession2Stub;)Ljava/util/Set;

    move-result-object v4

    iget-object v5, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v5}, Landroid/support/v4/media/MediaSession2$ControllerInfo;->getId()Landroid/os/IBinder;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 273
    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v4}, Landroid/support/v4/media/MediaSession2Stub;->access$100(Landroid/support/v4/media/MediaSession2Stub;)Landroid/support/v4/util/ArrayMap;

    move-result-object v4

    iget-object v5, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v5}, Landroid/support/v4/media/MediaSession2$ControllerInfo;->getId()Landroid/os/IBinder;

    move-result-object v5

    iget-object v6, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v4, v5, v6}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 274
    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v4}, Landroid/support/v4/media/MediaSession2Stub;->access$600(Landroid/support/v4/media/MediaSession2Stub;)Landroid/support/v4/util/ArrayMap;

    move-result-object v4

    iget-object v5, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v4, v5, v2}, Landroid/support/v4/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 275
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 283
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getPlayerState()I

    move-result v7

    .line 284
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getCurrentMediaItem()Landroid/support/v4/media/MediaItem2;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_4

    move-object v8, v4

    goto :goto_2

    :cond_4
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    .line 285
    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getCurrentMediaItem()Landroid/support/v4/media/MediaItem2;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/media/MediaItem2;->toBundle()Landroid/os/Bundle;

    move-result-object v3

    move-object v8, v3

    .line 286
    :goto_2
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v9

    .line 287
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getCurrentPosition()J

    move-result-wide v11

    .line 288
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getPlaybackSpeed()F

    move-result v13

    .line 289
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getBufferedPosition()J

    move-result-wide v14

    .line 290
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getPlaybackInfo()Landroid/support/v4/media/MediaController2$PlaybackInfo;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/media/MediaController2$PlaybackInfo;->toBundle()Landroid/os/Bundle;

    move-result-object v16

    .line 291
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getRepeatMode()I

    move-result v17

    .line 292
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getShuffleMode()I

    move-result v18

    .line 293
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getSessionActivity()Landroid/app/PendingIntent;

    move-result-object v20

    const/16 v3, 0x12

    .line 295
    invoke-virtual {v2, v3}, Landroid/support/v4/media/SessionCommandGroup2;->hasCommand(I)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    .line 297
    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->getPlaylist()Ljava/util/List;

    move-result-object v4

    .line 299
    :cond_5
    invoke-static {v4}, Landroid/support/v4/media/MediaUtils2;->convertMediaItem2ListToBundleList(Ljava/util/List;)Ljava/util/List;

    move-result-object v19

    .line 303
    iget-object v3, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    iget-object v3, v3, Landroid/support/v4/media/MediaSession2Stub;->mSession:Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;

    invoke-interface {v3}, Landroid/support/v4/media/MediaSession2$SupportLibraryImpl;->isClosed()Z

    move-result v3

    if-eqz v3, :cond_6

    return-void

    .line 307
    :cond_6
    :try_start_2
    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$caller:Landroid/support/v4/media/IMediaController2;

    iget-object v5, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-virtual {v2}, Landroid/support/v4/media/SessionCommandGroup2;->toBundle()Landroid/os/Bundle;

    move-result-object v6

    invoke-interface/range {v4 .. v20}, Landroid/support/v4/media/IMediaController2;->onConnected(Landroid/support/v4/media/IMediaSession2;Landroid/os/Bundle;ILandroid/os/Bundle;JJFJLandroid/os/Bundle;IILjava/util/List;Landroid/app/PendingIntent;)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_3

    :catchall_0
    move-exception v0

    move-object v1, v0

    .line 275
    :try_start_3
    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v1

    .line 315
    :cond_7
    iget-object v2, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v2}, Landroid/support/v4/media/MediaSession2Stub;->access$000(Landroid/support/v4/media/MediaSession2Stub;)Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3

    .line 316
    :try_start_4
    iget-object v2, v1, Landroid/support/v4/media/MediaSession2Stub$3;->this$0:Landroid/support/v4/media/MediaSession2Stub;

    invoke-static {v2}, Landroid/support/v4/media/MediaSession2Stub;->access$500(Landroid/support/v4/media/MediaSession2Stub;)Ljava/util/Set;

    move-result-object v2

    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v4}, Landroid/support/v4/media/MediaSession2$ControllerInfo;->getId()Landroid/os/IBinder;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 317
    monitor-exit v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    const-string v2, "MediaSession2Stub"

    .line 319
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Rejecting connection, controllerInfo="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$controllerInfo:Landroid/support/v4/media/MediaSession2$ControllerInfo;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    :try_start_5
    iget-object v1, v1, Landroid/support/v4/media/MediaSession2Stub$3;->val$caller:Landroid/support/v4/media/IMediaController2;

    invoke-interface {v1}, Landroid/support/v4/media/IMediaController2;->onDisconnected()V
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_0

    :catch_0
    :goto_3
    return-void

    :catchall_1
    move-exception v0

    move-object v1, v0

    .line 317
    :try_start_6
    monitor-exit v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    throw v1

    :catchall_2
    move-exception v0

    move-object v1, v0

    .line 254
    :try_start_7
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    throw v1
.end method
