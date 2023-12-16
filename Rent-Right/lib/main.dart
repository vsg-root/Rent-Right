import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:login_interface/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent-Right',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const LoginPage(),
    );
  }
}
