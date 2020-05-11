import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

final textInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.white70),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.cyan[600], width: 2.0),
      borderRadius: BorderRadius.circular(0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.cyan[600],width: 1.0),
      borderRadius: BorderRadius.circular(0.0),
    )
);




// used for displaying messages
class OldMessages extends StatelessWidget {
  final String from;
  final String characters; // this will be the output from home.dart, not the characters list from home.dart
  final bool me;



  OldMessages({Key key, this.from, this.characters, this.me});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var text = json.decode(characters);
    final data = MediaQuery.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(from, style: TextStyle(color: Colors.white70),),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Material(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(0.0),
                elevation: 0.0,
                child: Container(
                  width: data.size.width * .8,
                  color: me ? Colors.cyan[600] : Colors.white70,
                  child: ListView.builder(controller: _controller,scrollDirection: Axis.vertical, itemCount: text.length,itemBuilder:(context, index1) {
                    return
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20,0,20,0),
                            child: Container(
                              height:30,
                              child: ListView.builder(scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  itemCount: text[index1].length,
                                  itemBuilder: (context, index2) {
//                                        return Icon(text[index1][index2], size: 17,);
                                  return Icon(IconData(text[index1][index2], fontFamily: 'MaterialIcons'), size: 17,);

                                  }),
                            ),
                          ),
                        ],
                      );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
