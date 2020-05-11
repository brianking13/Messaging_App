import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Home/loading.dart';
import 'package:messagingapp/Services/auth.dart';
import 'package:messagingapp/Models/constants.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey =  GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  Color containerColor = Colors.blueGrey[800];


  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        containerColor = Colors.blueGrey[900];
      });
    });
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        title: Text('Sign In', style: TextStyle(color: Colors.white70),),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person_add, color: Colors.white70,), label: Text('Register', style: TextStyle(color: Colors.white70),))
        ],
      ),
      body: AnimatedContainer(
        color: containerColor,
        height: data.size.height,
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: data.size.height *.2,),
                Text("MESSΔGE", style: TextStyle(fontSize: data.size.width*.125, color: Colors.white70, ),),
                SizedBox(height: 30.0,),
                TextFormField(  // update email
                  style: TextStyle(color: Colors.white70),
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(  // update password
                  style: TextStyle(color: Colors.white70),
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Password must be 6+ characters' : null,
                obscureText: true,
                  onChanged: (val){
                  setState(() {
                    password = val;
                  });
                  },
                ),
                SizedBox(height: 30.0,),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  color: Colors.cyan[600],
                  child: Text("Sign In", style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){ //only valid when it receives null from all validators in text fields
                      setState(() {
                        loading = true;});
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "Invalid Credentials";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          ),
        )
      )
    );
  }
}
