import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/services/userService.dart';

class ChangePswdPage extends StatefulWidget {
  const ChangePswdPage({Key? key}) : super(key: key);

  @override
  State<ChangePswdPage> createState() => _ChangePswdPageState();
}

class _ChangePswdPageState extends State<ChangePswdPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                  _passwordController,
                                  'Current Password',
                                  'assets/img/pswd.svg',
                                  TextInputType.visiblePassword,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),
                                _buildInputField(
                                  _newPasswordController,
                                  'new Password',
                                  'assets/img/pswd.svg',
                                  TextInputType.visiblePassword,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),
                                _buildElevatedButton('Change Password', () {
                                  _submitForm(context);
                                }),
                                const SizedBox(height: 20),
                                _buildElevatedButton('Cancel', () {
                                  Navigator.pop(context);
                                }),
                              ],
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

  Widget _buildWhiteFrameImage() {
    return SizedBox(
      width: 105,
      height: 105,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  color: Color(0xFF0E2433), shape: BoxShape.circle),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/img/login.svg',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller,
      String hintText,
      String svgAsset,
      TextInputType inputType,
      String? Function(String?) validator,
      {bool obscureText = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
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
              color: Color(0xFF0E2433),
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
              controller: controller,
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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
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

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _passwordController.text);

        try {
          await user.reauthenticateWithCredential(credential);

          Account? acc = await _userService.getCurrentUser();
          acc!.setPswd(_newPasswordController.text);

          await _userService.updateUser(acc);
          Navigator.pop(context);
          Navigator.pop(context);
        } catch (e) {
          print("ERRO: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password'),
            ),
          );
        }
      }
    }
  }
}
