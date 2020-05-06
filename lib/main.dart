import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//https://www.woolha.com/tutorials/flutter-create-custom-icon  use this to import characters as icons
// directory for git C:/Users/bking/Documents/Programming/Dart/AndroidStudio/messaging_app


void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
'/home': (context) => Home(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List <IconData> characters = [];
  List output = [[]];

  void setCharacter(input) {
    characters.add(input);
    output[output.length-1].add(input); // ads input character to this new list
    if ((characters.length) % 11 == 0) {output.add([]);} //creates a new empty list inside outputs for every set of 11 characters



  }

  void clear(){
    output = [[]];
    characters = [];
  }

  void send(){
    for (var i = 0; i <= characters.length-1; i++){
      print(translate(characters[i].toString()));
  }
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


  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[




          //texting box
          Container(
            color: Colors.redAccent,
            height: data.size.height * .3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(scrollDirection: Axis.vertical,itemCount: output.length,itemBuilder:(context, index1) {
                      return
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(data.size.width*.2,0,20,0),
                              child: Container(
                                height:40,
                                color: Colors.redAccent,
                                child: ListView.builder(scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    itemCount: output[index1].length,
                                    itemBuilder: (context, index2) {
                                      return Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(characters[index2]), //input from right to left
                                      );
                                    }),
                              ),
                            ),
                          ],
                        );
                    }),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          // First row of buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (){setState(() {
                setCharacter(Icons.arrow_downward);
              });}, icon: Icon(Icons.arrow_downward, color: Colors.white70,), label: Text("Down",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
              FlatButton.icon(onPressed: (){setState(() {
                setCharacter(Icons.arrow_upward);
              });}, icon: Icon(Icons.arrow_upward, color: Colors.white70,), label: Text("Up",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
              FlatButton.icon(onPressed: (){setState(() {
                setCharacter(Icons.arrow_back);
              });}, icon: Icon(Icons.arrow_back, color: Colors.white70,), label: Text("Left",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
              FlatButton.icon(onPressed: (){setState(() {
                setCharacter(Icons.arrow_forward);
              });}, icon: Icon(Icons.arrow_forward, color: Colors.white70,), label: Text("Right",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
            ],
          ),

          // Second row of buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (){setState(() {
                clear();
              });}, icon: Icon(Icons.clear, color: Colors.white70,), label: Text("Clear",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
              FlatButton.icon(onPressed: (){setState(() {
                send();
              });}, icon: Icon(Icons.send, color: Colors.white70,), label: Text("Send",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
            ],
          ),
        ],
      )
    );
  }
}


