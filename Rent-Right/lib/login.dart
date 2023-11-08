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
        backgroundColor: Color(0XFF213644),
        body: Container(
          // MAIN FRAME
          padding: const EdgeInsets.only(
            top: 100,
            left: 50,
            right: 50,
            bottom: 100,
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
                                      minWidth: 275, minHeight: 362),
                                  padding: const EdgeInsets.only(
                                    top: 55,
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.50, -0.87),
                                      end: Alignment(-0.5, 0.87),
                                      colors: [
                                        Color(0xBFBEBEBE),
                                        Color(0xFCD9D9D9)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    shadows: const [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFD9D9D9)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: double.infinity,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0xFF0E2433)),
                                                  child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      child: SvgPicture.asset(
                                                        'assets/img/user.svg',
                                                        width: 100.0,
                                                        height: 100.0,
                                                      ))),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a username';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          192, 0, 0, 0),
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Username',
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            192, 0, 0, 0),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFD9D9D9)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: double.infinity,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0xFF0E2433)),
                                                  child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      child: SvgPicture.asset(
                                                        'assets/img/pswd.svg',
                                                        width: 22.03,
                                                        height: 30.0,
                                                      ))),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a password';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: true,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          192, 0, 0, 0),
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Senha',
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            192, 0, 0, 0),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 25,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'esqueceu a senha?',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w200,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                              clipBehavior: Clip.antiAlias,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFF0E2433)),
                                                overlayColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return const Color
                                                          .fromARGB(
                                                          255, 28, 71, 100);
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                // Validate returns true if the form is valid, or false otherwise.
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // If the form is valid, display a snackbar. In the real world,
                                                  // you'd often call a server or save the information in a database.
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content:
                                                            Text('Welcome!')),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'Login ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w200,
                                                  height: 0,
                                                ),
                                              )),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                              clipBehavior: Clip.antiAlias,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFF0E2433)),
                                                overlayColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return const Color
                                                          .fromARGB(
                                                          255, 28, 71, 100);
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                // Validate returns true if the form is valid, or false otherwise.
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // If the form is valid, display a snackbar. In the real world,
                                                  // you'd often call a server or save the information in a database.
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content:
                                                            Text('Welcome!')),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'Sign Up ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w200,
                                                  height: 0,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )))
                        ]),
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
                              decoration: const ShapeDecoration(
                                color: Color(0xFF0E2433),
                                shape: CircleBorder(),
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
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
