import 'package:firebase_auth/firebase_auth.dart';

import '../providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/about_screen.dart';
import '../screens/gudelines.dart';
import '../screens/helpline_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/stats_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/watchlist_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var _isInit = true;
  var _isLoading = false;
  var _username = '';
  var _imageUrl = '';
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        FirebaseAuth.instance.currentUser().then((user) {
          _username = user.displayName;
          _imageUrl = user.photoUrl;
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        print(error);
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: const Radius.circular(30.0),
                  ),
                  color: Colors.grey[800]),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(_imageUrl)))),
                    Text(
                      "Logged in as",
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.grey[300],
                          ),
                    ),
                    Text(
                      _username,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                          fontFamily: 'Exo',
                          letterSpacing: 4),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(DashboardScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assessment),
              title: Text("Statistics"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(StatsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text("My Watchlist"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Watchlist.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.biohazard),
              title: Text("About Covid-19"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AboutPage.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Guidelines"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(GuidelinesScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.phone),
              title: Text("Helpline"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HelplineScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text("Logout"),
              onTap: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  title: Text("Are you sure?"),
                  content: Text("Click on yes to log out"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Provider.of<Auth>(context,listen: false).signOutGoogle();
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
//          Spacer(),
//          Padding(padding: EdgeInsets.all(20),child: Text('Made with ❤ by Shresth'))
          ],
        ),
      ),
    );
  }
}
