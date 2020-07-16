import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String url;
  final String name;

  const ProfilePicture({Key key, @required this.url, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: name != null ? Text(name) : null,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
