import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';

import './screens/about_screen.dart';
import './screens/gudelines.dart';
import './screens/helpline_screen.dart';
import './screens/login_page.dart';
import './screens/main_screen.dart';
import './screens/dashboard_screen.dart';
import './screens/watchlist_screen.dart';
import './screens/citys_screen.dart';
import './screens/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/stats_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(value: Statistics())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Color(0xFFC7356B),
            fontFamily: 'Lato',
          ),
          home: Scaffold(
            body: DoubleBackToCloseApp(
              child: MainScreen(),
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
            ),
          ),
          routes: {
            AboutPage.routeName: (ctx) => AboutPage(),
            StatsScreen.routeName: (ctx) => StatsScreen(),
            CityScreen.routeName: (ctx) => CityScreen(),
            Watchlist.routeName: (ctx) => Watchlist(),
            LoginPage.routeName: (ctx) => LoginPage(),
            DashboardScreen.routeName: (ctx) => DashboardScreen(),
            GuidelinesScreen.routeName: (ctx) => GuidelinesScreen(),
            HelplineScreen.routeName: (ctx) => HelplineScreen(),
          },
        ),
      ),
    );
  }
}
