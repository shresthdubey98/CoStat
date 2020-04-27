import '../widgits/watchlist_button.dart';
import 'package:flutter/cupertino.dart';
import '../providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatelessWidget {
  static const routeName = "/city-screen";
  @override
  Widget build(BuildContext context) {
    final stateId = ModalRoute.of(context).settings.arguments;
    final stateData = Provider.of<Statistics>(context).findStateById(stateId);
    print('id added to watchlist: $stateId');
    return Scaffold(
      appBar: AppBar(
        title: Text(stateData.name),
        actions: <Widget>[
          WatchlistButton(stateId)
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Text(
              "DISTRICT",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            trailing: Text(
              "CONFIRMED",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height) *
                0.85,
            child: ListView.builder(
              itemBuilder: (ctx, index) => ListTile(
                leading: Text(
                  stateData.cityList[index].name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                trailing: Text(
                  stateData.cityList[index].confirmed.toString() + "  ",
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.redAccent),
                ),
              ),
              itemCount: stateData.cityList.length,
            ),
          ),
        ],
      ),
    );
  }
}
