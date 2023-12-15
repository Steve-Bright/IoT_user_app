import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  // HomePage({super.key});
  String? name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbr = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Testing data "),
        backgroundColor: Colors.blue,),
      body: StreamBuilder(stream: dbr.child("cardInfo").onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              // print(snapshot.data!.snapshot.value);
              List<dynamic> data = snapshot.data!.snapshot.value as List<dynamic>;
              print(data);

              // Iterate over each card in the 'cardInfo' map
              // List<Widget> cardIDList = [];
              for (var cardData in data) {
                String cardID = cardData['cardID'];
                // print(cardData['userInfo']['year']);
                // print(FirebaseAuth.instance.currentUser!.uid);
                if(cardData['userInfo']['userID'] == FirebaseAuth.instance.currentUser!.uid){
                  print('The card ID for this user named' + cardData['userInfo']['userName'] + " is " + cardData['cardID']);
                  widget.name = cardData['userInfo']['userName'];
                }
                // if (cardID.isNotEmpty) {
                //   cardIDList.add(Text(cardID));
                // }
              }

              return Column(
                  children: [
                    Text('${widget.name}')
                  ],
                );

            }
            else {
              return Container();
            }
          }
      ),
    );
  }
}