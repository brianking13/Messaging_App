import 'package:flutter/material.dart';

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
  String character = "None";

  setCharacter(input){
    character = input;
    return character;
  }

  printCharacter(){
    return character;
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
          FlatButton.icon(onPressed: (){setState(() {
              setCharacter('C');
          });}, icon: Icon(Icons.keyboard, color: Colors.white70,), label: Text("Touch",style: TextStyle(color: Colors.white70),), splashColor: Colors.redAccent,),
          SizedBox(height: 20,),
          Container(
            color: Colors.redAccent,
            height: data.size.height * .3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(printCharacter())
              ],
            ),
          ),
        ],
      )
    );
  }
}
