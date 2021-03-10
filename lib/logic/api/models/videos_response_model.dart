// To parse this JSON data, do
//
//     final VideosResponse = VideosResponseFromJson(jsonString);

import 'dart:convert';

VideosResponse videosResponseFromJson(String str) =>
    VideosResponse.fromJson(json.decode(str));

class VideosResponse {
  VideosResponse({
    this.error,
    this.message,
    this.response,
  });

  final bool error;
  final String message;
  final VideosResponseData response;

  factory VideosResponse.fromJson(Map<String, dynamic> json) => VideosResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        response: json["response"] == null
            ? null
            : VideosResponseData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "response": response == null ? null : response.toJson(),
      };
}

class VideosResponseData {
  VideosResponseData({
    this.rowCount,
    this.totalRows,
    this.rows,
  });

  final int rowCount;
  final int totalRows;
  final List<VideoData> rows;

  factory VideosResponseData.fromJson(Map<String, dynamic> json) =>
      VideosResponseData(
        rowCount: json["rowCount"] == null ? null : json["rowCount"],
        totalRows: json["totalRows"] == null ? null : json["totalRows"],
        rows: json["rows"] == null
            ? null
            : List<VideoData>.from(
                json["rows"].map((x) => VideoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rowCount": rowCount == null ? null : rowCount,
        "totalRows": totalRows == null ? null : totalRows,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class VideoData {
  VideoData({
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
    this.title,
    this.cleanTitle,
    this.description,
    this.viewsCount,
    this.viewsCount25,
    this.viewsCount50,
    this.viewsCount75,
    this.viewsCount100,
    this.usersId,
    this.categoriesId,
    this.filename,
    this.duration,
    this.type,
    this.videoDownloadedLink,
    this.order,
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
    this.onlyForPaid,
    this.seriePlaylistsId,
    this.sitesId,
    this.encoderUrl,
    this.filepath,
    this.filesize,
    this.pchannel,
    this.iconClass,
    this.category,
    this.cleanCategory,
    this.categoryDescription,
    this.videoCreation,
    this.videoModified,
    this.likes,
    this.dislikes,
    this.groups,
    this.tags,
    this.descriptionHtml,
    this.progress,
    this.isFavorite,
    this.isWatchLater,
    this.favoriteId,
    this.watchLaterId,
    this.videoTags,
    this.videoTagsObject,
    this.images,
    this.videos,
    this.poster,
    this.thumbnail,
    this.imageClass,
    this.createdHumanTiming,
    this.pageUrl,
    this.embedUrl,
    this.userPhoto,
    this.isSubscribed,
    this.comments,
    this.commentsTotal,
    this.subscribers,
    this.wwbnUrl,
    this.wwbnEmbedUrl,
    this.wwbnImgThumbnail,
    this.wwbnImgPoster,
    this.wwbnTitle,
    this.wwbnDescription,
    this.wwbnChannelUrl,
    this.wwbnImgChannel,
    this.wwbnType,
  });

  final int id;
  final String user;
  final String name;
  final String email;
  final DateTime created;
  final DateTime modified;
  final int isAdmin;
  final String status;
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
  final String externalOptions;
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
  final String title;
  final String cleanTitle;
  final String description;
  final int viewsCount;
  final int viewsCount25;
  final int viewsCount50;
  final int viewsCount75;
  final int viewsCount100;
  final int usersId;
  final int categoriesId;
  final String filename;
  final String duration;
  final String type;
  final String videoDownloadedLink;
  final int order;
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
  final int onlyForPaid;
  final dynamic seriePlaylistsId;
  final dynamic sitesId;
  final String encoderUrl;
  final String filepath;
  final int filesize;
  final String pchannel;
  final IconClass iconClass;
  final String category;
  final String cleanCategory;
  final String categoryDescription;
  final DateTime videoCreation;
  final DateTime videoModified;
  final int likes;
  final int dislikes;
  final List<dynamic> groups;
  final List<Tag> tags;
  final String descriptionHtml;
  final Progress progress;
  final bool isFavorite;
  final bool isWatchLater;
  final bool favoriteId;
  final bool watchLaterId;
  final List<dynamic> videoTags;
  final VideoTagsObject videoTagsObject;
  final Images images;
  final Videos videos;
  final String poster;
  final String thumbnail;
  final ImageClass imageClass;
  final String createdHumanTiming;
  final String pageUrl;
  final String embedUrl;
  final String userPhoto;
  final bool isSubscribed;
  final List<dynamic> comments;
  final int commentsTotal;
  final int subscribers;
  final String wwbnUrl;
  final String wwbnEmbedUrl;
  final String wwbnImgThumbnail;
  final String wwbnImgPoster;
  final String wwbnTitle;
  final String wwbnDescription;
  final String wwbnChannelUrl;
  final String wwbnImgChannel;
  final String wwbnType;

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : json['user'],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        status: json["status"] == null ? null : json["status"],
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
        canCreateMeet: json["canCreateMeet"],
        extraInfo: json["extra_info"],
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
        usersId: json["users_id"] == null ? null : json["users_id"],
        categoriesId:
            json["categories_id"] == null ? null : json["categories_id"],
        filename: json["filename"] == null ? null : json["filename"],
        duration: json["duration"] == null ? null : json["duration"],
        type: json["type"] == null ? null : json["type"],
        videoDownloadedLink: json["videoDownloadedLink"] == null
            ? null
            : json["videoDownloadedLink"],
        order: json["order"] == null ? null : json["order"],
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
        onlyForPaid:
            json["only_for_paid"] == null ? null : json["only_for_paid"],
        seriePlaylistsId: json["serie_playlists_id"],
        sitesId: json["sites_id"],
        encoderUrl: json["encoderURL"] == null ? null : json["encoderURL"],
        filepath: json["filepath"] == null ? null : json["filepath"],
        filesize: json["filesize"] == null ? null : json["filesize"],
        pchannel: json["pchannel"] == null ? null : json["pchannel"],
        iconClass: json["iconClass"] == null
            ? null
            : iconClassValues.map[json["iconClass"]],
        category: json["category"] == null ? null : json["category"],
        cleanCategory:
            json["clean_category"] == null ? null : json["clean_category"],
        categoryDescription: json["category_description"] == null
            ? null
            : json["category_description"],
        videoCreation: json["videoCreation"] == null
            ? null
            : DateTime.parse(json["videoCreation"]),
        videoModified: json["videoModified"] == null
            ? null
            : DateTime.parse(json["videoModified"]),
        likes: json["likes"] == null ? null : json["likes"],
        dislikes: json["dislikes"] == null ? null : json["dislikes"],
        groups: json["groups"] == null
            ? null
            : List<dynamic>.from(json["groups"].map((x) => x)),
        tags: json["tags"] == null
            ? null
            : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        descriptionHtml:
            json["descriptionHTML"] == null ? null : json["descriptionHTML"],
        progress: json["progress"] == null
            ? null
            : Progress.fromJson(json["progress"]),
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
        isWatchLater:
            json["isWatchLater"] == null ? null : json["isWatchLater"],
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        watchLaterId:
            json["watchLaterId"] == null ? null : json["watchLaterId"],
        videoTags: json["videoTags"] == null
            ? null
            : List<dynamic>.from(json["videoTags"].map((x) => x)),
        videoTagsObject: json["videoTagsObject"] == null
            ? null
            : VideoTagsObject.fromJson(json["videoTagsObject"]),
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
        poster: json["Poster"] == null ? null : json["Poster"],
        thumbnail: json["Thumbnail"] == null ? null : json["Thumbnail"],
        imageClass: json["imageClass"] == null
            ? null
            : imageClassValues.map[json["imageClass"]],
        createdHumanTiming: json["createdHumanTiming"] == null
            ? null
            : json["createdHumanTiming"],
        pageUrl: json["pageUrl"] == null ? null : json["pageUrl"],
        embedUrl: json["embedUrl"] == null ? null : json["embedUrl"],
        userPhoto: json["UserPhoto"] == null ? null : json["UserPhoto"],
        isSubscribed:
            json["isSubscribed"] == null ? null : json["isSubscribed"],
        comments: json["comments"] == null
            ? null
            : List<dynamic>.from(json["comments"].map((x) => x)),
        commentsTotal:
            json["commentsTotal"] == null ? null : json["commentsTotal"],
        subscribers: json["subscribers"] == null ? null : json["subscribers"],
        wwbnUrl: json["wwbnURL"] == null ? null : json["wwbnURL"],
        wwbnEmbedUrl:
            json["wwbnEmbedURL"] == null ? null : json["wwbnEmbedURL"],
        wwbnImgThumbnail:
            json["wwbnImgThumbnail"] == null ? null : json["wwbnImgThumbnail"],
        wwbnImgPoster:
            json["wwbnImgPoster"] == null ? null : json["wwbnImgPoster"],
        wwbnTitle: json["wwbnTitle"] == null ? null : json["wwbnTitle"],
        wwbnDescription:
            json["wwbnDescription"] == null ? null : json["wwbnDescription"],
        wwbnChannelUrl:
            json["wwbnChannelURL"] == null ? null : json["wwbnChannelURL"],
        wwbnImgChannel:
            json["wwbnImgChannel"] == null ? null : json["wwbnImgChannel"],
        wwbnType: json["wwbnType"] == null ? null : json["wwbnType"],
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
        "externalOptions": externalOptions == null ? null : externalOptions,
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
        "title": title == null ? null : title,
        "clean_title": cleanTitle == null ? null : cleanTitle,
        "description": description == null ? null : description,
        "views_count": viewsCount == null ? null : viewsCount,
        "views_count_25": viewsCount25 == null ? null : viewsCount25,
        "views_count_50": viewsCount50 == null ? null : viewsCount50,
        "views_count_75": viewsCount75 == null ? null : viewsCount75,
        "views_count_100": viewsCount100 == null ? null : viewsCount100,
        "users_id": usersId == null ? null : usersId,
        "categories_id": categoriesId == null ? null : categoriesId,
        "filename": filename == null ? null : filename,
        "duration": duration == null ? null : duration,
        "type": type == null ? null : type,
        "videoDownloadedLink":
            videoDownloadedLink == null ? null : videoDownloadedLink,
        "order": order == null ? null : order,
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
        "only_for_paid": onlyForPaid == null ? null : onlyForPaid,
        "serie_playlists_id": seriePlaylistsId,
        "sites_id": sitesId,
        "encoderURL": encoderUrl == null ? null : encoderUrl,
        "filepath": filepath == null ? null : filepath,
        "filesize": filesize == null ? null : filesize,
        "pchannel": pchannel == null ? null : pchannel,
        "iconClass":
            iconClass == null ? null : iconClassValues.reverse[iconClass],
        "category": category == null ? null : category,
        "clean_category": cleanCategory == null ? null : cleanCategory,
        "category_description":
            categoryDescription == null ? null : categoryDescription,
        "videoCreation":
            videoCreation == null ? null : videoCreation.toIso8601String(),
        "videoModified":
            videoModified == null ? null : videoModified.toIso8601String(),
        "likes": likes == null ? null : likes,
        "dislikes": dislikes == null ? null : dislikes,
        "groups":
            groups == null ? null : List<dynamic>.from(groups.map((x) => x)),
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags.map((x) => x.toJson())),
        "descriptionHTML": descriptionHtml == null ? null : description,
        "progress": progress == null ? null : progress.toJson(),
        "isFavorite": isFavorite == null ? null : isFavorite,
        "isWatchLater": isWatchLater == null ? null : isWatchLater,
        "favoriteId": favoriteId == null ? null : favoriteId,
        "watchLaterId": watchLaterId == null ? null : watchLaterId,
        "videoTags": videoTags == null
            ? null
            : List<dynamic>.from(videoTags.map((x) => x)),
        "videoTagsObject":
            videoTagsObject == null ? null : videoTagsObject.toJson(),
        "images": images == null ? null : images.toJson(),
        "videos": videos == null ? null : videos.toJson(),
        "Poster": poster == null ? null : poster,
        "Thumbnail": thumbnail == null ? null : thumbnail,
        "imageClass":
            imageClass == null ? null : imageClassValues.reverse[imageClass],
        "createdHumanTiming":
            createdHumanTiming == null ? null : createdHumanTiming,
        "pageUrl": pageUrl == null ? null : pageUrl,
        "embedUrl": embedUrl == null ? null : embedUrl,
        "UserPhoto": userPhoto == null ? null : userPhoto,
        "isSubscribed": isSubscribed == null ? null : isSubscribed,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x)),
        "commentsTotal": commentsTotal == null ? null : commentsTotal,
        "subscribers": subscribers == null ? null : subscribers,
        "wwbnURL": wwbnUrl == null ? null : wwbnUrl,
        "wwbnEmbedURL": wwbnEmbedUrl == null ? null : wwbnEmbedUrl,
        "wwbnImgThumbnail": wwbnImgThumbnail == null ? null : wwbnImgThumbnail,
        "wwbnImgPoster": wwbnImgPoster == null ? null : wwbnImgPoster,
        "wwbnTitle": wwbnTitle == null ? null : wwbnTitle,
        "wwbnDescription": wwbnDescription == null ? null : wwbnDescription,
        "wwbnChannelURL": wwbnChannelUrl == null ? null : wwbnChannelUrl,
        "wwbnImgChannel": wwbnImgChannel == null ? null : wwbnImgChannel,
        "wwbnType": wwbnType == null ? null : wwbnType,
      };
}

