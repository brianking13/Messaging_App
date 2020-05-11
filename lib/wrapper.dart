import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Authenticate/authenticate.dart';
import 'package:messagingapp/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:messagingapp/Models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate
    if (user == null) {
      return Authenticate();
    }
    else{
      return HomeTime(user: user);
    }
  }
}
