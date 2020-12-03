import 'package:flutter/material.dart';
import 'package:github_pages/models/Repo.dart';
import 'package:github_pages/providers/RepoProvider.dart';
import 'package:provider/provider.dart';

class Repos extends StatefulWidget {
  final String username;

  const Repos({Key key, this.username}) : super(key: key);
  @override
  _ReposState createState() => _ReposState(username);
}

class _ReposState extends State<Repos> {
  List<Repo> repos;
  final String username;

  _ReposState(this.username);

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    var data = await Provider.of<RepoProvider>(context, listen: false)
        .fetchRepos(username);
    print("data $data");
    if (data) {
      setState(() {
        repos = Provider.of<RepoProvider>(context, listen: false).getRepos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: repos == null
          ? Container(
              height: 100,
              width: 100,
              child: Center(child: CircularProgressIndicator()))
          : ListView.builder(
              itemCount: repos != null ? repos.length : 0,
              itemBuilder: (context, i) => Container(
                child: ListTile(
                  subtitle: Text(
                    repos[i].description != null
                        ? repos[i].description
                        : "No description",
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                  title: Text(
                    repos[i].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
