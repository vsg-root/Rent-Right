import 'package:flutter/material.dart';
import 'retrieve.dart';

void main() => runApp(const Myapp());

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent-Right',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const RetrievePage(),
    );
  }
}
