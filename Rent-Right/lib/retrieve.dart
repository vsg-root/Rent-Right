import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RetrivePage extends StatefulWidget {
  const RetrivePage({super.key});

  @override
  State<RetrivePage> createState() => _RetrivePage();
}

class _RetrivePage extends State<RetrivePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF213644),
        body: Container(
          // MAIN FRAME
          padding: const EdgeInsets.only(
            top: 125,
            left: 50,
            right: 50,
            bottom: 125,
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
                                                        'assets/img/email.svg',
                                                        width: 100.0,
                                                        height: 100.0,
                                                      ))),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _emailController,
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
                                                    hintText: 'Email',
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
                                                        'assets/img/user.svg',
                                                        width: 100.0,
                                                        height: 100.0,
                                                      ))),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _usernameController,
                                                  keyboardType:
                                                      TextInputType.text,
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
                                        const SizedBox(height: 50),
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
                                                if (_usernameController
                                                        .text.isEmpty &&
                                                    _emailController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                255, 54, 54),
                                                        content: Text(
                                                            'Please fill at least one of the fields!')),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'An password redefinition email has been sent to you!')),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'Retrive Password',
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
                                              onPressed: () {},
                                              child: const Text(
                                                'Back',
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
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 2, color: Colors.white)),
                              ),
                            ),
                          ),
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: SvgPicture.asset(
                                'assets/img/retrieve.svg',
                                width: 49.21,
                                height: 41.64,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
