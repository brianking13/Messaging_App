import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white70,
          size: 70.0,
        ),
      ),
    );
  }
}
