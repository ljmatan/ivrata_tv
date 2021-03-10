import 'package:http/http.dart' as http;

abstract class Auth {
  static Future<http.Response> login(String username, String password) async =>
      await http.get(
          'https://video.ivrata.com/plugin/API/get.json.php?APIName=signIn&user=$username&pass=$password');

  static Future<http.Response> register(
    String username,
    String email,
    String password,
    String name,
  ) async =>
      await http.post(
        'https://video.ivrata.com/plugin/API/set.json.php?APIName=signUp&APISecret=b50659819eb61ceae567ecd5dd51ea31'
        '&user=$username&pass=$password&email=$email&name=$name',
      );

  static Future<http.Response> getUserInfo(int id) async => await http.get(
      'https://video.ivrata.com/plugin/API/get.json.php?APIName=user&APISecret=b50659819eb61ceae567ecd5dd51ea31&users_id=$id');
}
