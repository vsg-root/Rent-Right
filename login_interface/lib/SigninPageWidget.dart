import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPage();
}

class _SigninPage extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF213644),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              Divider(),
              TextFormField(
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Corfirm password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              ButtonTheme(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
