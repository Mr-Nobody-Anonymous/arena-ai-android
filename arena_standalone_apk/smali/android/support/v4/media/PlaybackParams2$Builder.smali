.class public final Landroid/support/v4/media/PlaybackParams2$Builder;
.super Ljava/lang/Object;
.source "PlaybackParams2.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/media/PlaybackParams2;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private mAudioFallbackMode:Ljava/lang/Integer;

.field private mPitch:Ljava/lang/Float;

.field private mPlaybackParams:Landroid/media/PlaybackParams;

.field private mSpeed:Ljava/lang/Float;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 170
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 171
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    .line 172
    new-instance v0, Landroid/media/PlaybackParams;

    invoke-direct {v0}, Landroid/media/PlaybackParams;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    :cond_0
    return-void
.end method

.method public constructor <init>(Landroid/media/PlaybackParams;)V
    .locals 0
    .annotation build Landroid/support/annotation/RequiresApi;
        value = 0x17
    .end annotation

    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    .line 179
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 180
    iput-object p1, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    return-void
.end method


# virtual methods
.method public build()Landroid/support/v4/media/PlaybackParams2;
    .locals 4

    .line 234
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x17

    if-lt v0, v2, :cond_0

    .line 235
    new-instance v0, Landroid/support/v4/media/PlaybackParams2;

    iget-object p0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    invoke-direct {v0, p0, v1}, Landroid/support/v4/media/PlaybackParams2;-><init>(Landroid/media/PlaybackParams;Landroid/support/v4/media/PlaybackParams2$1;)V

    return-object v0

    .line 237
    :cond_0
    new-instance v0, Landroid/support/v4/media/PlaybackParams2;

    iget-object v2, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mAudioFallbackMode:Ljava/lang/Integer;

    iget-object v3, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPitch:Ljava/lang/Float;

    iget-object p0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mSpeed:Ljava/lang/Float;

    invoke-direct {v0, v2, v3, p0, v1}, Landroid/support/v4/media/PlaybackParams2;-><init>(Ljava/lang/Integer;Ljava/lang/Float;Ljava/lang/Float;Landroid/support/v4/media/PlaybackParams2$1;)V

    return-object v0
.end method

.method public setAudioFallbackMode(I)Landroid/support/v4/media/PlaybackParams2$Builder;
    .locals 2

    .line 189
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    .line 190
    iget-object v0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    invoke-virtual {v0, p1}, Landroid/media/PlaybackParams;->setAudioFallbackMode(I)Landroid/media/PlaybackParams;

    goto :goto_0

    .line 192
    :cond_0
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    iput-object p1, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mAudioFallbackMode:Ljava/lang/Integer;

    :goto_0
    return-object p0
.end method

.method public setPitch(F)Landroid/support/v4/media/PlaybackParams2$Builder;
    .locals 2

    const/4 v0, 0x0

    cmpg-float v0, p1, v0

    if-gez v0, :cond_0

    .line 205
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "pitch must not be negative"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 207
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_1

    .line 208
    iget-object v0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    invoke-virtual {v0, p1}, Landroid/media/PlaybackParams;->setPitch(F)Landroid/media/PlaybackParams;

    goto :goto_0

    .line 210
    :cond_1
    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    iput-object p1, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPitch:Ljava/lang/Float;

    :goto_0
    return-object p0
.end method

.method public setSpeed(F)Landroid/support/v4/media/PlaybackParams2$Builder;
    .locals 2

    .line 221
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    .line 222
    iget-object v0, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mPlaybackParams:Landroid/media/PlaybackParams;

    invoke-virtual {v0, p1}, Landroid/media/PlaybackParams;->setSpeed(F)Landroid/media/PlaybackParams;

    goto :goto_0

    .line 224
    :cond_0
    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    iput-object p1, p0, Landroid/support/v4/media/PlaybackParams2$Builder;->mSpeed:Ljava/lang/Float;

    :goto_0
    return-object p0
.end method
