import 'package:flutter/material.dart';
import 'package:login_interface/SigninPageWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  labelText: 'password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              ButtonTheme(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Enter',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  )),
                   Divider(),
              ButtonTheme(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()));
                    },
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
