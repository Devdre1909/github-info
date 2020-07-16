import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
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
      title: 'Git Info',
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

  void _getUser() async {
    print("running: _getUser ${_textEControllerUsername.text}");
    if (_textEControllerUsername.text.isNotEmpty) {
      var value = await Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_textEControllerUsername.text);

      if (value) {
        print(value);
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => UserInfo(
              username: null,
            ),
          ),
        );
      }
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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: Duration(seconds: 5),
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.black45,
              child: Padding(
                padding: EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    SizedBox(height: 100.0),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage(
                              "assets/images/iconfinder_github2_216636.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "GitHub",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 40,
                            height: 0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "INFO",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: kPadding / 2),
                      padding: EdgeInsets.symmetric(
                        vertical: kPadding / 2.5,
                        horizontal: kPadding / 1.5,
                      ),
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
                          errorText: Provider.of<UserProvider>(context)
                              .getErrorMessage,
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
                        elevation: 2.0,
                        padding: const EdgeInsets.all(kPadding * 1.25),
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
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
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
      ),
    );
  }
}
