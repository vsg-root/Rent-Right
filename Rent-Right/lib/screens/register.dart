import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/services/userService.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService(); // Instância do UserService

  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Column(
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
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(height: 50),
                                    _buildInputField(
                                      'assets/img/email.svg',
                                      'Email',
                                      TextInputType.emailAddress,
                                      (value) {
                                        return _validateNotEmpty(
                                            value, 'Please enter an email');
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    _buildInputField(
                                      'assets/img/user.svg',
                                      'Username',
                                      TextInputType.text,
                                      (value) {
                                        return _validateNotEmpty(
                                            value, 'Please enter a username');
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    _buildInputField(
                                      'assets/img/pswd.svg',
                                      'Password',
                                      TextInputType.visiblePassword,
                                      (value) {
                                        return _validateNotEmpty(
                                            value, 'Please enter a password');
                                      },
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildInputField(
                                      'assets/img/pswd.svg',
                                      'Confirm Password',
                                      TextInputType.visiblePassword,
                                      (value) {
                                        return _validateNotEmpty(value,
                                            'Please confirm your password');
                                      },
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildElevatedButton(
                                        'Sign Up', _submitForm),
                                    const SizedBox(height: 20),
                                    _buildElevatedButton(
                                        'Login', () => Navigator.pop(context)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // WHITE FRAME IMG
                  _buildWhiteFrameImage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String assetPath,
    String hintText,
    TextInputType keyboardType,
    String? Function(String?) validator, {
    bool obscureText = false,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Color(0xFF0E2433)),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: SvgPicture.asset(
                assetPath,
                width: 30.98,
                height: 31.0,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  // Atualiza o valor do campo correspondente conforme o usuário digita
                  if (hintText == 'Email') {
                    _email = value;
                  } else if (hintText == 'Username') {
                    _username = value;
                  } else if (hintText == 'Password') {
                    _password = value;
                  } else if (hintText == 'Confirm Password') {
                    _confirmPassword = value;
                  }
                });
              },
              validator: validator,
              keyboardType: keyboardType,
              obscureText: obscureText,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                color: Color.fromARGB(192, 0, 0, 0),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
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

  Widget _buildElevatedButton(String label, void Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
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
          label,
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

  Widget _buildWhiteFrameImage() {
    return Container(
      width: 105,
      height: 105,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.white),
      ),
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF0E2433),
              shape: BoxShape.circle,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: SvgPicture.asset(
              'assets/img/signup.svg',
              width: 62.0,
              height: 45.16,
            ),
          ),
        ],
      ),
    );
  }

  String? _validateNotEmpty(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match!'),
          ),
        );
        return;
      }

      print(_email);
      print(_username);
      print(_password);

      Account newUser = Account(
        email: _email.trim(),
        userName: _username,
        urlImage:
            'https://www.pngfind.com/pngs/m/664-6644794_png-file-windows-10-person-icon-transparent-png.png',
        pswd: _password,
      );

      try {
        await _userService.addUser(newUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating account: $e'),
          ),
        );
      }
    }
  }
}
