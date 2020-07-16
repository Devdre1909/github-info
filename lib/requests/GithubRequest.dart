import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Github {
  final String username;
  final String baseUrl = DotEnv().env['BASEURL'];
  final String token = DotEnv().env['TOKEN'];
  final String pUsername = DotEnv().env['USERNAME'];

  Github(this.username);

  Future<http.Response> fetchUser() {
    // print("$baseUrl/users/$username");
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    print(authn);

    return http
        .get("$baseUrl/users/$username", headers: {'Authorization': authn});
  }

  Future<http.Response> fetchFollowing() {
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    return http.get("$baseUrl/users/$username/following",
        headers: {'Authorization': authn});
  }

  Future<http.Response> fetchFollowers() {
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    return http.get("$baseUrl/users/$username/followers",
        headers: {'Authorization': authn});
  }

  Future<http.Response> fetchRepos() {
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    return http.get("$baseUrl/users/$username/repos",
        headers: {'Authorization': authn});
  }
}
