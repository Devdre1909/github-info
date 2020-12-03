import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_pages/models/Repo.dart';
import 'package:github_pages/requests/GithubRequest.dart';

class RepoProvider with ChangeNotifier {
  List<Repo> repos;
  bool _isLoading = false;
  String _errorMsg = "";

  bool get loading => _isLoading;
  List<Repo> get getRepos => repos;
  String get errorMsg => _errorMsg;

  Future<bool> fetchRepos(username) async {
    setLoading(true);

    var data = await Github(username).fetchRepos();
    if (data.statusCode == 200) {
      Iterable list = json.decode(data.body);
      List<Repo> repos = list.map((e) => Repo.fromJson(e)).toList();
      setRepos(repos);
    } else {
      setLoading(false);
      Map<String, dynamic> error = json.decode(data.body);
      setErrorMsg(error['message']);
    }
    return isRepos();
  }

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void setErrorMsg(String e) {
    _errorMsg = e;
    notifyListeners();
  }

  bool isRepos() {
    return repos != null ? true : false;
  }

  void setRepos(List<Repo> repos) {
    this.repos = repos;
    notifyListeners();
  }
}
