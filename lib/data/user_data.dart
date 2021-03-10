import 'dart:convert';

import 'package:ivrata_tv/logic/api/models/user_model.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';

abstract class User {
  static UserData _instance;
  static UserData get instance => _instance;

  static Future<void> setInstance(
    UserData newData, [
    bool cache = false,
  ]) async {
    _instance = newData;
    if (cache)
      await Prefs.instance.setString('userData', jsonEncode(newData.toJson()));
  }

  static bool get loggedIn => instance?.id != null;
}
