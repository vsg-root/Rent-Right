import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RetrievePage extends StatefulWidget {
  const RetrievePage({Key? key}) : super(key: key);

  @override
  State<RetrievePage> createState() => _RetrievePage();
}

class _RetrievePage extends State<RetrievePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 110, horizontal: 50),
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 275,
                            minHeight: 362,
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 55, 20, 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.50, -0.87),
                              end: Alignment(-0.5, 0.87),
                              colors: [Color(0xBFBEBEBE), Color(0xFCD9D9D9)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1F000000),
                                blurRadius: 6,
                                offset: Offset(7.50, 8),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildInputField(
                                    'assets/img/email.svg',
                                    'Email',
                                    TextInputType.emailAddress,
                                    _emailController,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'assets/img/user.svg',
                                    'Username',
                                    TextInputType.text,
                                    _usernameController,
                                  ),
                                  const SizedBox(height: 50),
                                  _buildElevatedButton('Retrieve Password', () {
                                    _submitForm(context);
                                  }),
                                  const SizedBox(height: 20),
                                  _buildElevatedButton(
                                      'Back', () => Navigator.pop(context)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildWhiteFrameImage(),
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
    TextEditingController controller,
  ) {
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
              alignment: Alignment.center,
              child: SvgPicture.asset(
                assetPath,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
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
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF0E2433),
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/img/retrieve.svg',
              width: 49.21,
              height: 41.64,
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_emailController.text.isEmpty && _usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 54, 54),
          content: Text('Please fill at least one of the fields!'),
        ),
      );
    } else {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A password redefinition email has been sent to you!'),
        ),
      );
    }
  }
}
