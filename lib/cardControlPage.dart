import 'package:flutter/material.dart';

import 'package:iot_android/signInController.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardHome extends StatefulWidget {
  bool activate = true;
  String? text, description, buttonText;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {

  DatabaseReference ref = FirebaseDatabase.instance.ref("cardInfo");


  @override
  Widget build(BuildContext context) {

    findtheUser(FirebaseAuth.instance.currentUser?.uid);

    if(widget.activate == true){
      widget.text = "active";
      widget.buttonText = "Deactivate";
      widget.description = "if your card is lost, tap on the deactivate button below to deactivate your card";
    }else{
      widget.text = "inactive";
      widget.buttonText = "Activate";
      widget.description = "to activate your card again, please tap on the actiate button below";
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/logo.png', width:60, height: 50),
                        Row(
                            children: [
                              Column(
                                  children: [
                                    Text('Phoe Thar Htoo', style: TextStyle(color: Color(0xFF53b3a3))),
                                    Text("2nd Year", style: TextStyle(color: Colors.white)),
                                  ]
                              ),
                              IconButton(
                                  icon: Icon(Icons.account_circle, color: Colors.white, size: 45),
                                onPressed: (){
                                  _showAlertDialog(context);
                                }
                              )
                            ]
                        )
                      ]
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Column(
                        children: [
                          Text('Your Card is currently ${widget.text}!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('* ${widget.description}', style: TextStyle(color: Colors.white))
                        ]
                    ),
                  ),
                  SizedBox(height: 50),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        if(widget.activate == true){
                          widget.activate = false;
                        }
                        else{
                          widget.activate = true;
                        }

                      });
                    },
                    child: widget.activate ? Image.asset(
                      'assets/deactivate_btn.png',
                    ): Image.asset('assets/activate_btn.png'),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(20),
                    child: Text("${widget.buttonText}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: widget.activate ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out?'),
          // content: Text('This is a sample alert message.'),
          actions: [
            Container(
              color: Colors.red,
              child: TextButton(
                child: Text('Log Out', style: TextStyle(color: Colors.white)),
                onPressed: (){
                  SignOutController signOut = new SignOutController();
                  signOut.signOut();
                  Navigator.pop(context);
                }
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void findtheUser(String? userID) {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('cardInfo');

    usersRef.onValue.listen((event) {
      for (final child in event.snapshot.children) {
        if(child.child('userInfo').child('userID').value == userID){
          Map<dynamic, dynamic> userCardInfo= child.value as Map<dynamic, dynamic>;
          print(userCardInfo);
          // return child.value;
        }
        // print(child.child('userInfo').child('userID').value);
      }
    });
  }

}

