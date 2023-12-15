import 'package:flutter/material.dart';

import 'package:iot_android/signInController.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardHome extends StatefulWidget {
  String? text, description, buttonText, name, year, cardID;
  int? index;

  CardHome({super.key});
  // CardHome({required this.name, required this.year});

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {

  final dbr = FirebaseDatabase.instance.ref();
  bool? activated;

  @override
  Widget build(BuildContext context) {

    // findtheUser(FirebaseAuth.instance.currentUser?.uid);

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
                    widget.name = cardData['userInfo']['userName'];
                    widget.year = cardData['userInfo']['year'];
                    widget.index = data.indexOf(cardData);
                    // widget.cardID = cardData['cardID'];

                    activated = cardData['isActivated'];
                    if(activated == true){
                      widget.text = "active";
                      widget.buttonText = "Deactivate";
                      widget.description = "if your card is lost, tap on the deactivate button below to deactivate your card";
                    }else{
                      widget.text = "inactive";
                      widget.buttonText = "Activate";
                      widget.description = "to activate your card again, please tap on the actiate button below";
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
                                            Text('${widget.name}', style: TextStyle(color: Color(0xFF53b3a3))),
                                            Text("${widget.year}", style: TextStyle(color: Colors.white)),
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
                              if(activated == false){
                                dbr.update({
                                  'cardInfo/${widget.index}/isActivated': true
                                }
                                );
                                  // dbr.child('isActivated').update(true);
                              }
                              else{
                                dbr.update({
                                  'cardInfo/${widget.index}/isActivated': false
                                }
                                );
                                  // dbr.child('cardInfo${widget.index}/isActivated').set(false);
                              }
                              // setState((){
                              //     data[widget.index!]["isActivated"] = !widget.activate;
                              //
                              // });
                            },
                            child: activated! ? Image.asset(
                              'assets/deactivate_btn.png',
                            ): Image.asset('assets/activate_btn.png'),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(20),
                            child: Text("${widget.buttonText}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: activated! ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
                          )
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
        // body: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [Color(0xFF1b254a), Color(0xFF14161e)], // Replace with your desired colors
        //     ),
        //   ),
        //   child: Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(20),
        //       child: Column(
        //         children: [
        //           Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Image.asset('assets/logo.png', width:60, height: 50),
        //                 Row(
        //                     children: [
        //                       Column(
        //                           children: [
        //                             Text('${widget.name}', style: TextStyle(color: Color(0xFF53b3a3))),
        //                             Text("${widget.year}", style: TextStyle(color: Colors.white)),
        //                           ]
        //                       ),
        //                       IconButton(
        //                           icon: Icon(Icons.account_circle, color: Colors.white, size: 45),
        //                         onPressed: (){
        //                           _showAlertDialog(context);
        //                         }
        //                       )
        //                     ]
        //                 )
        //               ]
        //           ),
        //           SizedBox(height: 30),
        //           Container(
        //             child: Column(
        //                 children: [
        //                   Text('Your Card is currently ${widget.text}!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        //                   Text('* ${widget.description}', style: TextStyle(color: Colors.white))
        //                 ]
        //             ),
        //           ),
        //           SizedBox(height: 50),
        //
        //           TextButton(
        //             onPressed: () {
        //               setState(() {
        //                 if(widget.activate == true){
        //                   widget.activate = false;
        //                 }
        //                 else{
        //                   widget.activate = true;
        //                 }
        //
        //               });
        //             },
        //             child: widget.activate ? Image.asset(
        //               'assets/deactivate_btn.png',
        //             ): Image.asset('assets/activate_btn.png'),
        //           ),
        //           Container(
        //             // padding: const EdgeInsets.all(20),
        //             child: Text("${widget.buttonText}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: widget.activate ? Color(0xFFfacbcb): Color(0xFF23bcd1))),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
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


}

