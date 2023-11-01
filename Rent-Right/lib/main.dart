import 'package:flutter/material.dart';
import 'package:login_interface/SigninPageWidget.dart';
import 'LoginPageWidget.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent-Right',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SigninPage(),
    );
  }
}
