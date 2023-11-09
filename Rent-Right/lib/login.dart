import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 100,
          horizontal: 50,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 275,
                            minHeight: 362,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 55,
                            horizontal: 20,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.50, -0.87),
                              end: Alignment(-0.5, 0.87),
                              colors: [Color(0xBFBEBEBE), Color(0xFCD9D9D9)],
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1F000000),
                                blurRadius: 6,
                                offset: Offset(7.50, 8),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _buildInputField(
                                  'Username',
                                  'assets/img/user.svg',
                                  TextInputType.text,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a username';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                _buildInputField(
                                  'Password',
                                  'assets/img/pswd.svg',
                                  TextInputType.visiblePassword,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),
                                _buildTextButton('Forgot your password?', () {
                                  // Add logic for "Forgot your password?" here
                                }),
                                const SizedBox(height: 20),
                                _buildElevatedButton('Login', () {
                                  _submitForm();
                                }),
                                const SizedBox(height: 20),
                                _buildElevatedButton('Sign Up', () {
                                  _submitForm();
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // WHITE FRAME IMG
                  Container(
                    width: 105,
                    height: 105,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2.50,
                          top: 2.50,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E2433),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 2.50,
                          top: 2.50,
                          child: SvgPicture.asset(
                            'assets/img/login.svg',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, String svgAsset,
      TextInputType inputType, String? Function(String?) validator,
      {bool obscureText = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: const Color(0xFF0E2433),
            ),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: SvgPicture.asset(
                svgAsset,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              validator: validator,
              keyboardType: inputType,
              obscureText: obscureText,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                color: Color.fromARGB(192, 0, 0, 0),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Color.fromARGB(192, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String buttonText, void Function() onPressed) {
    return Container(
      width: double.infinity,
      height: 25,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color.fromARGB(192, 0, 0, 0),
                fontSize: 13,
                fontStyle: FontStyle.italic,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String buttonText, void Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF0E2433)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(255, 28, 71, 100);
              }
              return null;
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w200,
            height: 0,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome!'),
        ),
      );
    }
  }
}
