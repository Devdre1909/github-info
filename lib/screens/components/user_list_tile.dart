import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';
import 'package:github_pages/screens/user_info.dart';
import 'package:github_pages/utils/constants.dart';

import '../profile_pic.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.data,
    @required this.tab,
    this.following,
  }) : super(key: key);

  final List<User> data;
  final String tab;
  final List<String> following;

  @override
  Widget build(BuildContext context) {
    // var followersLogin = data.map((e) => e.login);
    print(following);

    return Container(
        padding: EdgeInsets.symmetric(vertical: kPadding),
        color: Colors.blue[50].withOpacity(0.4),
        child: data.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return buildUserTile(i, tab, context);
                }));
  }

  Column buildUserTile(int i, String tab, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding,
            vertical: kPadding / 2,
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return UserInfo(
                      username: data[i].login,
                    );
                  },
                ),
              );
            },
            trailing: Text(
              following != null
                  ? (following.contains(data[i].login) ? "following" : "")
                  : "following",
              style: TextStyle(
                fontSize: 10,
                color: kPrimaryColor,
              ),
            ),
            leading: Container(
              child: OpenContainer(
                closedBuilder: (BuildContext context, void Function() action) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(data[i].avatarUrl),
                    backgroundColor: Colors.grey[200],
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object returnValue}) action) {
                  return ProfilePicture(
                      url: data[i].avatarUrl, name: data[i].login);
                },
              ),
            ),
            title: Text(
              data[i].login,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.blue,
          indent: 15,
          endIndent: 15,
          thickness: 0.3,
        ),
      ],
    );
  }
}
