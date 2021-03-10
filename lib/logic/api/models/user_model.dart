// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.isCaptchaNeed,
    this.siteLogo,
    this.id,
    this.user,
    this.donationLink,
    this.name,
    this.nameIdentification,
    this.pass,
    this.email,
    this.channelName,
    this.photo,
    this.backgroundUrl,
    this.isLogged,
    this.isAdmin,
    this.canUpload,
    this.canComment,
    this.canStream,
    this.redirectUri,
    this.categories,
    this.userGroups,
    this.streamServerUrl,
    this.streamKey,
    this.streamer,
    this.plugin,
    this.encoder,
    this.subscription,
  });

  final bool isCaptchaNeed;
  final String siteLogo;
  int id;
  final String user;
  final String donationLink;
  final String name;
  final String nameIdentification;
  final String pass;
  final String email;
  final String channelName;
  final String photo;
  final String backgroundUrl;
  final dynamic isLogged;
  final dynamic isAdmin;
  final dynamic canUpload;
  final dynamic canComment;
  final dynamic canStream;
  final String redirectUri;
  final List<Category> categories;
  final List<dynamic> userGroups;
  final String streamServerUrl;
  final String streamKey;
  final Streamer streamer;
  final Plugin plugin;
  final String encoder;
  final List<dynamic> subscription;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        isCaptchaNeed:
            json["isCaptchaNeed"] == null ? null : json["isCaptchaNeed"],
        siteLogo: json["siteLogo"] == null ? null : json["siteLogo"],
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : json["user"],
        donationLink:
            json["donationLink"] == null ? null : json["donationLink"],
        name: json["name"] == null ? null : json["name"],
        nameIdentification: json["nameIdentification"] == null
            ? null
            : json["nameIdentification"],
        pass: json["pass"] == null ? null : json["pass"],
        email: json["email"] == null ? null : json["email"],
        channelName: json["channelName"] == null ? null : json["channelName"],
        photo: json["photo"] == null ? null : json["photo"],
        backgroundUrl:
            json["backgroundURL"] == null ? null : json["backgroundURL"],
        isLogged: json["isLogged"] == null ? null : json["isLogged"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        canUpload: json["canUpload"] == null ? null : json["canUpload"],
        canComment: json["canComment"] == null ? null : json["canComment"],
        canStream: json["canStream"] == null ? null : json["canStream"],
        redirectUri: json["redirectUri"] == null ? null : json["redirectUri"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        userGroups: json["userGroups"] == null
            ? null
            : List<dynamic>.from(json["userGroups"].map((x) => x)),
        streamServerUrl:
            json["streamServerURL"] == null ? null : json["streamServerURL"],
        streamKey: json["streamKey"] == null ? null : json["streamKey"],
        streamer: json["streamer"] == null
            ? null
            : Streamer.fromJson(json["streamer"]),
        plugin: json["plugin"] == null ? null : Plugin.fromJson(json["plugin"]),
        encoder: json["encoder"] == null ? null : json["encoder"],
        subscription: json["Subscription"] == null
            ? null
            : List<dynamic>.from(json["Subscription"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isCaptchaNeed": isCaptchaNeed == null ? null : isCaptchaNeed,
        "siteLogo": siteLogo == null ? null : siteLogo,
        "id": id == null ? null : id,
        "user": user == null ? null : user,
        "donationLink": donationLink == null ? null : donationLink,
        "name": name == null ? null : name,
        "nameIdentification":
            nameIdentification == null ? null : nameIdentification,
        "pass": pass == null ? null : pass,
        "email": email == null ? null : email,
        "channelName": channelName == null ? null : channelName,
        "photo": photo == null ? null : photo,
        "backgroundURL": backgroundUrl == null ? null : backgroundUrl,
        "isLogged": isLogged == null ? null : isLogged,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "canUpload": canUpload == null ? null : canUpload,
        "canComment": canComment == null ? null : canComment,
        "canStream": canStream == null ? null : canStream,
        "redirectUri": redirectUri == null ? null : redirectUri,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "userGroups": userGroups == null
            ? null
            : List<dynamic>.from(userGroups.map((x) => x)),
        "streamServerURL": streamServerUrl == null ? null : streamServerUrl,
        "streamKey": streamKey == null ? null : streamKey,
        "streamer": streamer == null ? null : streamer.toJson(),
        "plugin": plugin == null ? null : plugin.toJson(),
        "encoder": encoder == null ? null : encoder,
        "Subscription": subscription == null
            ? null
            : List<dynamic>.from(subscription.map((x) => x)),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.cleanName,
    this.description,
    this.nextVideoOrder,
    this.parentId,
    this.created,
    this.modified,
    this.iconClass,
    this.usersId,
    this.private,
    this.allowDownload,
    this.order,
    this.total,
    this.fullTotal,
    this.fullTotalVideos,
    this.fullTotalLives,
    this.fullTotalLivelinks,
    this.owner,
    this.canEdit,
    this.canAddVideo,
    this.hierarchy,
    this.hierarchyAndName,
  });

  final int id;
  final String name;
  final String cleanName;
  final String description;
  final int nextVideoOrder;
  final int parentId;
  final DateTime created;
  final DateTime modified;
  final String iconClass;
  final int usersId;
  final int private;
  final int allowDownload;
  final int order;
  final int total;
  final int fullTotal;
  final int fullTotalVideos;
  final int fullTotalLives;
  final int fullTotalLivelinks;
  final String owner;
  final bool canEdit;
  final bool canAddVideo;
  final String hierarchy;
  final String hierarchyAndName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        cleanName: json["clean_name"] == null ? null : json["clean_name"],
        description: json["description"] == null ? null : json["description"],
        nextVideoOrder:
            json["nextVideoOrder"] == null ? null : json["nextVideoOrder"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        iconClass: json["iconClass"] == null ? null : json["iconClass"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        private: json["private"] == null ? null : json["private"],
        allowDownload:
            json["allow_download"] == null ? null : json["allow_download"],
        order: json["order"] == null ? null : json["order"],
        total: json["total"] == null ? null : json["total"],
        fullTotal: json["fullTotal"] == null ? null : json["fullTotal"],
        fullTotalVideos:
            json["fullTotal_videos"] == null ? null : json["fullTotal_videos"],
        fullTotalLives:
            json["fullTotal_lives"] == null ? null : json["fullTotal_lives"],
        fullTotalLivelinks: json["fullTotal_livelinks"] == null
            ? null
            : json["fullTotal_livelinks"],
        owner: json["owner"] == null ? null : json["owner"],
        canEdit: json["canEdit"] == null ? null : json["canEdit"],
        canAddVideo: json["canAddVideo"] == null ? null : json["canAddVideo"],
        hierarchy: json["hierarchy"] == null ? null : json["hierarchy"],
        hierarchyAndName:
            json["hierarchyAndName"] == null ? null : json["hierarchyAndName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "clean_name": cleanName == null ? null : cleanName,
        "description": description == null ? null : description,
        "nextVideoOrder": nextVideoOrder == null ? null : nextVideoOrder,
        "parentId": parentId == null ? null : parentId,
        "created": created == null ? null : created.toIso8601String(),
        "modified": modified == null ? null : modified.toIso8601String(),
        "iconClass": iconClass == null ? null : iconClass,
        "users_id": usersId == null ? null : usersId,
        "private": private == null ? null : private,
        "allow_download": allowDownload == null ? null : allowDownload,
        "order": order == null ? null : order,
        "total": total == null ? null : total,
        "fullTotal": fullTotal == null ? null : fullTotal,
        "fullTotal_videos": fullTotalVideos == null ? null : fullTotalVideos,
        "fullTotal_lives": fullTotalLives == null ? null : fullTotalLives,
        "fullTotal_livelinks":
            fullTotalLivelinks == null ? null : fullTotalLivelinks,
        "owner": owner == null ? null : owner,
        "canEdit": canEdit == null ? null : canEdit,
        "canAddVideo": canAddVideo == null ? null : canAddVideo,
        "hierarchy": hierarchy == null ? null : hierarchy,
        "hierarchyAndName": hierarchyAndName == null ? null : hierarchyAndName,
      };
}

class Plugin {
  Plugin({
    this.doNotAllowAnonimusAccess,
    this.doNotAllowUpload,
    this.hideCreateAccount,
    this.hideTabTrending,
    this.hideTabLive,
    this.hideTabSubscription,
    this.hideTabPlayLists,
    this.hideViewsCounter,
    this.hideLikes,
    this.eula,
    this.themeDark,
    this.portraitImage,
    this.netflixStyle,
    this.netflixDateAdded,
    this.netflixMostPopular,
    this.netflixMostWatched,
    this.netflixCategories,
    this.netflixBigVideo,
    this.disableWhitelabel,
    this.approvalMode,
    this.showMeet,
    this.goLiveWithMeet,
    this.doNotAutoSearch,
  });

  final bool doNotAllowAnonimusAccess;
  final bool doNotAllowUpload;
  final bool hideCreateAccount;
  final bool hideTabTrending;
  final bool hideTabLive;
  final bool hideTabSubscription;
  final bool hideTabPlayLists;
  final bool hideViewsCounter;
  final bool hideLikes;
  final Eula eula;
  final bool themeDark;
  final bool portraitImage;
  final bool netflixStyle;
  final bool netflixDateAdded;
  final bool netflixMostPopular;
  final bool netflixMostWatched;
  final bool netflixCategories;
  final bool netflixBigVideo;
  final bool disableWhitelabel;
  final bool approvalMode;
  final bool showMeet;
  final bool goLiveWithMeet;
  final bool doNotAutoSearch;

  factory Plugin.fromJson(Map<String, dynamic> json) => Plugin(
        doNotAllowAnonimusAccess: json["doNotAllowAnonimusAccess"] == null
            ? null
            : json["doNotAllowAnonimusAccess"],
        doNotAllowUpload:
            json["doNotAllowUpload"] == null ? null : json["doNotAllowUpload"],
        hideCreateAccount: json["hideCreateAccount"] == null
            ? null
            : json["hideCreateAccount"],
        hideTabTrending:
            json["hideTabTrending"] == null ? null : json["hideTabTrending"],
        hideTabLive: json["hideTabLive"] == null ? null : json["hideTabLive"],
        hideTabSubscription: json["hideTabSubscription"] == null
            ? null
            : json["hideTabSubscription"],
        hideTabPlayLists:
            json["hideTabPlayLists"] == null ? null : json["hideTabPlayLists"],
        hideViewsCounter:
            json["hideViewsCounter"] == null ? null : json["hideViewsCounter"],
        hideLikes: json["hideLikes"] == null ? null : json["hideLikes"],
        eula: json["EULA"] == null ? null : Eula.fromJson(json["EULA"]),
        themeDark: json["themeDark"] == null ? null : json["themeDark"],
        portraitImage:
            json["portraitImage"] == null ? null : json["portraitImage"],
        netflixStyle:
            json["netflixStyle"] == null ? null : json["netflixStyle"],
        netflixDateAdded:
            json["netflixDateAdded"] == null ? null : json["netflixDateAdded"],
        netflixMostPopular: json["netflixMostPopular"] == null
            ? null
            : json["netflixMostPopular"],
        netflixMostWatched: json["netflixMostWatched"] == null
            ? null
            : json["netflixMostWatched"],
        netflixCategories: json["netflixCategories"] == null
            ? null
            : json["netflixCategories"],
        netflixBigVideo:
            json["netflixBigVideo"] == null ? null : json["netflixBigVideo"],
        disableWhitelabel: json["disableWhitelabel"] == null
            ? null
            : json["disableWhitelabel"],
        approvalMode:
            json["approvalMode"] == null ? null : json["approvalMode"],
        showMeet: json["showMeet"] == null ? null : json["showMeet"],
        goLiveWithMeet:
            json["goLiveWithMeet"] == null ? null : json["goLiveWithMeet"],
        doNotAutoSearch:
            json["doNotAutoSearch"] == null ? null : json["doNotAutoSearch"],
      );

  Map<String, dynamic> toJson() => {
        "doNotAllowAnonimusAccess":
            doNotAllowAnonimusAccess == null ? null : doNotAllowAnonimusAccess,
        "doNotAllowUpload": doNotAllowUpload == null ? null : doNotAllowUpload,
        "hideCreateAccount":
            hideCreateAccount == null ? null : hideCreateAccount,
        "hideTabTrending": hideTabTrending == null ? null : hideTabTrending,
        "hideTabLive": hideTabLive == null ? null : hideTabLive,
        "hideTabSubscription":
            hideTabSubscription == null ? null : hideTabSubscription,
        "hideTabPlayLists": hideTabPlayLists == null ? null : hideTabPlayLists,
        "hideViewsCounter": hideViewsCounter == null ? null : hideViewsCounter,
        "hideLikes": hideLikes == null ? null : hideLikes,
        "EULA": eula == null ? null : eula.toJson(),
        "themeDark": themeDark == null ? null : themeDark,
        "portraitImage": portraitImage == null ? null : portraitImage,
        "netflixStyle": netflixStyle == null ? null : netflixStyle,
        "netflixDateAdded": netflixDateAdded == null ? null : netflixDateAdded,
        "netflixMostPopular":
            netflixMostPopular == null ? null : netflixMostPopular,
        "netflixMostWatched":
            netflixMostWatched == null ? null : netflixMostWatched,
        "netflixCategories":
            netflixCategories == null ? null : netflixCategories,
        "netflixBigVideo": netflixBigVideo == null ? null : netflixBigVideo,
        "disableWhitelabel":
            disableWhitelabel == null ? null : disableWhitelabel,
        "approvalMode": approvalMode == null ? null : approvalMode,
        "showMeet": showMeet == null ? null : showMeet,
        "goLiveWithMeet": goLiveWithMeet == null ? null : goLiveWithMeet,
        "doNotAutoSearch": doNotAutoSearch == null ? null : doNotAutoSearch,
      };
}

class Eula {
  Eula({
    this.type,
    this.value,
  });

  final String type;
  final String value;

  factory Eula.fromJson(Map<String, dynamic> json) => Eula(
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "value": value == null ? null : value,
      };
}

class Streamer {
  Streamer({
    this.maxFileSize,
    this.fileUploadMaxSize,
    this.videoStorageLimitMinutes,
    this.currentStorageUsage,
    this.webSiteLogo,
    this.webSiteTitle,
    this.phpsessid,
    this.version,
    this.mobileSreamerVersion,
    this.reportVideoPluginEnabled,
    this.oauthLogin,
    this.plugins,
  });

  final String maxFileSize;
  final int fileUploadMaxSize;
  final int videoStorageLimitMinutes;
  final int currentStorageUsage;
  final String webSiteLogo;
  final String webSiteTitle;
  final String phpsessid;
  final String version;
  final int mobileSreamerVersion;
  final bool reportVideoPluginEnabled;
  final List<OauthLogin> oauthLogin;
  final Plugins plugins;

  factory Streamer.fromJson(Map<String, dynamic> json) => Streamer(
        maxFileSize:
            json["max_file_size"] == null ? null : json["max_file_size"],
        fileUploadMaxSize: json["file_upload_max_size"] == null
            ? null
            : json["file_upload_max_size"],
        videoStorageLimitMinutes: json["videoStorageLimitMinutes"] == null
            ? null
            : json["videoStorageLimitMinutes"],
        currentStorageUsage: json["currentStorageUsage"] == null
            ? null
            : json["currentStorageUsage"],
        webSiteLogo: json["webSiteLogo"] == null ? null : json["webSiteLogo"],
        webSiteTitle:
            json["webSiteTitle"] == null ? null : json["webSiteTitle"],
        phpsessid: json["PHPSESSID"] == null ? null : json["PHPSESSID"],
        version: json["version"] == null ? null : json["version"],
        mobileSreamerVersion: json["mobileSreamerVersion"] == null
            ? null
            : json["mobileSreamerVersion"],
        reportVideoPluginEnabled: json["reportVideoPluginEnabled"] == null
            ? null
            : json["reportVideoPluginEnabled"],
        oauthLogin: json["oauthLogin"] == null
            ? null
            : List<OauthLogin>.from(
                json["oauthLogin"].map((x) => OauthLogin.fromJson(x))),
        plugins:
            json["plugins"] == null ? null : Plugins.fromJson(json["plugins"]),
      );

  Map<String, dynamic> toJson() => {
        "max_file_size": maxFileSize == null ? null : maxFileSize,
        "file_upload_max_size":
            fileUploadMaxSize == null ? null : fileUploadMaxSize,
        "videoStorageLimitMinutes":
            videoStorageLimitMinutes == null ? null : videoStorageLimitMinutes,
        "currentStorageUsage":
            currentStorageUsage == null ? null : currentStorageUsage,
        "webSiteLogo": webSiteLogo == null ? null : webSiteLogo,
        "webSiteTitle": webSiteTitle == null ? null : webSiteTitle,
        "PHPSESSID": phpsessid == null ? null : phpsessid,
        "version": version == null ? null : version,
        "mobileSreamerVersion":
            mobileSreamerVersion == null ? null : mobileSreamerVersion,
        "reportVideoPluginEnabled":
            reportVideoPluginEnabled == null ? null : reportVideoPluginEnabled,
        "oauthLogin": oauthLogin == null
            ? null
            : List<dynamic>.from(oauthLogin.map((x) => x.toJson())),
        "plugins": plugins == null ? null : plugins.toJson(),
      };
}

class OauthLogin {
  OauthLogin({
    this.type,
    this.status,
  });

  final String type;
  final bool status;

  factory OauthLogin.fromJson(Map<String, dynamic> json) => OauthLogin(
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "status": status == null ? null : status,
      };
}

class Plugins {
  Plugins({
    this.notifications,
  });

  final Notifications notifications;

  factory Plugins.fromJson(Map<String, dynamic> json) => Plugins(
        notifications: json["Notifications"] == null
            ? null
            : Notifications.fromJson(json["Notifications"]),
      );

  Map<String, dynamic> toJson() => {
        "Notifications": notifications == null ? null : notifications.toJson(),
      };
}

class Notifications {
  Notifications({
    this.oneSignalEnabled,
    this.oneSignalAppid,
    this.oneSignalFirebaseSenderId,
    this.oneSignalDebugMode,
  });

  final bool oneSignalEnabled;
  final String oneSignalAppid;
  final String oneSignalFirebaseSenderId;
  final bool oneSignalDebugMode;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        oneSignalEnabled:
            json["oneSignalEnabled"] == null ? null : json["oneSignalEnabled"],
        oneSignalAppid:
            json["oneSignalAPPID"] == null ? null : json["oneSignalAPPID"],
        oneSignalFirebaseSenderId: json["oneSignalFIREBASE_SENDER_ID"] == null
            ? null
            : json["oneSignalFIREBASE_SENDER_ID"],
        oneSignalDebugMode: json["oneSignalDebugMode"] == null
            ? null
            : json["oneSignalDebugMode"],
      );

  Map<String, dynamic> toJson() => {
        "oneSignalEnabled": oneSignalEnabled == null ? null : oneSignalEnabled,
        "oneSignalAPPID": oneSignalAppid == null ? null : oneSignalAppid,
        "oneSignalFIREBASE_SENDER_ID": oneSignalFirebaseSenderId == null
            ? null
            : oneSignalFirebaseSenderId,
        "oneSignalDebugMode":
            oneSignalDebugMode == null ? null : oneSignalDebugMode,
      };
}
