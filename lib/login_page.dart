import 'dart:convert';

import 'package:cadabra/home_page.dart';
import 'package:cadabra/sign_up.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/reusable_widgets.dart';
import 'utils/constants.dart' as constants;
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _login = new GlobalKey<FormState>();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TextEditingController emailController, passwordController;
  SharedPreferences sharedPreferences;

  bool _passwordVisible = true;
  bool checkValue = false;
  // ProgressDialog pr;

  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    // getCredential();
    super.initState();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // getCredential() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     checkValue = sharedPreferences.getBool("check");
  //     if (checkValue != null) {
  //       if (checkValue) {
  //         emailController.text = sharedPreferences.getString("username");
  //         passwordController.text = sharedPreferences.getString("password");
  //       } else {
  //         sharedPreferences.clear();
  //         // passwordController.clear();
  //         // sharedPreferences.clear();
  //       }
  //     } else {
  //       checkValue = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
        width: 150.0,
        height: 160.0,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/cadabra_logo_new.png"))));

    final emailTextField = Padding(
        padding: EdgeInsets.all(15),
        child: Container(
            child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              border: OutlineInputBorder(),
              labelText: constants.emailLabelText,
              hintText: constants.emailHintText,
              counterText: ""),
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        )));

    final passwordTextField = Padding(
        padding: EdgeInsets.all(15),
        child: Container(
            child: TextFormField(
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            labelText: constants.passwordLabelText,
            hintText: constants.passwordHintText,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? (Icons.visibility_off) : (Icons.visibility),
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          controller: passwordController,
          obscureText: _passwordVisible,
        )));

    final loginButton = Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          // color: Colors.pink[1000],
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
              _loginAction(
                  emailController.text.trim(), passwordController.text.trim());
            } else {
              ReusableWidgets.showDialogBox(
                  context, Text("You are not connected to Internet..."));
            }
          },
          // padding:
          // EdgeInsets.all(15),
          child: Text('LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );

    // final checkBox = CheckboxListTile(
    //   value: checkValue,
    //   activeColor: Colors.pink[1000],
    //   onChanged: _onChanged,
    //   title: new Text("Remember me"),
    //   controlAffinity: ListTileControlAffinity.leading,
    // );
    final registerLink = FlatButton(
      child: Text(
        constants.registerLink,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new Register()));
      },
    );

    final scrollView = Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Center(child: logo),
            Column(
              children: <Widget>[
                Padding(
                    padding: new EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontStyle: FontStyle.italic),
                    ))),
              ],
            ),
            Form(
              key: _login,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                  ),
                  Center(child: emailTextField),
                  Center(child: passwordTextField),
                  // Center(
                  //   child: checkBox,
                  // ),
                  loginButton,
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  registerLink
                ],
              ),
            )
          ],
        ));
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            // //   actions: <Widget>[

            // // ],
            // ),
            body: new Stack(
              children: <Widget>[
                // new Container(
                //   decoration: new BoxDecoration(
                //     image: new DecorationImage(
                //       image: new AssetImage("assets/images/cadabra_logo_new.png"),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                scrollView
              ],
            )));
  }

  _loginAction(String email, String password) async {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regEmailExp = new RegExp(emailPattern);

    if (email == "") {
      ReusableWidgets.showDialogBox(
          context, Text("Email field can't be left blank"));
    } else if (!regEmailExp.hasMatch(email)) {
      ReusableWidgets.showDialogBox(
          context, Text("Email format is not correct"));
    } else if (password == "") {
      ReusableWidgets.showDialogBox(context, Text("Please Provide Password"));
    } else {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("http://cadabra.in/api/app/v1/user_sign.php",
          options: Options(
              contentType: "Application/json", responseType: ResponseType.json),
          data: {
            "request_type": "login",
            "email": email,
            "password": password
          });
      if (jsonDecode(response.data.toString())["status"] == "true") {
        // SharedPreferences prefs  = await SharedPreferences.getInstance();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new HomePage()));
      } else {
        Text("");
      }
    }
  }
}
