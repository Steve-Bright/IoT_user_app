import 'package:flutter/material.dart';
import 'dart:async';


class DoorLockPage extends StatefulWidget {

  bool locked = true;
  String? text, description, buttonText;
  int remainingSeconds = 5;

  @override
  State<DoorLockPage> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends State<DoorLockPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.locked == true){
      widget.text = "Locked";
      widget.buttonText = "Unlock";
      // widget.description = "if your card is lost, tap on the deactivate button below to deactivate your card";
    }else{
      widget.text = "Unlocked";
      widget.buttonText = "Lock";
      // widget.description = "to activate your card again, please tap on the actiate button below";
    }

    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        body: Container(
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
                          Text('Door ${widget.text}!', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: widget.locked ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
                          SizedBox(height: 30),
                          widget.locked
                          ? Icon(Icons.lock, size: 150, color: Colors.white)  : Icon(Icons.lock_open, size: 150, color: Colors.white)
                          // Text('${widget.description}', style: TextStyle(color: Colors.white))
                        ]
                    ),
                  ),
                  SizedBox(height: 20),

                  Visibility(
                    visible: !(widget.locked),
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
                        setState(() {
                          widget.locked = false;
                          widget.remainingSeconds = 5;

                          _startCountdown();
                          // Future.delayed(Duration(seconds: 5), () {
                          //   setState(() {
                          //     widget.locked = true;
                          //   });
                          // });
                        });
                      },
                      child: widget.locked
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
        setState(() {
          widget.locked = true;
        });
      }
    });
  }
}



