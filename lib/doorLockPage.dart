import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class DoorLockPage extends StatefulWidget {

  // bool locked = true;
  String? text, description, buttonText;
  int? index;
  int remainingSeconds = 5;

  @override
  State<DoorLockPage> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends State<DoorLockPage> {
  final dbr = FirebaseDatabase.instance.ref();
  bool? activated, doorLocked;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        body: StreamBuilder(stream: dbr.child("cardInfo").onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                // print(snapshot.data!.snapshot.value);
                List<dynamic> data = snapshot.data!.snapshot.value as List<dynamic>;

                for (var cardData in data) {
                  if(cardData['userInfo']['userID'] == FirebaseAuth.instance.currentUser!.uid){
                    print('The card ID for this user named' + cardData['userInfo']['userName'] + " is " + cardData['cardID']);
                    widget.index = data.indexOf(cardData);
                    // widget.cardID = cardData['cardID'];

                    doorLocked = !(cardData['isRemotelyOpened']);
                    if(doorLocked == true){
                      widget.text = "Locked";
                      widget.buttonText = "Unlock";
                      // widget.description = "if your card is lost, tap on the deactivate button below to deactivate your card";
                    }else{
                      widget.text = "Unlocked";
                      widget.buttonText = "Lock";
                      // widget.description = "to activate your card again, please tap on the actiate button below";
                    }
                  }
                }

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF1b254a), Color(0xFF14161e)], // Replace with your desired colors
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                                children: [
                                  Text('Door ${widget.text}!', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: doorLocked! ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
                                  SizedBox(height: 30),
                                  doorLocked!
                                      ? Icon(Icons.lock, size: 150, color: Colors.white)  : Icon(Icons.lock_open, size: 150, color: Colors.white)
                                  // Text('${widget.description}', style: TextStyle(color: Colors.white))
                                ]
                            ),
                          ),
                          SizedBox(height: 20),

                          Visibility(
                            visible: !(doorLocked!),
                            child: Column(
                              children: [
                                Text('Time Remaining:', style: TextStyle(color: Colors.white, fontSize: 40)) ,
                                Text('${widget.remainingSeconds}', style: TextStyle(color: Colors.white, fontSize: 40)),
                              ],
                            ),
                          ),

                          SizedBox(height: 50),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                  dbr.update({
                                    'cardInfo/${widget.index}/isRemotelyOpened': true
                                  });
                                  widget.remainingSeconds = 5;

                                  _startCountdown();
                              },
                              child: doorLocked!
                                  ? Text('Unlock the door', style: TextStyle(fontSize: 20))
                                  : Text('Lock the door', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          // Container(
                          //   // padding: const EdgeInsets.all(20),
                          //   child: Text("${widget.buttonText}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: widget.locked ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
                          // )
                        ],
                      ),
                    ),
                  ),
                );

              }
              else {
                return Container();
              }
            }
        ),
      ),
    );
  }

  void _startCountdown() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      setState(() {
        widget.remainingSeconds--;
      });

      if (widget.remainingSeconds == 0) {
        timer.cancel();
        dbr.update({
          'cardInfo/${widget.index}/isRemotelyOpened': false
        });
      }
    });
  }
}



