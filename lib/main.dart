import 'package:cadabra/home_page.dart';
import 'package:cadabra/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cadabra/screen_introduction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn;
  int count;
  void initState() {
    getCredentials();
    super.initState();
  }

  getCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      count = sharedPreferences.getInt("showIntroductionScreen") ?? 0;
      isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
    });
  }

  checkLogin() {
    if (isLoggedIn)
      return HomePage();
    else
      return Login();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.black,
          primaryColorLight: Colors.black,
          primaryColorDark: Colors.black,
          toggleableActiveColor: Colors.black,
          accentColor: Colors.black,
          secondaryHeaderColor: Colors.black,
          textSelectionColor: Colors.black,
          backgroundColor: Colors.black,
          buttonColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(buttonColor: Colors.black)),
      home: SplashScreen(
          seconds: 2,
          navigateAfterSeconds: count == 1 ? checkLogin() : OnBoardingPage(),
          title: new Text(
            '\tWelcome To The \n'
            'Future Of Security',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: new Image.asset('assets/images/cadabra_logo_new.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.black),
    );
  }
}
