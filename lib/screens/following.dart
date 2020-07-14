import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';

import 'components/user_list_tile.dart';

class Following extends StatefulWidget {
  final List<User> following;

  const Following({Key key, this.following}) : super(key: key);

  @override
  _FollowingState createState() => _FollowingState(following);
}

class _FollowingState extends State<Following> {
  final List<User> following;

  _FollowingState(this.following);

  @override
  Widget build(BuildContext context) {
    return UserListTile(data: following);
  }
}
