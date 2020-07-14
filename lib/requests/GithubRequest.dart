import 'package:http/http.dart' as http;
import 'dart:convert';

class Github {
  final String username;
  final String baseUrl = "https://api.github.com";
  final String token = "d011f56185b1dea374ada5048975921ef64b972d";
  final String pUsername = "devdre1909";

  Github(this.username);

  Future<http.Response> fetchUser() async {
    // print("$baseUrl/users/$username");
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    print(authn);
    try {
      return await http
          .get("$baseUrl/users/$username", headers: {'Authorization': authn});
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> fetchFollowing() async {
    var authn = 'Basic ' + base64Encode(utf8.encode('$pUsername:$token'));
    return await http.get("$baseUrl/users/$username/following",
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
