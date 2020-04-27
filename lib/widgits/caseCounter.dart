import 'package:flutter/material.dart';

class CaseCounter extends StatelessWidget {
  final String title;
  final int cases;
  final Color textColor;
  final Color bgColor;


  CaseCounter(this.title,this.cases, this.textColor, this.bgColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: bgColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "$title",
              style: Theme.of(context).textTheme.subhead.copyWith(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Exo',
                  fontWeight: FontWeight.w700),
            ),
            Text(
              cases!=0?"$cases":'-',
              style: Theme.of(context).textTheme.headline.copyWith(
                  color: textColor,
                  fontSize: 20,
                  fontFamily: 'Exo',
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}
