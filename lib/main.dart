import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_pages/providers/UserProvider.dart';
import 'package:github_pages/screens/user_info.dart';
import 'package:github_pages/utils/constants.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textEControllerUsername = new TextEditingController();

  void _getUser() {
    print("running: _getUser ${_textEControllerUsername.text}");
    if (_textEControllerUsername.text.isNotEmpty) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_textEControllerUsername.text)
          .then((value) {
        if (value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserInfo()));
        }
      });
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .setErrorMessage("Please enter your username");
    }
  }

  void dispose() {
    _textEControllerUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  SizedBox(height: 100.0),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/images/iconfinder_github_rounded_394187.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "GitHub",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 100),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: kPadding / 2),
                    padding: EdgeInsets.symmetric(
                        vertical: kPadding / 2, horizontal: kPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        Provider.of<UserProvider>(context, listen: false)
                            .setErrorMessage(null);
                      },
                      controller: _textEControllerUsername,
                      autofocus: true,
                      enabled: !Provider.of<UserProvider>(context).getLoading,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        errorText:
                            Provider.of<UserProvider>(context).getErrorMessage,
                        border: InputBorder.none,
                        hintText: "Github Username",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding / 2,
                    ),
                    child: MaterialButton(
                      height: 12,
                      elevation: 2.0,
                      padding: const EdgeInsets.all(kPadding),
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Continue"),
                          ),
                          SizedBox(width: 20),
                          Provider.of<UserProvider>(context).getLoading
                              ? SizedBox(
                                  height: 17,
                                  width: 17,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                      onPressed: () {
                        _getUser();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
