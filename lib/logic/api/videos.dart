import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/category_model.dart';
import 'models/videos_response_model.dart';

abstract class VideosAPI {
  static Future<VideosResponse> getLatest([int page]) async =>
      videosResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=video&sort[created]=desc&rowCount=' +
                  (page == null ? '8' : '60&current=$page')))
          .body);

  static Future<VideosResponse> getTrending() async =>
      videosResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=video&sort[likes]=desc&rowCount=30'))
          .body);

  static Future<CategoryResponse> getCategories() async =>
      categoryResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=categories'))
          .body);

  static Future<VideosResponse> getVideosByCategory(
          String categoryName, int page, [int series]) async =>
      videosResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=video&catName=$categoryName&rowCount=60&current=$page' +
                  (series == null ? '' : '&is_serie=$series')))
          .body);

  static Future getLivestreams() async => jsonDecode((await http.get(
          'https://video.ivrata.com/plugin/API/get.json.php?APIName=livestreams'))
      .body);

  static Future<VideosResponse> getChannelVideos(String channel, int page,
          [bool infinite = false]) async =>
      videosResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=video&channelName=$channel&current=$page&rowCount=' +
                  (infinite ? '1000' : '60')))
          .body);

  static Future<VideosResponse> searchVideos(String searchTerm, int page,
          [int series]) async =>
      videosResponseFromJson((await http.get(
              'https://video.ivrata.com/plugin/API/get.json.php?APIName=video&rowCount=60&current=$page&searchPhrase=$searchTerm' +
                  (series == null ? '' : '&is_serie=$series')))
          .body);
}
