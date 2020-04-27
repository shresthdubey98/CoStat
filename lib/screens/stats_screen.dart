import 'package:flutter/cupertino.dart';
import '../widgits/app_drawer.dart';
import '../widgits/state_view_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stats_provider.dart';

class StatsScreen extends StatefulWidget {
  static const routeName = '/states-screen';
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Statistics>(context, listen: false)
            .fetchAndSetStates()
            .then((_) {
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

  Widget build(BuildContext context) {
    final stateData = Provider.of<Statistics>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Statistics"),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading statistics...',
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20
              ),
            ),
            SizedBox(height: 20,),
            CircularProgressIndicator(),
          ],
        ),
      )
          : RefreshIndicator(
              onRefresh: () => stateData.fetchAndSetStates(),
              child: stateData.getStates.length != 0
                  ? ListView.builder(
                      itemBuilder: (ctx, index) =>
                          StateViewCard(stateData.getStates[index]),
                      itemCount: stateData.getStates.length,
                    )
                  : Center(
                    child: IconButton(
                        icon: Icon(Icons.refresh),
                        iconSize: 40,
                        color: Colors.grey,
                        onPressed: () => stateData.fetchAndSetStates(),
                      ),
                  ),
            ),
    );
  }
}
