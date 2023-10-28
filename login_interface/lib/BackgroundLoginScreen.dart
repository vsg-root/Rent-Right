import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0XFF213644),
          body: Center(
            child: Container(
              width: 270,
              height: 360,
              color: Color(0XFFBEBEBE),
              alignment: Alignment.center,
            ),
          )),
    );
  }
}
