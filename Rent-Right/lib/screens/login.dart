import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EEF2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildLoginForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    const inputStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            decoration: BoxDecoration(
              color: const Color(0xFFEAFAFF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildEmailField(inputStyle),
                const SizedBox(height: 20),
                _buildPasswordField(inputStyle),
                const SizedBox(height: 30),
                _buildSignUpLink(context),
                const SizedBox(height: 20),
                _buildLoginButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 156,
        height: 96,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(TextStyle inputStyle) {
    return TextFormField(
      controller: _emailController,
      validator: (value) => _isEmpty(value, 'Please enter a email'),
      keyboardType: TextInputType.emailAddress,
      style: inputStyle,
      decoration: _buildInputDeco(inputStyle, 'Email', 'assets/email.svg'),
    );
  }

  Widget _buildPasswordField(TextStyle inputStyle) {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) => _isEmpty(value, 'Please enter a password'),
      keyboardType: TextInputType.visiblePassword,
      style: inputStyle,
      decoration: _buildInputDeco(inputStyle, 'Password', 'assets/pswd.svg'),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _submitForm(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String? _isEmpty(String? value, String msg) {
    if (value == null || value.isEmpty) {
      return msg;
    }
    return null;
  }

  InputDecoration _buildInputDeco(
      TextStyle? inputStyle, String hint, String iconPath) {
    return InputDecoration(
      hintStyle: inputStyle,
      errorStyle: inputStyle,
      labelStyle: inputStyle,
      helperStyle: inputStyle,
      suffixStyle: inputStyle,
      prefixStyle: inputStyle,
      counterStyle: inputStyle,
      floatingLabelStyle: inputStyle,
      contentPadding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      hintText: hint,
      prefixIcon: Container(
        width: 48.0,
        height: 40.0,
        margin: const EdgeInsets.fromLTRB(8, 5, 10, 5),
        child: SvgPicture.asset(
          iconPath,
          width: 25.0,
          height: 25.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      print(_emailController.text);
      print(_passwordController.text);
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome!'),
          ),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong username or password!'),
          ),
        );
      }
    }
  }
}
