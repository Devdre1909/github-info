import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_pages/models/User.dart';
import 'package:github_pages/requests/GithubRequest.dart';

class UserProvider with ChangeNotifier {
  User user;
  String _errorMessage;
  bool _loading = false;

  // Getters
  bool get getLoading => _loading;
  String get getErrorMessage => _errorMessage;
  User get getUser => user;

  Future<bool> fetchUser(username) async {
    setLoading(true);

    await Github(username).fetchUser().then((data) {
      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        setLoading(false);
        Map<String, dynamic> result = json.decode(data.body);
        // print(result['message']);
        setErrorMessage(result['message']);
      }
    });

    return isUser();
  }

  // Setters
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setUser(user) {
    this.user = user;
    notifyListeners();
  }

  void setErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  bool isUser() {
    return user != null ? true : false;
  }
}
