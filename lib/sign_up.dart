import 'dart:convert';

import 'package:cadabra/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'utils/reusable_widgets.dart';
import 'utils/constants.dart' as constants;

class Register extends StatefulWidget {
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController,
      lastNameController,
      emailController,
      mobileController,
      passwordController,
      confirmPasswordController;

  final GlobalKey<FormState> _register = new GlobalKey<FormState>();

  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  String _imagePathList, _base64Image;
  int count = -1;

  @override
  void initState() {
    firstNameController = new TextEditingController();
    lastNameController = new TextEditingController();
    emailController = new TextEditingController();
    mobileController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
    super.initState();
  }

  // Future<void> _choose() async {
  //   var file = await ImagePicker.pickImage(source: ImageSource.camera);
  //   switch (file) {
  //     case null:
  //       Text("");
  //       break;
  //     default:
  //       setState(() {
  //         _imagePathList = file.path;
  //         _base64Image = base64Encode(file.readAsBytesSync());
  //         print(_base64Image);
  //       });
  //   }
  // }

  // Future<void> _chooseFromGallery() async {
  //   var file = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   switch (file) {
  //     case null:
  //       Text("");
  //       break;
  //     default:
  //       setState(() {
  //         _imagePathList = file.path;
  //         _base64Image = base64Encode(file.readAsBytesSync());
  //         print(_base64Image);
  //       });
  //   }
  // }

  void registerAction(String fname, String lname, String email, String mob,
      String password) async {
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post("http://cadabra.in/api/app/v1/user_sign.php", data: {
      "request_type": "registration",
      "fname": fname,
      "lname": lname,
      "email": email,
      "contact": mob,
      "password": password
    });
    // print(response.data.toString());
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => new Login()));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(constants.registerAppBar),
      automaticallyImplyLeading: false,
    );

    final firstNameField = TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: constants.firstName,
          hintText: constants.firstName),
      controller: firstNameController,
      keyboardType: TextInputType.emailAddress,
      // validator: firstNameValidator,
    );

    final lastNameField = TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: constants.lastName,
          hintText: constants.lastName),
      controller: lastNameController,
      keyboardType: TextInputType.text,
    );

    final mobileNumberField = TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: constants.mobileNumber,
          hintText: constants.mobileNumberHintText,
          counterText: ""),
      controller: mobileController,
      keyboardType: TextInputType.number,
      // validator: mobileValidator,
      maxLength: 10,
    );

    final emailTextField = TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: constants.emailLabelText,
          hintText: constants.emailHintText),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // validator: emailValidator,
    );

    final passwordDecoration = InputDecoration(
        border: OutlineInputBorder(),
        labelText: constants.passwordLabelText,
        hintText: constants.passwordHintText,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? (Icons.visibility_off) : (Icons.visibility),
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ));

    final passwordTextField = TextFormField(
      decoration: passwordDecoration,
      controller: passwordController,
      keyboardType: TextInputType.text,
      // validator: passwordValidator,
      obscureText: _passwordVisible,
    );

    final confirmPasswordDecoration = InputDecoration(
        border: OutlineInputBorder(),
        labelText: constants.confirmPasswordLabelText,
        hintText: constants.confirmPasswordHintText,
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible
                ? (Icons.visibility_off)
                : (Icons.visibility),
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ));

    final confirmPasswordTextField = TextFormField(
      decoration: confirmPasswordDecoration,
      controller: confirmPasswordController,
      keyboardType: TextInputType.text,
      // validator: passwordValidator,
      obscureText: _confirmPasswordVisible,
    );

    final profileImage = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: new Stack(fit: StackFit.loose, children: <Widget>[
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 150.0,
                height: 160.0,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage("assets/images/cadabra_logo_new.png"))))
          ],
        ),
        // Padding(
        //     // padding: EdgeInsets.only(top: 90.0, left: 100.0),
        // child: new Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     new CircleAvatar(
        //         backgroundColor: Colors.red,
        //         radius: 25.0,
        //         child: GestureDetector(
        //           child: Icon(
        //             Icons.camera_alt,
        //             color: Colors.white,
        //           ),
        //           onTap: () {
        //             showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return AlertDialog(
        //                     title: Text('Choose From..'),
        //                     content: Column(
        //                         mainAxisSize: MainAxisSize.min,
        //                         crossAxisAlignment:
        //                             CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           GestureDetector(
        //                             child: Row(
        //                               children: <Widget>[
        //                                 IconButton(
        //                                   icon: Icon(Icons.camera_alt),
        //                                   onPressed: () {
        //                                     _choose();
        //                                     Navigator.of(context).pop();
        //                                   },
        //                                 ),
        //                                 Text(" Capture from camera")
        //                               ],
        //                             ),
        //                             onTap: () {
        //                               _choose();
        //                               Navigator.of(context).pop();
        //                             },
        //                           ),
        //                           GestureDetector(
        //                             child: Row(
        //                               children: <Widget>[
        //                                 IconButton(
        //                                   icon: Icon(Icons.image),
        //                                   onPressed: () {
        //                                     _chooseFromGallery();
        //                                     Navigator.of(context).pop();
        //                                   },
        //                                 ),
        //                                 Text(" Choose from gallery")
        //                               ],
        //                             ),
        //                             onTap: () {
        //                               _chooseFromGallery();
        //                               Navigator.of(context).pop();
        //                             },
        //                           ),
        //                         ]),
        //                   );
        //                 });
        //           },
        //         )),
        // //   ],
        // )),
      ]),
    );

    final registerButton = Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            String patttern = r'(^\d{3}\d{3}\d{4}$)';
            String emailPattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

            RegExp regExp = new RegExp(patttern);
            RegExp regEmailExp = new RegExp(emailPattern);

            if (firstNameController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("First Name Field can't be left blank"));
            } else if (lastNameController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("Last Name Field can't be left blank"));
            } else if (mobileController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("Mobile field can't be left blank"));
            } else if (mobileController.text.trim().length < 10) {
              ReusableWidgets.showDialogBox(
                  context, Text("Number should not be less than 10 digits"));
            } else if (!regExp.hasMatch(mobileController.text.trim())) {
              ReusableWidgets.showDialogBox(
                  context, Text("Only digits allowed"));
            } else if (emailController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("Email field can't be left blank"));
            } else if (!regEmailExp.hasMatch(emailController.text.trim())) {
              ReusableWidgets.showDialogBox(
                  context, Text("Email format is not correct"));
            } else if (passwordController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("Password can't be left blank"));
            } else if (confirmPasswordController.text.trim() == "") {
              ReusableWidgets.showDialogBox(
                  context, Text("Confirm password field can't be left blank"));
            } else if (passwordController.text !=
                confirmPasswordController.text) {
              ReusableWidgets.showDialogBox(
                  context, Text('Password do not match'));
            } else {
              registerAction(
                  firstNameController.text.trim(),
                  lastNameController.text.trim(),
                  mobileController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim());
            }
          },
          // color: Colors.pink[1000],
          child: Text('REGISTER',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );

    final loginLink = FlatButton(
      child: Text(constants.loginLink),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => new Login()));
      },
    );

    final scrollView = SingleChildScrollView(
      child: Form(
        key: _register,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            profileImage,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            firstNameField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            lastNameField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            mobileNumberField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            emailTextField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            passwordTextField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            confirmPasswordTextField,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            registerButton,
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Text(constants.loginText),
            loginLink
          ],
        ),
      ),
    );

    final body = Container(
      padding: EdgeInsets.all(20.0),
      child: scrollView,
    );

    final main = Scaffold(
      // appBar: appBar,
      body: body,
    );
    return main;
  }
}
