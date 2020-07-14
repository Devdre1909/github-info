import 'dart:convert';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:github_pages/models/User.dart';
import 'package:github_pages/providers/UserProvider.dart';
import 'package:github_pages/requests/GithubRequest.dart';
import 'package:github_pages/screens/followers.dart';
import 'package:github_pages/screens/following.dart';
import 'package:github_pages/screens/orgs.dart';
import 'package:github_pages/screens/profile.dart';
import 'package:github_pages/screens/repos.dart';
import 'package:github_pages/utils/constants.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User user;
  List<User> following;
  List<User> followers;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUser;
    });

    void _getFollowing() async {
      Github(user.login).fetchFollowing().then((value) {
        Iterable list = json.decode(value.body);
        setState(() {
          following = list.map((e) => User.fromJson(e)).toList();
        });
      });
    }

    void _getFollowers() async {
      Github(user.login).fetchFollowers().then((value) {
        Iterable list = json.decode(value.body);
        setState(() {
          followers = list.map((e) => User.fromJson(e)).toList();
        });
      });
    }

    _getFollowing();
    _getFollowers();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
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
                  leading: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
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
                        child: Text("Profile"),
                      ),
                      Tab(
                        child: Badge(
                          badgeContent: Text(
                            user.following.toString(),
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          child: Text("Following"),
                          badgeColor: Colors.blue,
                        ),
                      ),
                      Tab(
                        child: Badge(
                          badgeContent: Text(
                            user.followers.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          child: Text("Followers"),
                          badgeColor: Colors.blue,
                        ),
                      ),
                      Tab(
                        child: Text("Repository"),
                      ),
                      Tab(
                        child: Text("Organizations"),
                      )
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: innerBoxIsScrolled
                        ? Text(
                            user.login,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          )
                        : null,
                    titlePadding: EdgeInsetsDirectional.only(bottom: 50),
                    centerTitle: true,
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(user.avatarUrl),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                user.login,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 2),
                              Text(
                                user.bio,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
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
}
