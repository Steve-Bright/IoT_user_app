import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:iot_android/loginScreen.dart';
import 'package:iot_android/home.dart';
// import 'package:iot_android/testPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return HomePage();
            }
            else{
              return MyLogin();
            }
          },
        )
    );
  }
}