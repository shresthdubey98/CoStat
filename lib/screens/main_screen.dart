import '../providers/auth.dart';
import '../screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class MainScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (ctx, auth, ch)=> FutureBuilder<bool>(future: auth.isAuth(),
        builder: (ctx, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            if (snapshot.data){
              return DashboardScreen();
            }else{
              return LoginPage();
            }
          }
        },),
    );
  }
}