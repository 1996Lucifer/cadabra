import 'package:cadabra/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/reusable_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0, count;
  bool isLoggedIn;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    // getCredentials();
    setCredentials();
    super.initState();
  }

  setCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setInt("showIntroductionScreen", 1);
    });
  }

  showDialogBoxForLogout(BuildContext context) {
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
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              setState(() {
                sharedPreferences.setBool("isLoggedIn", false);
                sharedPreferences.setInt("showIntroductionScreen", 1);
              });
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Login()),
              );
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialogBoxForLogout(context) ?? false;
  }

  getFunctionBasedOnBottomNavigation() {
    switch (_selectedIndex) {
      case 0:
        return Center(
          child: Text("No status yet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        );
        break;
      case 1:
        return SingleChildScrollView(
            child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                  height: 300,
                  child: Card(
                    child: Text("Status"),
                    elevation: 5,
                  )),
              SizedBox(
                  height: 300,
                  child: Card(
                    child: Text("booking system"),
                    elevation: 5,
                  ))
            ],
          ),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Cadabra Dashboard"),
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture:
                      Image.asset("assets/images/account_logo.png"),
                  accountName:
                      Text("Name", style: TextStyle(color: Colors.white)),
                  accountEmail:
                      Text("Email ID", style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.user),
                          onPressed: () => null,
                        ),
                        Text(
                          'About Us',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.copyright),
                          onPressed: () => null,
                        ),
                        Text(
                          'Disclaimer',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.creditCard),
                          onPressed: () => null,
                        ),
                        Text(
                          'Payment History',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.lock),
                          onPressed: () => null,
                        ),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.handshake),
                          onPressed: () => null,
                        ),
                        Text(
                          'Social Media',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.share),
                          onPressed: () => null,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.signOutAlt),
                          onPressed: () => showDialogBoxForLogout(context),
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  onTap: () {
                    showDialogBoxForLogout(context);
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: getFunctionBasedOnBottomNavigation(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 10,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
            // type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.security, color: Colors.black),
                title: Text(
                  'Security',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.security, color: Colors.black),
                title: Text(
                  'Safety',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          // floatingActionButton: new FloatingActionButton(
          //   backgroundColor: Colors.white,
          //   child: Icon(Icons.add, color: Colors.black),
          //   onPressed: () {},
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
        ));
  }
}
