import '../providers/auth.dart';
import '../providers/stats_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistButton extends StatelessWidget{
  final stateId;

  WatchlistButton(this.stateId);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return IconButton(
        icon: Icon(Icons.remove_red_eye),
        onPressed: () async {
          bool isAuth =
          await Provider.of<Auth>(context, listen: false).isAuth();
          if (!isAuth) {
            scaffold.showSnackBar(
              SnackBar(
                content: Text("You need to activate watchlist first"),
              ),
            );
            return;
          }
          try {
            FirebaseUser user = await FirebaseAuth.instance.currentUser();
            await Provider.of<Statistics>(context, listen: false)
                .addToWatchlist(stateId,user.uid);
            scaffold.showSnackBar(
              SnackBar(
                content: Text("Added to your watchlist !"),
              ),
            );
          }catch(error){
            scaffold.showSnackBar(
              SnackBar(
                content: Text("Something went wrong !"),
              ),
            );
          }
        });
  }
}