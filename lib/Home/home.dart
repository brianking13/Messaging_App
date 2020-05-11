import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Home/loading.dart';
import 'package:messagingapp/Models/constants.dart';
import 'package:messagingapp/Models/user.dart';
import 'package:messagingapp/Services/auth.dart';
import 'dart:async';

class HomeTime extends StatefulWidget {

  final User user;
  const HomeTime({Key key, this.user});

  @override
  _HomeTimeState createState() => _HomeTimeState();
}

class _HomeTimeState extends State<HomeTime> {
  List <IconData> characters = [];
  List output = [[]];
  final AuthService _auth = AuthService();
  ScrollController _controller = ScrollController();
  ScrollController scrollcontrol = ScrollController();
  final Firestore _firestore = Firestore.instance;


//---------------Useful Functions---------------------------------------------

  void setCharacter(input) {
    characters.add(input);
    output[output.length-1].add(input.codePoint); // ads input character to this new list
    if ((characters.length) % 18 == 0) {output.add([]);} //creates a new empty list inside outputs for every set of 11 characters
  }

  void clear(){
    output = [[]];
    characters = [];
  }

  Future<void> send() async{
//    for (var i = 0; i <= characters.length-1; i++){
//      print(translate(characters[i].toString()));
//    }
    print(output);
    _firestore.collection('messages').add({
      'from': widget.user.email,
      'characters': output.toString(),
    });
    scrollcontrol.animateTo(scrollcontrol.position.maxScrollExtent, curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    characters = [];
    output = [[]];
  }

  //translate from icondata to text
  translate(x){
    if (x == "IconData(U+0E5DB)"){return "Down";}
    if (x == "IconData(U+0E5D8)"){return "Up";}
    if (x == "IconData(U+0E5C4)"){return "Left";}
    if (x == "IconData(U+0E5C8)"){return "Right";}
    else {return "Error";}
  }
//----------------end useful functions ---------------------------------------





  @override

  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 100), () => _controller.jumpTo(_controller.position.maxScrollExtent));
    final data = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text("MESSΔGE", style: TextStyle(color: Colors.white70),),
          backgroundColor: Colors.blueGrey[800],
          elevation: 2.0,
          actions: <Widget>[
            FlatButton.icon(icon: Icon(Icons.person_outline, color: Colors.white70,), label: Text("Logout", style: TextStyle(color: Colors.white70),),
              onPressed: () async {
                await _auth.signOut();
              }, )
          ],
        ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            //texting box (should put in own widget later)
            Expanded(
              child: Container(
                color: Colors.blueGrey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //show older messages
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('messages').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Loading();
                              List<DocumentSnapshot> docs = snapshot.data.documents;
                              List<Widget> messages = docs.map((doc)=>OldMessages(
                                from: doc.data['from'],
                                characters: doc.data['characters'],
                                me: widget.user.email == doc.data['from'],
                              )).toList();

                          return ListView(
                            controller: scrollcontrol,
                            children: <Widget>[
                              ... messages,
                            ],
                          );
                        },
                      ),
                    ),

                    //inputting message
                    Container(
                      height: data.size.height*.2,
                      color: Colors.blueGrey[800],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Material(
                          color: Colors.cyan[600],
                          elevation: 2.0,
                          child: ListView.builder(controller: _controller,scrollDirection: Axis.vertical, itemCount: output.length,itemBuilder:(context, index1) {
                            return
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20,0,20,0),
                                    child: Container(
                                      height:35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ListView.builder(scrollDirection: Axis.horizontal,
                                            reverse: true,
                                            itemCount: output[index1].length,
                                            itemBuilder: (context, index2) {
                                           return Icon(IconData(output[index1][index2], fontFamily: 'MaterialIcons'), size: 17,);
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // First row of buttons
            Container(
              color: Colors.blueGrey[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(onPressed: (){setState(() {
                    setCharacter(Icons.arrow_downward);
                  });}, icon: Icon(Icons.arrow_downward, color: Colors.white70,), label: Text("Down",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                  FlatButton.icon(onPressed: (){setState(() {
                    setCharacter(Icons.arrow_upward);
                  });}, icon: Icon(Icons.arrow_upward, color: Colors.white70,), label: Text("Up",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                  FlatButton.icon(onPressed: (){setState(() {
                    setCharacter(Icons.arrow_back);
                  });}, icon: Icon(Icons.arrow_back, color: Colors.white70,), label: Text("Left",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                  FlatButton.icon(onPressed: (){setState(() {
                    setCharacter(Icons.arrow_forward);
                  });}, icon: Icon(Icons.arrow_forward, color: Colors.white70,), label: Text("Right",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                ],
              ),
            ),

            // Second row of buttons
            Container(
              color: Colors.blueGrey[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(onPressed: (){setState(() {
                    clear();
                  });}, icon: Icon(Icons.clear, color: Colors.white70,), label: Text("Clear",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                  FlatButton.icon(onPressed: (){setState(() {
                    send();
                  });}, icon: Icon(Icons.send, color: Colors.white70,), label: Text("Send",style: TextStyle(color: Colors.white70),), splashColor: Colors.cyan[600],),
                ],
              ),
            ),
          ],
        )
    );
  }
}


