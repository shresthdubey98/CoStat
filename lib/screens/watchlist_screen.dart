import '../widgits/watchlist.dart';
import '../widgits/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatefulWidget {
  static const routeName = '/watchlist-screen';
  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {


  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Watchlist"),
      ),
      drawer: AppDrawer(),
      body: WatchlistView(),
    );
  }
}
