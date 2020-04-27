import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      body: Container(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 50,),
                Image(
                    image: AssetImage("assets/images/logo_red.png"),
                    height: MediaQuery.of(context).size.height * 0.22,

                ),
                Image(
                    image: AssetImage("assets/images/costat.png"),
                    width: MediaQuery.of(context).size.width * 0.5,
                    ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Get live statistics of COVID-19 Cases in India and other useful information.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline.copyWith(
                        color: Colors.grey[600], fontFamily: "Graduate"),
                  ),
                ),
                SizedBox(height: 100,),
                _signInButton(auth),
                SizedBox(height: 50,),

                Text(
                  "#stayhomestaysafe",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Colors.grey[600], fontFamily: "Graduate"),
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),

      ),
    );
  }

  Widget _signInButton(Auth auth) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        auth.signInWithGoogle().whenComplete(() {
          print("Signed in");
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/googlelogo.png"),
                height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
