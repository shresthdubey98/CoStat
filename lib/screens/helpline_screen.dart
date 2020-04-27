import '../widgits/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplineScreen extends StatelessWidget {
  static const routeName = '/helpline-screen';

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  callPhone(String phone) async {
    final phoneUrl = "tel:$phone";
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpline"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "HELPLINE NUMBERS [BY STATE]",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => launchUrl(
                  "HTTPS://WWW.MOHFW.GOV.IN/CORONVAVIRUSHELPLINENUMBER.PDF"
                      .toLowerCase()),
              child: Text(
                "HTTPS://WWW.MOHFW.GOV.IN/CORONVAVIRUSHELPLINENUMBER.PDF",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[800],
                  fontFamily: 'Exo',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Text(
              "OTHER HELPFUL LINKS",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "MINISTRY OF HEALTH AND FAMILY WELFARE, GOV. OF INDIA",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => launchUrl("HTTPS://WWW.MOHFW.GOV.IN/".toLowerCase()),
              child: Text(
                "HTTPS://WWW.MOHFW.GOV.IN/",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[800],
                  fontFamily: 'Exo',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "WHO : COVID-19 HOME PAGE",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => launchUrl(
                  "HTTPS://WWW.WHO.INT/EMERGENCIES/DISEASES/NOVEL-CORONAVIRUS-2019"
                      .toLowerCase()),
              child: Text(
                "HTTPS://WWW.WHO.INT/EMERGENCIES/DISEASES/NOVEL-CORONAVIRUS-2019",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[800],
                  fontFamily: 'Exo',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "CDC",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => launchUrl(
                  "HTTPS://WWW.CDC.GOV/CORONAVIRUS/2019-NCOV/FAQ.HTML"
                      .toLowerCase()),
              child: Text(
                "HTTPS://WWW.CDC.GOV/CORONAVIRUS/2019-NCOV/FAQ.HTML",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[800],
                  fontFamily: 'Exo',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "COVID-19 GLOBAL TRACKER",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontFamily: 'Exo',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => launchUrl(
                  "HTTPS://CORONAVIRUS.THEBASELAB.COM/".toLowerCase()),
              child: Text(
                "HTTPS://CORONAVIRUS.THEBASELAB.COM/",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[800],
                  fontFamily: 'Exo',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            callPhone("+91-11-23978046");
        },
        label: Text(
          "CALL HELPLINE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.phone),
      ),
    );
  }
}
