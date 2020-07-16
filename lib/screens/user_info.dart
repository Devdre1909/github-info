import 'dart:convert';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';
import 'package:github_pages/providers/UserProvider.dart';
import 'package:github_pages/requests/GithubRequest.dart';
import 'package:github_pages/screens/followers.dart';
import 'package:github_pages/screens/following.dart';
import 'package:github_pages/screens/orgs.dart';
import 'package:github_pages/screens/profile.dart';
import 'package:github_pages/screens/profile_pic.dart';
import 'package:github_pages/screens/repos.dart';
import 'package:github_pages/utils/constants.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  final String username;

  const UserInfo({Key key, this.username}) : super(key: key);
  @override
  _UserInfoState createState() => _UserInfoState(username);
}

class _UserInfoState extends State<UserInfo> {
  User user;
  List<User> following;
  List<User> followers;
  final String username;

  _UserInfoState(this.username);

  @override
  void initState() {
    super.initState();
    _decidePath(username);
  }

  getData() async {
    var followingValue = await Github(user.login).fetchFollowing();
    Iterable followingList = json.decode(followingValue.body);
    setState(() {
      following = followingList.map((e) => User.fromJson(e)).toList();
    });

    var followersValue = await Github(user.login).fetchFollowers();
    Iterable followersList = json.decode(followersValue.body);

    setState(() {
      followers = followersList.map((e) => User.fromJson(e)).toList();
    });
  }

  _decidePath(username) {
    if (username != null) {
      print("Not null $username");
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(username)
          .then((value) {
        if (value) {
          user = Provider.of<UserProvider>(context, listen: false).getUser;
          getData();
        }
      });
    } else {
      setState(() {
        user = Provider.of<UserProvider>(context, listen: false).getUser;
      });
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: user == null
            ? Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 5,
                initialIndex: 0,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        // title: Text(
                        //   user.login,
                        //   style: TextStyle(color: Colors.white, fontSize: 16.0),
                        // ),
                        backgroundColor: kPrimaryColor,
                        floating: false,
                        pinned: true,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                size: 16,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        expandedHeight: 275,
                        bottom: TabBar(
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white60,
                          indicator: innerBoxIsScrolled
                              ? BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 3,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                          tabs: [
                            Tab(
                              child: TabItem(
                                hasValue: false,
                                tabName: "Profile",
                              ),
                            ),
                            Tab(
                              child: TabItem(
                                hasValue: true,
                                text: user != null
                                    ? user.following.toString()
                                    : '',
                                tabName: "Following",
                                innerBoxIsScrolled: innerBoxIsScrolled,
                              ),
                            ),
                            Tab(
                              child: TabItem(
                                hasValue: true,
                                text: user != null
                                    ? user.followers.toString()
                                    : '',
                                tabName: "Followers",
                                innerBoxIsScrolled: innerBoxIsScrolled,
                              ),
                            ),
                            Tab(
                              child: TabItem(
                                hasValue: false,
                                tabName: "Repos",
                              ),
                            ),
                            Tab(
                              child: TabItem(
                                hasValue: false,
                                tabName: "Organizations",
                              ),
                            )
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          title: innerBoxIsScrolled
                              ? Text(
                                  user != null ? "@${user.login}" : '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                )
                              : null,
                          titlePadding: EdgeInsetsDirectional.only(bottom: 50),
                          centerTitle: true,
                          background: user != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(user.avatarUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          OpenContainer(
                                            closedColor:
                                                Colors.black.withOpacity(0.0),
                                            openColor:
                                                Colors.black.withOpacity(0.1),
                                            // openShape:
                                            closedBuilder:
                                                (BuildContext context,
                                                    void Function() action) {
                                              return buildAvatarContainer(
                                                  user.avatarUrl);
                                            },
                                            openBuilder: (BuildContext context,
                                                void Function(
                                                        {Object returnValue})
                                                    action) {
                                              return ProfilePicture(
                                                  url: user.avatarUrl,
                                                  name: user.login);
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "@${user.login}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: kPadding / 4,
                                              horizontal: kPadding,
                                            ),
                                            child: Center(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  user.bio != null
                                                      ? user.bio
                                                      : "No bio",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                        color: Colors.white70,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : CircularProgressIndicator(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      Profile(),
                      Following(
                        following: following,
                      ),
                      Follower(
                        followers: followers,
                        following: following,
                      ),
                      Repos(),
                      Org(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Container buildAvatarContainer(url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 100,
      height: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    Key key,
    @required this.hasValue,
    this.text,
    @required this.tabName,
    this.innerBoxIsScrolled,
  }) : super(key: key);

  final bool hasValue;
  final String text;
  final String tabName;
  final bool innerBoxIsScrolled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tabName),
        SizedBox(width: 7),
        hasValue
            ? Container(
                padding: EdgeInsets.all(3.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: innerBoxIsScrolled ? Colors.black45 : Colors.grey[500],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              )
            : Text(""),
      ],
    );
  }
}
