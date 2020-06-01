import 'package:cadabra/home_page.dart';
import 'package:cadabra/login_page.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  static getAppBar(BuildContext context, Widget heading) {
    return AppBar(
      title: heading,
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        // new IconButton(
        // icon: new Icon(Icons.share),
        // tooltip: "Share App",
        // onPressed: () {
        //   Share.share('check out my website https://example.com');
        // }
        //   ),
        new IconButton(
            icon: new Icon(Icons.exit_to_app),
            tooltip: "Logout",
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new HomePage()),
              );
            }),
      ],
    );
  }

  static showDialogBox(BuildContext context, Widget content) {
    return showDialog(
        context: context,
        builder: (context) {
          // Future.delayed(Duration(seconds: 5), () {
          //   Navigator.of(context).pop(true);
          // });
          return AlertDialog(
              title: Text('Messaage'),
              content: content,
              actions: <Widget>[
                FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ]);
        });
  }

  static showDialogBoxForLogout(BuildContext context) {
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
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Login()),
            ),
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }
}
