//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:messagingapp/Home/loading.dart';
//import 'package:messagingapp/Models/constants.dart';
//import 'package:messagingapp/Services/auth.dart';
//import 'dart:async';
//
//class Home extends StatefulWidget {
//  String user;
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//  List <IconData> characters = [];
//  List output = [[]];
//  final AuthService _auth = AuthService();
//  ScrollController _controller = ScrollController();
//  ScrollController scrollcontrol = ScrollController();
//  final Firestore _firestore = Firestore.instance;
//
//
////---------------Useful Functions---------------------------------------------
//
//  void setCharacter(input) {
//    characters.add(input);
//    output[output.length-1].add(input); // ads input character to this new list
//    if ((characters.length) % 17 == 0) {output.add([]);} //creates a new empty list inside outputs for every set of 11 characters
//  }
//
//  void clear(){
//    output = [[]];
//    characters = [];
//  }
//
//  Future<void> send() async{
//    for (var i = 0; i <= characters.length-1; i++){
//      print(translate(characters[i].toString()));
//    }
//    _firestore.collection('messages').add({
//      'from': 'email@email.com',    // todo: put real email =>  widget.user.email
//      'text': characters.toString(),
//    });
//    scrollcontrol.animateTo(scrollcontrol.position.maxScrollExtent, curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
//    characters = [];
//    output = [[]];
//  }
//
//  //translate from icondata to text
//  translate(x){
//    if (x == "IconData(U+0E5DB)"){return "Down";}
//    if (x == "IconData(U+0E5D8)"){return "Up";}
//    if (x == "IconData(U+0E5C4)"){return "Left";}
//    if (x == "IconData(U+0E5C8)"){return "Right";}
//    else {return "Error";}
//  }
////----------------end useful functions ---------------------------------------
//
//
//
//
//
//  @override
//
//  Widget build(BuildContext context) {
//    Timer(Duration(milliseconds: 100), () => _controller.jumpTo(_controller.position.maxScrollExtent));
//    final data = MediaQuery.of(context);
//    return Scaffold(
//        backgroundColor: Colors.blueGrey[900],
//        appBar: AppBar(
//          title: Text("MESSΔGE", style: TextStyle(color: Colors.white70),),
//          backgroundColor: Colors.blueGrey[800],
//          elevation: 2.0,
//          actions: <Widget>[
//            FlatButton.icon(icon: Icon(Icons.person_outline, color: Colors.white70,), label: Text("Logout", style: TextStyle(color: Colors.white70),),
//              onPressed: () async {
//                await _auth.signOut();
//              }, )
//          ],
//        ),
//        body:
//        Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//
//            //texting box (should put in own widget later)
//            Container(
//              height: data.size.height * .3,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//
//                  //show older messages
//                  Expanded(
//                    child: StreamBuilder<QuerySnapshot>(
//                      stream: _firestore.collection('messages').snapshots(),
//                      builder: (context, snapshot) {
//                        if (!snapshot.hasData)
//                          return Loading();
//                        List<DocumentSnapshot> docs = snapshot.data.documents;
//                        List<Widget> messages = docs.map((doc)=>OldMessages(
//                          from: doc.data['from'],
//                          text: doc.data['text'],
//                          me: true,
////                              me: widget.user.email = doc.data['from'];
//                        )).toList();
//
//                        return ListView(
//                          controller: scrollcontrol,
//                          children: <Widget>[
//                            ... messages,
//                          ],
//                        );
//                      },
//                    ),
//                  ),
//
//                  //inputting message
//                  Expanded(
//                    child: Container(
//                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
//                      color: Colors.white70,
//                      child: ListView.builder(controller: _controller,scrollDirection: Axis.vertical, itemCount: output.length,itemBuilder:(context, index1) {
//                        return
//                          Column(
//                            children: <Widget>[
//                              Padding(
//                                padding: EdgeInsets.fromLTRB(data.size.width*.2,0,20,0),
//                                child: Container(
//                                  height:40,
//                                  color: Colors.cyan[600],
//                                  child: Padding(
//                                    padding: const EdgeInsets.all(10.0),
//                                    child: ListView.builder(scrollDirection: Axis.horizontal,
//                                        reverse: true,
//                                        itemCount: output[index1].length,
//                                        itemBuilder: (context, index2) {
//                                          return Icon(output[index1][index2], size: 17,);
//                                        }),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          );
//                      }),
//                    ),
//                  )
//                ],
//              ),
//            ),
//            SizedBox(height: 20,),
//            // First row of buttons
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                FlatButton.icon(onPressed: (){setState(() {
//                  setCharacter(Icons.arrow_downward);
//                });}, icon: Icon(Icons.arrow_downward, color: Colors.white70,), label: Text("Down",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//                FlatButton.icon(onPressed: (){setState(() {
//                  setCharacter(Icons.arrow_upward);
//                });}, icon: Icon(Icons.arrow_upward, color: Colors.white70,), label: Text("Up",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//                FlatButton.icon(onPressed: (){setState(() {
//                  setCharacter(Icons.arrow_back);
//                });}, icon: Icon(Icons.arrow_back, color: Colors.white70,), label: Text("Left",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//                FlatButton.icon(onPressed: (){setState(() {
//                  setCharacter(Icons.arrow_forward);
//                });}, icon: Icon(Icons.arrow_forward, color: Colors.white70,), label: Text("Right",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//              ],
//            ),
//
//            // Second row of buttons
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                FlatButton.icon(onPressed: (){setState(() {
//                  clear();
//                });}, icon: Icon(Icons.clear, color: Colors.white70,), label: Text("Clear",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//                FlatButton.icon(onPressed: (){setState(() {
//                  send();
//                });}, icon: Icon(Icons.send, color: Colors.white70,), label: Text("Send",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
//              ],
//            ),
//          ],
//        )
//    );
//  }
//}
//
//
