import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:iot_android/doorLockPage.dart';
import 'package:iot_android/cardControlPage.dart';

class HomePage extends StatelessWidget {
  final dbr = FirebaseDatabase.instance.ref();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
            children: [
              CardHome(),
              DoorLockPage(),
            ]
        ),
        bottomNavigationBar: Container(
          color: Color(0xFF14161e),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TabBar(
              indicatorColor: Colors.green,
                tabs: [
                  Tab(child: Icon(Icons.power_settings_new_sharp, size: 40, color: Colors.white)),
                  Tab(child: Icon(Icons.lock_outline, size: 40, color: Colors.white)),
                ]
            ),
          ),
        ),
      ),
    );
  }
}


