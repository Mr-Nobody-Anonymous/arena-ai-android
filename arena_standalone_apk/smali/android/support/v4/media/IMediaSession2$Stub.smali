.class public abstract Landroid/support/v4/media/IMediaSession2$Stub;
.super Landroid/os/Binder;
.source "IMediaSession2.java"

# interfaces
.implements Landroid/support/v4/media/IMediaSession2;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/media/IMediaSession2;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/v4/media/IMediaSession2$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.support.v4.media.IMediaSession2"

.field static final TRANSACTION_addPlaylistItem:I = 0x17

.field static final TRANSACTION_adjustVolume:I = 0x4

.field static final TRANSACTION_connect:I = 0x1

.field static final TRANSACTION_fastForward:I = 0x9

.field static final TRANSACTION_getChildren:I = 0x24

.field static final TRANSACTION_getItem:I = 0x23

.field static final TRANSACTION_getLibraryRoot:I = 0x22

.field static final TRANSACTION_getSearchResult:I = 0x26

.field static final TRANSACTION_pause:I = 0x6

.field static final TRANSACTION_play:I = 0x5

.field static final TRANSACTION_playFromMediaId:I = 0x12

.field static final TRANSACTION_playFromSearch:I = 0x11

.field static final TRANSACTION_playFromUri:I = 0x10

.field static final TRANSACTION_prepare:I = 0x8

.field static final TRANSACTION_prepareFromMediaId:I = 0xf

.field static final TRANSACTION_prepareFromSearch:I = 0xe

.field static final TRANSACTION_prepareFromUri:I = 0xd

.field static final TRANSACTION_release:I = 0x2

.field static final TRANSACTION_removePlaylistItem:I = 0x18

.field static final TRANSACTION_replacePlaylistItem:I = 0x19

.field static final TRANSACTION_reset:I = 0x7

.field static final TRANSACTION_rewind:I = 0xa

.field static final TRANSACTION_search:I = 0x25

.field static final TRANSACTION_seekTo:I = 0xb

.field static final TRANSACTION_selectRoute:I = 0x21

.field static final TRANSACTION_sendCustomCommand:I = 0xc

.field static final TRANSACTION_setPlaybackSpeed:I = 0x14

.field static final TRANSACTION_setPlaylist:I = 0x15

.field static final TRANSACTION_setRating:I = 0x13

.field static final TRANSACTION_setRepeatMode:I = 0x1d

.field static final TRANSACTION_setShuffleMode:I = 0x1e

.field static final TRANSACTION_setVolumeTo:I = 0x3

.field static final TRANSACTION_skipToNextItem:I = 0x1c

.field static final TRANSACTION_skipToPlaylistItem:I = 0x1a

.field static final TRANSACTION_skipToPreviousItem:I = 0x1b

.field static final TRANSACTION_subscribe:I = 0x27

.field static final TRANSACTION_subscribeRoutesInfo:I = 0x1f

.field static final TRANSACTION_unsubscribe:I = 0x28

.field static final TRANSACTION_unsubscribeRoutesInfo:I = 0x20

