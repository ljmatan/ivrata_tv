import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/models/user_info_favorites.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'package:ivrata_tv/logic/storage/local.dart';

abstract class Social {
  static Future<http.Response> like(int id) async => await http.post(
      'https://video.ivrata.com/plugin/API/set.json.php?APIName=like&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true');

  static Future<http.Response> dislike(int id) async => await http.post(
      'https://video.ivrata.com/plugin/API/set.json.php?APIName=dislike&videos_id=$id'
      '&user=${User.instance.user}&pass=${User.instance.pass}&encodedPass=true');

  static Future<bool> isLiked(int id, int vote) async {
    bool liked = false;
    try {
      final response = await http.get(
          'https://video.ivrata.com/plugin/API/get.json.php?APIName=likes&videos_id=$id&user=${User.instance.user}&pass=${User.instance.pass}');
      final decoded = jsonDecode(response.body);
      if (decoded['response']['myVote'] == vote) liked = true;
    } catch (e) {
      print('Error checking if video is liked');
    }

    return liked;
  }

  static Future<http.Response> comment(
    String comment,
    int videoID, [
    int commentID,
  ]) async =>
      await http.post(
          'https://video.ivrata.com/plugin/API/set.json.php?APIName=comment&videos_id=$videoID&user=${User.instance.user}&pass=&pass=${User.instance.pass}&comment=$comment');

  static Future<http.Response> favorite(int id) async => await http.get(
      'https://video.ivrata.com/plugin/API/set.json.php?APIName=favorite&videos_id=$id&user=${User.instance.user}&pass=${User.instance.pass}');

  static Future<void> getFavorites(String username, String password) async {
    try {
      final response = await http.get(
          'https://video.ivrata.com/plugin/API/get.json.php?APIName=favorite&user=$username&pass=$password&apiSecret=b50659819eb61ceae567ecd5dd51ea31');
      final decoded = jsonDecode(response.body);
      final userInfo = UserInfo.fromJson(decoded);
      for (var video in userInfo.videos) {
        await DB.instance.insert(
          'Saved',
          {
            'videoID': video.id,
            'savedVideoEncoded': jsonEncode(video.toJson()),
          },
        );
        await Prefs.instance.setBool('${video.id} saved', true);
      }
    } catch (e) {
      print('Couldn\'t get favorites: $e');
    }
  }
}
