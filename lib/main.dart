import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Home/home.dart';
import 'package:messagingapp/Services/auth.dart';
import 'package:messagingapp/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:messagingapp/Models/user.dart';
//https://www.woolha.com/tutorials/flutter-create-custom-icon  use this to import characters as icons
// directory for git C:/Users/bking/Documents/Programming/Dart/AndroidStudio/messaging_app


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.cyan[600], accentColor: Colors.cyan, cursorColor: Colors.cyan[600]),
        home: Wrapper()
      ),
    );
  }
}





