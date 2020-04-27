import '../providers/stats_provider.dart';
import '../widgits/state_view_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<Statistics>(context, listen: false)
          .fetchAndSetWatchlistStateIds(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong!"),
            );
          } else {
            return Consumer<Statistics>(
              builder: (ctx, statData, ch) {
                return statData.watchlist.length != 0
                    ? ListView.builder(
                        itemBuilder: (ctx, index) =>
                            Dismissible(
                              key: ValueKey(statData.getStates[index].id),
                              background: Container(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                color: Theme.of(context).errorColor,
                                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                              ),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (diriction) {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text('Do you want to delete this entry.'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('NO'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop(true);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onDismissed: (direction) {
                                Provider.of<Statistics>(context, listen: false).deleteFromWatchlist(statData.watchlist[index].id);
                              },
                              child: StateViewCard(statData.watchlist[index]),
                            ),
                        itemCount: statData.watchlist.length,
                      )
                    : Center(
                        child: Text(
                          "Your watchlist is empty !\nPlease add items to display",
                          style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                      );
              },
            );
          }
        }
      },
    );
  }
}
