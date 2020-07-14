import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';

import 'components/user_list_tile.dart';

class Follower extends StatefulWidget {
  final List<User> followers;

  const Follower({Key key, this.followers}) : super(key: key);
  @override
  _FollowerState createState() => _FollowerState(followers);
}

class _FollowerState extends State<Follower> {
  final List<User> followers;

  _FollowerState(this.followers);

  @override
  Widget build(BuildContext context) {
    return UserListTile(data: followers);
  }
}
