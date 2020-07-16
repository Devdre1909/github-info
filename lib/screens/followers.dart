import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';

import 'components/user_list_tile.dart';

class Follower extends StatefulWidget {
  final List<User> followers;
  final List<User> following;

  const Follower({Key key, this.followers, this.following}) : super(key: key);
  @override
  _FollowerState createState() => _FollowerState(followers, following);
}

class _FollowerState extends State<Follower> {
  final List<User> followers;
  final List<User> following;

  _FollowerState(this.followers, this.following);

  @override
  Widget build(BuildContext context) {
    List<String> followingLogin =
        following.map((e) => e.login.toString()).toList();

    return UserListTile(
      data: followers,
      tab: "followers",
      following: followingLogin,
    );
  }
}
