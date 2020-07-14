import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';
import 'package:github_pages/utils/constants.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<User> data;

  @override
  Widget build(BuildContext context) {
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
                  return buildUserTile(i);
                }));
  }

  Column buildUserTile(int i) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding,
            vertical: kPadding / 2,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[i].avatarUrl),
              backgroundColor: Colors.grey[200],
            ),
            title: Text(
              data[i].login,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: Colors.blue[50].withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
