import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        width: 270,
        height: 360,
        color: Color(0XFFFFFFFF),
      ),
    ),
  ));
  runApp(Background());
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Color(0XFF213644),
    ));
  }
}