.field static final TRANSACTION_updatePlaylistMetadata:I = 0x16


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 21
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "android.support.v4.media.IMediaSession2"

    .line 22
    invoke-virtual {p0, p0, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaSession2;
    .locals 2

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    const-string v0, "android.support.v4.media.IMediaSession2"

    .line 33
    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 34
    instance-of v1, v0, Landroid/support/v4/media/IMediaSession2;

    if-eqz v1, :cond_1

    .line 35
    check-cast v0, Landroid/support/v4/media/IMediaSession2;

    return-object v0

    .line 37
    :cond_1
    new-instance v0, Landroid/support/v4/media/IMediaSession2$Stub$Proxy;

    invoke-direct {v0, p0}, Landroid/support/v4/media/IMediaSession2$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    return-object v0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const v0, 0x5f4e5446

    const/4 v1, 0x1

    if-eq p1, v0, :cond_18

    const/4 v0, 0x0

    packed-switch p1, :pswitch_data_0

    .line 595
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result p0

    return p0

    :pswitch_0
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 586
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 588
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 590
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p2

    .line 591
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->unsubscribe(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;)V

    return v1

    :pswitch_1
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 569
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 571
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 573
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 575
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_0

    .line 576
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 581
    :cond_0
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->subscribe(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_2
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 548
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 550
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object v3

    .line 552
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 554
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 556
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 558
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p1

    if-eqz p1, :cond_1

    .line 559
    sget-object p1, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p1, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Landroid/os/Bundle;

    :cond_1
    move-object v7, v0

    move-object v2, p0

    .line 564
    invoke-virtual/range {v2 .. v7}, Landroid/support/v4/media/IMediaSession2$Stub;->getSearchResult(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;IILandroid/os/Bundle;)V

    return v1

    :pswitch_3
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 531
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 533
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 535
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 537
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_2

    .line 538
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 543
    :cond_2
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->search(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_4
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 510
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 512
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object v3

    .line 514
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 516
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 518
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 520
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p1

    if-eqz p1, :cond_3

    .line 521
    sget-object p1, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p1, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Landroid/os/Bundle;

    :cond_3
    move-object v7, v0

    move-object v2, p0

    .line 526
    invoke-virtual/range {v2 .. v7}, Landroid/support/v4/media/IMediaSession2$Stub;->getChildren(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;IILandroid/os/Bundle;)V

    return v1

    :pswitch_5
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 500
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 502
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 504
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p2

    .line 505
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->getItem(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;)V

    return v1

    :pswitch_6
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 485
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 487
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 489
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_4

    .line 490
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 495
    :cond_4
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->getLibraryRoot(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;)V

    return v1

    :pswitch_7
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 470
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 472
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 474
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_5

    .line 475
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 480
    :cond_5
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->selectRoute(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;)V

    return v1

    :pswitch_8
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 462
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 464
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 465
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->unsubscribeRoutesInfo(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_9
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 454
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 456
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 457
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->subscribeRoutesInfo(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_a
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 444
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 446
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 448
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p2

    .line 449
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->setShuffleMode(Landroid/support/v4/media/IMediaController2;I)V

    return v1

    :pswitch_b
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 434
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 436
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 438
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p2

    .line 439
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->setRepeatMode(Landroid/support/v4/media/IMediaController2;I)V

    return v1

    :pswitch_c
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 426
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 428
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 429
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->skipToNextItem(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_d
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 418
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 420
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 421
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->skipToPreviousItem(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_e
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 403
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 405
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 407
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_6

    .line 408
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 413
    :cond_6
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->skipToPlaylistItem(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;)V

    return v1

    :pswitch_f
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 386
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 388
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 390
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    .line 392
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_7

    .line 393
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 398
    :cond_7
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->replacePlaylistItem(Landroid/support/v4/media/IMediaController2;ILandroid/os/Bundle;)V

    return v1

    :pswitch_10
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 371
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 373
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 375
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_8

    .line 376
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 381
    :cond_8
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->removePlaylistItem(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;)V

    return v1

    :pswitch_11
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 354
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 356
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 358
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    .line 360
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_9

    .line 361
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 366
    :cond_9
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->addPlaylistItem(Landroid/support/v4/media/IMediaController2;ILandroid/os/Bundle;)V

    return v1

    :pswitch_12
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 339
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 341
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 343
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_a

    .line 344
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 349
    :cond_a
    invoke-virtual {p0, p1, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->updatePlaylistMetadata(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;)V

    return v1

    :pswitch_13
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 322
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 324
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 326
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, p3}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object p3

    .line 328
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_b

    .line 329
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 334
    :cond_b
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->setPlaylist(Landroid/support/v4/media/IMediaController2;Ljava/util/List;Landroid/os/Bundle;)V

    return v1

    :pswitch_14
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 312
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 314
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 316
    invoke-virtual {p2}, Landroid/os/Parcel;->readFloat()F

    move-result p2

    .line 317
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->setPlaybackSpeed(Landroid/support/v4/media/IMediaController2;F)V

    return v1

    :pswitch_15
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 295
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 297
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 299
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 301
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_c

    .line 302
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 307
    :cond_c
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->setRating(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_16
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 278
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 280
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 282
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 284
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_d

    .line 285
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 290
    :cond_d
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->playFromMediaId(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_17
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 261
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 263
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 265
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 267
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_e

    .line 268
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 273
    :cond_e
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->playFromSearch(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_18
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 239
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 241
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 243
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_f

    .line 244
    sget-object p3, Landroid/net/Uri;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Landroid/net/Uri;

    goto :goto_0

    :cond_f
    move-object p3, v0

    .line 250
    :goto_0
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_10

    .line 251
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 256
    :cond_10
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->playFromUri(Landroid/support/v4/media/IMediaController2;Landroid/net/Uri;Landroid/os/Bundle;)V

    return v1

    :pswitch_19
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 222
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 224
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 226
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 228
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_11

    .line 229
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 234
    :cond_11
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->prepareFromMediaId(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_1a
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 205
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 207
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 209
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p3

    .line 211
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_12

    .line 212
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 217
    :cond_12
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->prepareFromSearch(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;Landroid/os/Bundle;)V

    return v1

    :pswitch_1b
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 183
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 185
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 187
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_13

    .line 188
    sget-object p3, Landroid/net/Uri;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Landroid/net/Uri;

    goto :goto_1

    :cond_13
    move-object p3, v0

    .line 194
    :goto_1
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_14

    .line 195
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/Bundle;

    .line 200
    :cond_14
    invoke-virtual {p0, p1, p3, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->prepareFromUri(Landroid/support/v4/media/IMediaController2;Landroid/net/Uri;Landroid/os/Bundle;)V

    return v1

    :pswitch_1c
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 154
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 156
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 158
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    if-eqz p3, :cond_15

    .line 159
    sget-object p3, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Landroid/os/Bundle;

    goto :goto_2

    :cond_15
    move-object p3, v0

    .line 165
    :goto_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p4

    if-eqz p4, :cond_16

    .line 166
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {p4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Landroid/os/Bundle;

    goto :goto_3

    :cond_16
    move-object p4, v0

    .line 172
    :goto_3
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_17

    .line 173
    sget-object v0, Landroid/os/ResultReceiver;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object p2

    move-object v0, p2

    check-cast v0, Landroid/os/ResultReceiver;

    .line 178
    :cond_17
    invoke-virtual {p0, p1, p3, p4, v0}, Landroid/support/v4/media/IMediaSession2$Stub;->sendCustomCommand(Landroid/support/v4/media/IMediaController2;Landroid/os/Bundle;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    return v1

    :pswitch_1d
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 144
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 146
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 148
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide p2

    .line 149
    invoke-virtual {p0, p1, p2, p3}, Landroid/support/v4/media/IMediaSession2$Stub;->seekTo(Landroid/support/v4/media/IMediaController2;J)V

    return v1

    :pswitch_1e
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 136
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 138
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 139
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->rewind(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_1f
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 128
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 130
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 131
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->fastForward(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_20
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 120
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 122
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 123
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->prepare(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_21
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 112
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 114
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 115
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->reset(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_22
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 104
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 106
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 107
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->pause(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_23
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 96
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 98
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 99
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->play(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_24
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 84
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 86
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 88
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    .line 90
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p2

    .line 91
    invoke-virtual {p0, p1, p3, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->adjustVolume(Landroid/support/v4/media/IMediaController2;II)V

    return v1

    :pswitch_25
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 72
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 74
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 76
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p3

    .line 78
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result p2

    .line 79
    invoke-virtual {p0, p1, p3, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->setVolumeTo(Landroid/support/v4/media/IMediaController2;II)V

    return v1

    :pswitch_26
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 64
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 66
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 67
    invoke-virtual {p0, p1}, Landroid/support/v4/media/IMediaSession2$Stub;->release(Landroid/support/v4/media/IMediaController2;)V

    return v1

    :pswitch_27
    const-string p1, "android.support.v4.media.IMediaSession2"

    .line 54
    invoke-virtual {p2, p1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 56
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    invoke-static {p1}, Landroid/support/v4/media/IMediaController2$Stub;->asInterface(Landroid/os/IBinder;)Landroid/support/v4/media/IMediaController2;

    move-result-object p1

    .line 58
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p2

    .line 59
    invoke-virtual {p0, p1, p2}, Landroid/support/v4/media/IMediaSession2$Stub;->connect(Landroid/support/v4/media/IMediaController2;Ljava/lang/String;)V

    return v1

    :cond_18
    const-string p0, "android.support.v4.media.IMediaSession2"

    .line 49
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_27
        :pswitch_26
        :pswitch_25
        :pswitch_24
        :pswitch_23
        :pswitch_22
        :pswitch_21
        :pswitch_20
        :pswitch_1f
        :pswitch_1e
        :pswitch_1d
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
