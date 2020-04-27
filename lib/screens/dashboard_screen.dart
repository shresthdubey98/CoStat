import '../screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../providers/stats_provider.dart';
import '../widgits/app_drawer.dart';
import '../widgits/caseCounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "/test-screen";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
        // print(error);
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final stateData = Provider.of<Statistics>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<Statistics>(context, listen: false)
                  .fetchAndSetStates();
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Setting up the dashboard...',
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.teal[10],
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height) *
                        0.5,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 10),
                              child: ConstrainedBox(
                                constraints: new BoxConstraints(
                                  minHeight: 20,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.55,
                                ),
                                child: Text(
                                  "Covid 19 Cases in India",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Graduate'),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Last updated',
                                    style: TextStyle(
                                      fontFamily: 'Graduate',
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    '${DateTime.now().difference(stateData.lastUpdateTime).inMinutes} min ago',
                                    style: TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Container(
                          width: double.infinity,
                          height: (MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height) *
                              0.35,
                          child: GridView(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 4 / 2.5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            children: <Widget>[
                              CaseCounter("CONFIRMED", stateData.totalConfirmed,
                                  Colors.red[800], Colors.red[100]),
                              CaseCounter("ACTIVE", stateData.totalActive,
                                  Colors.blue[800], Colors.blue[100]),
                              CaseCounter("RECOVERED", stateData.totalRecovered,
                                  Colors.green[800], Colors.green[100]),
                              CaseCounter("DECEASED", stateData.totalDead,
                                  Colors.grey[600], Colors.grey[300]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, StatsScreen.routeName);
                  },
                  child: AnimatedCircularChart(
                    edgeStyle: SegmentEdgeStyle.flat,
                    holeLabel: "  Click to get\nlive statistics",
                    duration: Duration(seconds: 3),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Exo',
                        fontSize: 18,
                        letterSpacing: 2),
                    startAngle: 0,
                    size: const Size(250.0, 250.0),
                    initialChartData: [
                      CircularStackEntry(
                        <CircularSegmentEntry>[
                          new CircularSegmentEntry(
                            double.parse(stateData.totalConfirmed.toString()),
                            Colors.red[200],
                            rankKey: 'Q1',
                          ),
                          new CircularSegmentEntry(
                              double.parse(stateData.totalActive.toString()),
                              Colors.blue[200],
                              rankKey: 'Q3'),
                          new CircularSegmentEntry(
                              double.parse(stateData.totalDead.toString()),
                              Colors.grey[500],
                              rankKey: 'Q4'),
                          new CircularSegmentEntry(
                              double.parse(stateData.totalRecovered.toString()),
                              Colors.green[200],
                              rankKey: 'Q2'),
                        ],
                      )
                    ],
                    chartType: CircularChartType.Radial,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Source of info.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Text(
                  'www.covid19india.org',
                  style: TextStyle(
                    color: Colors.teal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
    );
  }
}