enum IconClass { FA_FA_FW_ICONPICKER_COMPONENT }

final iconClassValues = EnumValues(
    {"fa fa-fw iconpicker-component": IconClass.FA_FA_FW_ICONPICKER_COMPONENT});

enum ImageClass { LANDSCAPE }

final imageClassValues = EnumValues({"landscape": ImageClass.LANDSCAPE});

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
    this.posterLandscape,
    this.posterLandscapePath,
    this.posterLandscapeThumbs,
    this.posterLandscapeThumbsSmall,
  });

  final String poster;
  final String posterPortrait;
  final PosterPortraitPath posterPortraitPath;
  final String posterPortraitThumbs;
  final String posterPortraitThumbsSmall;
  final bool thumbsGif;
  final bool gifPortrait;
  final String thumbsJpg;
  final String thumbsJpgSmall;
  final String posterLandscape;
  final String posterLandscapePath;
  final dynamic posterLandscapeThumbs;
  final dynamic posterLandscapeThumbsSmall;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        poster: json["poster"] == null ? null : json["poster"],
        posterPortrait:
            json["posterPortrait"] == null ? null : json["posterPortrait"],
        posterPortraitPath: json["posterPortraitPath"] == null
            ? null
            : posterPortraitPathValues.map[json["posterPortraitPath"]],
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
        posterLandscape:
            json["posterLandscape"] == null ? null : json["posterLandscape"],
        posterLandscapePath: json["posterLandscapePath"] == null
            ? null
            : json["posterLandscapePath"],
        posterLandscapeThumbs: json["posterLandscapeThumbs"],
        posterLandscapeThumbsSmall: json["posterLandscapeThumbsSmall"],
      );

  Map<String, dynamic> toJson() => {
        "poster": poster == null ? null : poster,
        "posterPortrait": posterPortrait == null ? null : posterPortrait,
        "posterPortraitPath": posterPortraitPath == null
            ? null
            : posterPortraitPathValues.reverse[posterPortraitPath],
        "posterPortraitThumbs":
            posterPortraitThumbs == null ? null : posterPortraitThumbs,
        "posterPortraitThumbsSmall": posterPortraitThumbsSmall == null
            ? null
            : posterPortraitThumbsSmall,
        "thumbsGif": thumbsGif == null ? null : thumbsGif,
        "gifPortrait": gifPortrait == null ? null : gifPortrait,
        "thumbsJpg": thumbsJpg == null ? null : thumbsJpg,
        "thumbsJpgSmall": thumbsJpgSmall == null ? null : thumbsJpgSmall,
        "posterLandscape": posterLandscape == null ? null : posterLandscape,
        "posterLandscapePath":
            posterLandscapePath == null ? null : posterLandscapePath,
        "posterLandscapeThumbs": posterLandscapeThumbs,
        "posterLandscapeThumbsSmall": posterLandscapeThumbsSmall,
      };
}

