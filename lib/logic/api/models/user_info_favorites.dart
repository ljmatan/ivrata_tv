// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

List<UserInfo> userInfoFromJson(String str) =>
    List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromJson(x)));

String userInfoToJson(List<UserInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInfo {
  UserInfo({
    this.id,
    this.user,
    this.name,
    this.email,
    this.created,
    this.modified,
    this.isAdmin,
    this.status,
    this.photoUrl,
    this.lastLogin,
    this.backgroundUrl,
    this.canStream,
    this.canUpload,
    this.canViewChart,
    this.about,
    this.channelName,
    this.emailVerified,
    this.analyticsCode,
    this.externalOptions,
    this.firstName,
    this.lastName,
    this.address,
    this.zipCode,
    this.country,
    this.region,
    this.city,
    this.donationLink,
    this.canCreateMeet,
    this.extraInfo,
    this.usersId,
    this.showOnTv,
    this.nameTranslated,
    this.videos,
    this.isFavorite,
    this.isWatchLater,
  });

  final int id;
  final String user;
  final String name;
  final String email;
  final DateTime created;
  final DateTime modified;
  final int isAdmin;
  final String status;
  final dynamic photoUrl;
  final DateTime lastLogin;
  final dynamic backgroundUrl;
  final int canStream;
  final int canUpload;
  final int canViewChart;
  final String about;
  final String channelName;
  final int emailVerified;
  final String analyticsCode;
  final String externalOptions;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic address;
  final dynamic zipCode;
  final dynamic country;
  final dynamic region;
  final dynamic city;
  final String donationLink;
  final int canCreateMeet;
  final dynamic extraInfo;
  final int usersId;
  final int showOnTv;
  final String nameTranslated;
  final List<Video> videos;
  final bool isFavorite;
  final bool isWatchLater;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : json["user"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        status: json["status"] == null ? null : json["status"],
        photoUrl: json["photoURL"],
        lastLogin: json["lastLogin"] == null
            ? null
            : DateTime.parse(json["lastLogin"]),
        backgroundUrl: json["backgroundURL"],
        canStream: json["canStream"] == null ? null : json["canStream"],
        canUpload: json["canUpload"] == null ? null : json["canUpload"],
        canViewChart:
            json["canViewChart"] == null ? null : json["canViewChart"],
        about: json["about"] == null ? null : json["about"],
        channelName: json["channelName"] == null ? null : json["channelName"],
        emailVerified:
            json["emailVerified"] == null ? null : json["emailVerified"],
        analyticsCode:
            json["analyticsCode"] == null ? null : json["analyticsCode"],
        externalOptions:
            json["externalOptions"] == null ? null : json["externalOptions"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        zipCode: json["zip_code"],
        country: json["country"],
        region: json["region"],
        city: json["city"],
        donationLink:
            json["donationLink"] == null ? null : json["donationLink"],
        canCreateMeet:
            json["canCreateMeet"] == null ? null : json["canCreateMeet"],
        extraInfo: json["extra_info"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        showOnTv: json["showOnTV"] == null ? null : json["showOnTV"],
        nameTranslated:
            json["name_translated"] == null ? null : json["name_translated"],
        videos: json["videos"] == null
            ? null
            : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
        isWatchLater:
            json["isWatchLater"] == null ? null : json["isWatchLater"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "created": created == null ? null : created.toIso8601String(),
        "modified": modified == null ? null : modified.toIso8601String(),
        "isAdmin": isAdmin == null ? null : isAdmin,
        "status": status == null ? null : status,
        "photoURL": photoUrl,
        "lastLogin": lastLogin == null ? null : lastLogin.toIso8601String(),
        "backgroundURL": backgroundUrl,
        "canStream": canStream == null ? null : canStream,
        "canUpload": canUpload == null ? null : canUpload,
        "canViewChart": canViewChart == null ? null : canViewChart,
        "about": about == null ? null : about,
        "channelName": channelName == null ? null : channelName,
        "emailVerified": emailVerified == null ? null : emailVerified,
        "analyticsCode": analyticsCode == null ? null : analyticsCode,
        "externalOptions": externalOptions == null ? null : externalOptions,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "zip_code": zipCode,
        "country": country,
        "region": region,
        "city": city,
        "donationLink": donationLink == null ? null : donationLink,
        "canCreateMeet": canCreateMeet == null ? null : canCreateMeet,
        "extra_info": extraInfo,
        "users_id": usersId == null ? null : usersId,
        "showOnTV": showOnTv == null ? null : showOnTv,
        "name_translated": nameTranslated == null ? null : nameTranslated,
        "videos": videos == null
            ? null
            : List<dynamic>.from(videos.map((x) => x.toJson())),
        "isFavorite": isFavorite == null ? null : isFavorite,
        "isWatchLater": isWatchLater == null ? null : isWatchLater,
      };
}

class Video {
  Video({
    this.playlistsId,
    this.videosId,
    this.order,
    this.id,
    this.title,
    this.cleanTitle,
    this.description,
    this.viewsCount,
    this.viewsCount25,
    this.viewsCount50,
    this.viewsCount75,
    this.viewsCount100,
    this.status,
    this.created,
    this.modified,
    this.usersId,
    this.categoriesId,
    this.filename,
    this.duration,
    this.type,
    this.videoDownloadedLink,
    this.rotation,
    this.zoom,
    this.youtubeId,
    this.videoLink,
    this.nextVideosId,
    this.isSuggested,
    this.trailer1,
    this.trailer2,
    this.trailer3,
    this.rate,
    this.canDownload,
    this.canShare,
    this.rrating,
    this.externalOptions,
    this.onlyForPaid,
    this.seriePlaylistsId,
    this.sitesId,
    this.encoderUrl,
    this.filepath,
    this.filesize,
    this.pchannel,
    this.liveTransmitionsHistoryId,
    this.user,
    this.name,
    this.email,
    this.isAdmin,
    this.photoUrl,
    this.lastLogin,
    this.backgroundUrl,
    this.canStream,
    this.canUpload,
    this.canViewChart,
    this.about,
    this.channelName,
    this.emailVerified,
    this.analyticsCode,
    this.firstName,
    this.lastName,
    this.address,
    this.zipCode,
    this.country,
    this.region,
    this.city,
    this.donationLink,
    this.canCreateMeet,
    this.extraInfo,
    this.cre,
    this.videoOrder,
    this.likes,
    this.images,
    this.videos,
    this.progress,
    this.tags,
    this.videoTags,
    this.videoTagsObject,
    this.videosUrl,
  });

  final int playlistsId;
  final int videosId;
  final int order;
  final int id;
  final String title;
  final String cleanTitle;
  final String description;
  final int viewsCount;
  final int viewsCount25;
  final int viewsCount50;
  final int viewsCount75;
  final int viewsCount100;
  final String status;
  final DateTime created;
  final DateTime modified;
  final int usersId;
  final int categoriesId;
  final String filename;
  final String duration;
  final String type;
  final String videoDownloadedLink;
  final int rotation;
  final int zoom;
  final String youtubeId;
  final String videoLink;
  final dynamic nextVideosId;
  final int isSuggested;
  final String trailer1;
  final String trailer2;
  final String trailer3;
  final int rate;
  final int canDownload;
  final int canShare;
  final String rrating;
  final String externalOptions;
  final int onlyForPaid;
  final dynamic seriePlaylistsId;
  final dynamic sitesId;
  final String encoderUrl;
  final String filepath;
  final int filesize;
  final String pchannel;
  final dynamic liveTransmitionsHistoryId;
  final String user;
  final String name;
  final String email;
  final int isAdmin;
  final String photoUrl;
  final DateTime lastLogin;
  final dynamic backgroundUrl;
  final int canStream;
  final int canUpload;
  final int canViewChart;
  final String about;
  final String channelName;
  final int emailVerified;
  final String analyticsCode;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic address;
  final dynamic zipCode;
  final dynamic country;
  final dynamic region;
  final dynamic city;
  final String donationLink;
  final dynamic canCreateMeet;
  final dynamic extraInfo;
  final DateTime cre;
  final int videoOrder;
  final int likes;
  final Images images;
  final Videos videos;
  final Progress progress;
  final List<Tag> tags;
  final List<dynamic> videoTags;
  final List<dynamic> videoTagsObject;
  final Map<String, VideosUrl> videosUrl;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        playlistsId: json["playlists_id"] == null ? null : json["playlists_id"],
        videosId: json["videos_id"] == null ? null : json["videos_id"],
        order: json["order"] == null ? null : json["order"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        cleanTitle: json["clean_title"] == null ? null : json["clean_title"],
        description: json["description"] == null ? null : json["description"],
        viewsCount: json["views_count"] == null ? null : json["views_count"],
        viewsCount25:
            json["views_count_25"] == null ? null : json["views_count_25"],
        viewsCount50:
            json["views_count_50"] == null ? null : json["views_count_50"],
        viewsCount75:
            json["views_count_75"] == null ? null : json["views_count_75"],
        viewsCount100:
            json["views_count_100"] == null ? null : json["views_count_100"],
        status: json["status"] == null ? null : json["status"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        usersId: json["users_id"] == null ? null : json["users_id"],
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        filename: json["filename"] == null ? null : json["filename"],
        duration: json["duration"] == null ? null : json["duration"],
        type: json["type"] == null ? null : json["type"],
        videoDownloadedLink: json["videoDownloadedLink"] == null
            ? null
            : json["videoDownloadedLink"],
        rotation: json["rotation"] == null ? null : json["rotation"],
        zoom: json["zoom"] == null ? null : json["zoom"],
        youtubeId: json["youtubeId"] == null ? null : json["youtubeId"],
        videoLink: json["videoLink"] == null ? null : json["videoLink"],
        nextVideosId: json["next_videos_id"],
        isSuggested: json["isSuggested"] == null ? null : json["isSuggested"],
        trailer1: json["trailer1"] == null ? null : json["trailer1"],
        trailer2: json["trailer2"] == null ? null : json["trailer2"],
        trailer3: json["trailer3"] == null ? null : json["trailer3"],
        rate: json["rate"] == null ? null : json["rate"],
        canDownload: json["can_download"] == null ? null : json["can_download"],
        canShare: json["can_share"] == null ? null : json["can_share"],
        rrating: json["rrating"] == null ? null : json["rrating"],
        externalOptions:
            json["externalOptions"] == null ? null : json["externalOptions"],
        onlyForPaid:
            json["only_for_paid"] == null ? null : json["only_for_paid"],
        seriePlaylistsId: json["serie_playlists_id"],
        sitesId: json["sites_id"],
        encoderUrl: json["encoderURL"] == null ? null : json["encoderURL"],
        filepath: json["filepath"] == null ? null : json["filepath"],
        filesize: json["filesize"] == null ? null : json["filesize"],
        pchannel: json["pchannel"] == null ? null : json["pchannel"],
        liveTransmitionsHistoryId: json["live_transmitions_history_id"],
        user: json["user"] == null ? null : json["user"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        lastLogin: json["lastLogin"] == null
            ? null
            : DateTime.parse(json["lastLogin"]),
        backgroundUrl: json["backgroundURL"],
        canStream: json["canStream"] == null ? null : json["canStream"],
        canUpload: json["canUpload"] == null ? null : json["canUpload"],
        canViewChart:
            json["canViewChart"] == null ? null : json["canViewChart"],
        about: json["about"] == null ? null : json["about"],
        channelName: json["channelName"] == null ? null : json["channelName"],
        emailVerified:
            json["emailVerified"] == null ? null : json["emailVerified"],
        analyticsCode:
            json["analyticsCode"] == null ? null : json["analyticsCode"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        zipCode: json["zip_code"],
        country: json["country"],
        region: json["region"],
        city: json["city"],
        donationLink:
            json["donationLink"] == null ? null : json["donationLink"],
        canCreateMeet: json["canCreateMeet"],
        extraInfo: json["extra_info"],
        cre: json["cre"] == null ? null : DateTime.parse(json["cre"]),
        videoOrder: json["video_order"] == null ? null : json["video_order"],
        likes: json["likes"] == null ? null : json["likes"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
        progress: json["progress"] == null
            ? null
            : Progress.fromJson(json["progress"]),
        tags: json["tags"] == null
            ? null
            : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        videoTags: json["videoTags"] == null
            ? null
            : List<dynamic>.from(json["videoTags"].map((x) => x)),
        videoTagsObject: json["videoTagsObject"] == null
            ? null
            : List<dynamic>.from(json["videoTagsObject"].map((x) => x)),
        videosUrl: json["videosURL"] == null
            ? null
            : Map.from(json["videosURL"]).map((k, v) =>
                MapEntry<String, VideosUrl>(k, VideosUrl.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "playlists_id": playlistsId == null ? null : playlistsId,
        "videos_id": videosId == null ? null : videosId,
        "order": order == null ? null : order,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "clean_title": cleanTitle == null ? null : cleanTitle,
        "description": description == null ? null : description,
        "views_count": viewsCount == null ? null : viewsCount,
        "views_count_25": viewsCount25 == null ? null : viewsCount25,
        "views_count_50": viewsCount50 == null ? null : viewsCount50,
        "views_count_75": viewsCount75 == null ? null : viewsCount75,
        "views_count_100": viewsCount100 == null ? null : viewsCount100,
        "status": status == null ? null : status,
        "created": created == null ? null : created.toIso8601String(),
        "modified": modified == null ? null : modified.toIso8601String(),
        "users_id": usersId == null ? null : usersId,
        "categories_id": categoriesId == null ? null : categoriesId,
        "filename": filename == null ? null : filename,
        "duration": duration == null ? null : duration,
        "type": type == null ? null : type,
        "videoDownloadedLink":
            videoDownloadedLink == null ? null : videoDownloadedLink,
        "rotation": rotation == null ? null : rotation,
        "zoom": zoom == null ? null : zoom,
        "youtubeId": youtubeId == null ? null : youtubeId,
        "videoLink": videoLink == null ? null : videoLink,
        "next_videos_id": nextVideosId,
        "isSuggested": isSuggested == null ? null : isSuggested,
        "trailer1": trailer1 == null ? null : trailer1,
        "trailer2": trailer2 == null ? null : trailer2,
        "trailer3": trailer3 == null ? null : trailer3,
        "rate": rate == null ? null : rate,
        "can_download": canDownload == null ? null : canDownload,
        "can_share": canShare == null ? null : canShare,
        "rrating": rrating == null ? null : rrating,
        "externalOptions": externalOptions == null ? null : externalOptions,
        "only_for_paid": onlyForPaid == null ? null : onlyForPaid,
        "serie_playlists_id": seriePlaylistsId,
        "sites_id": sitesId,
        "encoderURL": encoderUrl == null ? null : encoderUrl,
        "filepath": filepath == null ? null : filepath,
        "filesize": filesize == null ? null : filesize,
        "pchannel": pchannel == null ? null : pchannel,
        "live_transmitions_history_id": liveTransmitionsHistoryId,
        "user": user == null ? null : user,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "photoURL": photoUrl == null ? null : photoUrl,
        "lastLogin": lastLogin == null ? null : lastLogin.toIso8601String(),
        "backgroundURL": backgroundUrl,
        "canStream": canStream == null ? null : canStream,
        "canUpload": canUpload == null ? null : canUpload,
        "canViewChart": canViewChart == null ? null : canViewChart,
        "about": about == null ? null : about,
        "channelName": channelName == null ? null : channelName,
        "emailVerified": emailVerified == null ? null : emailVerified,
        "analyticsCode": analyticsCode == null ? null : analyticsCode,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "zip_code": zipCode,
        "country": country,
        "region": region,
        "city": city,
        "donationLink": donationLink == null ? null : donationLink,
        "canCreateMeet": canCreateMeet,
        "extra_info": extraInfo,
        "cre": cre == null ? null : cre.toIso8601String(),
        "video_order": videoOrder == null ? null : videoOrder,
        "likes": likes == null ? null : likes,
        "images": images == null ? null : images.toJson(),
        "videos": videos == null ? null : videos.toJson(),
        "progress": progress == null ? null : progress.toJson(),
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags.map((x) => x.toJson())),
        "videoTags": videoTags == null
            ? null
            : List<dynamic>.from(videoTags.map((x) => x)),
        "videoTagsObject": videoTagsObject == null
            ? null
            : List<dynamic>.from(videoTagsObject.map((x) => x)),
        "videosURL": videosUrl == null
            ? null
            : Map.from(videosUrl)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Images {
  Images({
    this.poster,
    this.posterPortrait,
    this.posterPortraitPath,
    this.posterPortraitThumbs,
    this.posterPortraitThumbsSmall,
    this.thumbsGif,
    this.gifPortrait,
    this.thumbsJpg,
    this.thumbsJpgSmall,
    this.spectrumSource,
    this.posterLandscape,
    this.posterLandscapePath,
    this.posterLandscapeThumbs,
    this.posterLandscapeThumbsSmall,
  });

  final String poster;
  final String posterPortrait;
  final String posterPortraitPath;
  final String posterPortraitThumbs;
  final String posterPortraitThumbsSmall;
  final bool thumbsGif;
  final bool gifPortrait;
  final String thumbsJpg;
  final String thumbsJpgSmall;
  final bool spectrumSource;
  final String posterLandscape;
  final String posterLandscapePath;
  final String posterLandscapeThumbs;
  final String posterLandscapeThumbsSmall;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        poster: json["poster"] == null ? null : json["poster"],
        posterPortrait:
            json["posterPortrait"] == null ? null : json["posterPortrait"],
        posterPortraitPath: json["posterPortraitPath"] == null
            ? null
            : json["posterPortraitPath"],
        posterPortraitThumbs: json["posterPortraitThumbs"] == null
            ? null
            : json["posterPortraitThumbs"],
        posterPortraitThumbsSmall: json["posterPortraitThumbsSmall"] == null
            ? null
            : json["posterPortraitThumbsSmall"],
        thumbsGif: json["thumbsGif"] == null ? null : json["thumbsGif"],
        gifPortrait: json["gifPortrait"] == null ? null : json["gifPortrait"],
        thumbsJpg: json["thumbsJpg"] == null ? null : json["thumbsJpg"],
        thumbsJpgSmall:
            json["thumbsJpgSmall"] == null ? null : json["thumbsJpgSmall"],
        spectrumSource:
            json["spectrumSource"] == null ? null : json["spectrumSource"],
        posterLandscape:
            json["posterLandscape"] == null ? null : json["posterLandscape"],
        posterLandscapePath: json["posterLandscapePath"] == null
            ? null
            : json["posterLandscapePath"],
        posterLandscapeThumbs: json["posterLandscapeThumbs"] == null
            ? null
            : json["posterLandscapeThumbs"],
        posterLandscapeThumbsSmall: json["posterLandscapeThumbsSmall"] == null
            ? null
            : json["posterLandscapeThumbsSmall"],
      );

  Map<String, dynamic> toJson() => {
        "poster": poster == null ? null : poster,
        "posterPortrait": posterPortrait == null ? null : posterPortrait,
        "posterPortraitPath":
            posterPortraitPath == null ? null : posterPortraitPath,
        "posterPortraitThumbs":
            posterPortraitThumbs == null ? null : posterPortraitThumbs,
        "posterPortraitThumbsSmall": posterPortraitThumbsSmall == null
            ? null
            : posterPortraitThumbsSmall,
        "thumbsGif": thumbsGif == null ? null : thumbsGif,
        "gifPortrait": gifPortrait == null ? null : gifPortrait,
        "thumbsJpg": thumbsJpg == null ? null : thumbsJpg,
        "thumbsJpgSmall": thumbsJpgSmall == null ? null : thumbsJpgSmall,
        "spectrumSource": spectrumSource == null ? null : spectrumSource,
        "posterLandscape": posterLandscape == null ? null : posterLandscape,
        "posterLandscapePath":
            posterLandscapePath == null ? null : posterLandscapePath,
        "posterLandscapeThumbs":
            posterLandscapeThumbs == null ? null : posterLandscapeThumbs,
        "posterLandscapeThumbsSmall": posterLandscapeThumbsSmall == null
            ? null
            : posterLandscapeThumbsSmall,
      };
}

class Progress {
  Progress({
    this.percent,
    this.lastVideoTime,
  });

  final int percent;
  final int lastVideoTime;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        percent: json["percent"] == null ? null : json["percent"],
        lastVideoTime:
            json["lastVideoTime"] == null ? null : json["lastVideoTime"],
      );

  Map<String, dynamic> toJson() => {
        "percent": percent == null ? null : percent,
        "lastVideoTime": lastVideoTime == null ? null : lastVideoTime,
      };
}

class Tag {
  Tag({
    this.label,
    this.type,
    this.text,
    this.tooltip,
  });

  final String label;
  final String type;
  final String text;
  final String tooltip;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        label: json["label"] == null ? null : json["label"],
        type: json["type"] == null ? null : json["type"],
        text: json["text"] == null ? null : json["text"],
        tooltip: json["tooltip"] == null ? null : json["tooltip"],
      );

  Map<String, dynamic> toJson() => {
        "label": label == null ? null : label,
        "type": type == null ? null : type,
        "text": text == null ? null : text,
        "tooltip": tooltip == null ? null : tooltip,
      };
}

class Videos {
  Videos({
    this.mp4,
  });

  final Mp4 mp4;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        mp4: json["mp4"] == null ? null : Mp4.fromJson(json["mp4"]),
      );

  Map<String, dynamic> toJson() => {
        "mp4": mp4 == null ? null : mp4.toJson(),
      };
}

class Mp4 {
  Mp4({
    this.low,
    this.sd,
    this.hd,
  });

  final String low;
  final String sd;
  final String hd;

  factory Mp4.fromJson(Map<String, dynamic> json) => Mp4(
        low: json["Low"] == null ? null : json["Low"],
        sd: json["SD"] == null ? null : json["SD"],
        hd: json["HD"] == null ? null : json["HD"],
      );

  Map<String, dynamic> toJson() => {
        "Low": low == null ? null : low,
        "SD": sd == null ? null : sd,
        "HD": hd == null ? null : hd,
      };
}

class VideosUrl {
  VideosUrl({
    this.filename,
    this.path,
    this.url,
    this.type,
    this.format,
  });

  final String filename;
  final String path;
  final String url;
  final String type;
  final String format;

  factory VideosUrl.fromJson(Map<String, dynamic> json) => VideosUrl(
        filename: json["filename"] == null ? null : json["filename"],
        path: json["path"] == null ? null : json["path"],
        url: json["url"] == null ? null : json["url"],
        type: json["type"] == null ? null : json["type"],
        format: json["format"] == null ? null : json["format"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename == null ? null : filename,
        "path": path == null ? null : path,
        "url": url == null ? null : url,
        "type": type == null ? null : type,
        "format": format == null ? null : format,
      };
}
