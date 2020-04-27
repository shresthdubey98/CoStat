import '../providers/state.dart';
import '../providers/stats_provider.dart';
import '../screens/citys_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class StateViewCard extends StatelessWidget {
  final StateData state;
  StateViewCard(this.state);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              state.name,
              style: Theme.of(context).textTheme.title,
            ),
            Divider(),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Confirmed: ',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text('Active: ',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text('Recovered: ',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text('Deceased: ',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.grey)),
                    SizedBox(height: 5),
                  ],
                ),
                VerticalDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${state.confirmed}',
                        style: Theme.of(context)
                            .textTheme
                            .subhead),
                    SizedBox(height: 5),
                    Text(state.confirmed>1?'${state.active}':" -",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.orangeAccent)),
                    SizedBox(height: 5),
                    Text(state.recovered>1?'${state.recovered}':" -",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.green)),
                    SizedBox(height: 5),
                    Text(state.deceased>1?'${state.deceased}':" -",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.red)),
                    SizedBox(height: 5),
                  ],
                ),
                Spacer(),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.pushNamed(context, CityScreen.routeName,
                          arguments: state.id);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: LinearProgressIndicator(
                    value: Provider.of<Statistics>(context, listen: false).percentById(state.id)/100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red,
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
                Text("  ${Provider.of<Statistics>(context, listen: false).percentById(state.id).toStringAsFixed(2)}%")
              ],
            )
          ],
        ),
      ),
    );
  }}