enum PosterPortraitPath { VAR_WWW_PORTAL_VIEW_IMG_NOTFOUND_PORTRAIT_PNG }

final posterPortraitPathValues = EnumValues({
  "/var/www/portal/view/img/notfound_portrait.png":
      PosterPortraitPath.VAR_WWW_PORTAL_VIEW_IMG_NOTFOUND_PORTRAIT_PNG
});

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
  Tag({this.label, this.type, this.category});

  final Label label;
  final TagType type;
  final String category;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        label: json["label"] == null ? null : labelValues.map[json["label"]],
        type: json["type"] == null ? null : tagTypeValues.map[json["type"]],
        category: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "label": label == null ? null : labelValues.reverse[label],
        "type": type == null ? null : tagTypeValues.reverse[type],
        "text": category == null ? null : category,
      };
}

enum Label { PAID_CONTENT, STATUS, CATEGORY, SOURCE, EMPTY }

final labelValues = EnumValues({
  "Category": Label.CATEGORY,
  "": Label.EMPTY,
  "Paid Content": Label.PAID_CONTENT,
  "Source": Label.SOURCE,
  "Status": Label.STATUS
});

enum TagType { SUCCESS, DEFAULT, INFO, EMPTY, DANGER }

final tagTypeValues = EnumValues({
  "danger": TagType.DANGER,
  "default": TagType.DEFAULT,
  "": TagType.EMPTY,
  "info": TagType.INFO,
  "success": TagType.SUCCESS
});

class VideoTagsObject {
  VideoTagsObject();

  factory VideoTagsObject.fromJson(Map<String, dynamic> json) =>
      VideoTagsObject();

  Map<String, dynamic> toJson() => {};
}

class Videos {
  Videos({this.mp4});

  final Mp4 mp4;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        mp4: json["mp4"] == null ? null : Mp4.fromJson(json["mp4"]),
      );

  Map<String, dynamic> toJson() => {
        "mp4": mp4 == null ? null : mp4.toJson(),
      };
}

class Mp4 {
  Mp4({this.low, this.sd, this.hd});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
