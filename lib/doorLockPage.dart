import 'package:flutter/material.dart';

class DoorLockPage extends StatefulWidget {

  bool activate = true;
  String? text, description, buttonText;

  @override
  State<DoorLockPage> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends State<DoorLockPage> {
  @override
  Widget build(BuildContext context) {
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
}

