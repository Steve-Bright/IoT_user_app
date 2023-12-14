import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:iot_android/firebase_options.dart';
import 'package:iot_android/loginScreen.dart';
import 'package:iot_android/cardControlPage.dart';
import 'package:iot_android/mainPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainPage(),
    routes: {
      'home': (context) => CardHome(),
      'login': (context) => MyLogin(),
    },
  ));
}

