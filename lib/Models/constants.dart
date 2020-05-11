import 'package:flutter/material.dart';

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
  final String text;
  final bool me;



  const OldMessages({Key key, this.from, this.text, this.me});

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(from),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: me ? Colors.white70 : Colors.greenAccent,
              borderRadius: BorderRadius.circular(0.0),
              elevation: 2.0,
              child: Container(
                width: data.size.width *.5,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
