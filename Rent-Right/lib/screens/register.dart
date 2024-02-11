import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/services/userService.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confPswdController = TextEditingController();

  final _userService = UserService();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFE7EEF2), //Color.fromARGB(255, 163, 193, 208),
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
              color:
                  const Color(0xFFEAFAFF), //Color.fromARGB(255, 203, 224, 231),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildEmailField(inputStyle),
                const SizedBox(height: 20),
                _buildUsernameField(inputStyle),
                const SizedBox(height: 20),
                _buildPswdField(inputStyle),
                const SizedBox(height: 20),
                _buildConfPswdField(inputStyle),
                const SizedBox(height: 30),
                _buildLoginLink(context),
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
      keyboardType: TextInputType.text,
      style: inputStyle,
      decoration: _buildInputDeco(inputStyle, 'Email', 'assets/email.svg'),
    );
  }

  Widget _buildUsernameField(TextStyle inputStyle) {
    return TextFormField(
      controller: _usernameController,
      validator: (value) => _isEmpty(value, 'Please enter a username'),
      keyboardType: TextInputType.text,
      style: inputStyle,
      decoration: _buildInputDeco(inputStyle, 'Username', 'assets/user.svg'),
    );
  }

  Widget _buildPswdField(TextStyle inputStyle) {
    return TextFormField(
      obscureText: true,
      controller: _pswdController,
      validator: (value) => _isEmpty(value, 'Please enter a password'),
      keyboardType: TextInputType.visiblePassword,
      style: inputStyle,
      decoration: _buildInputDeco(inputStyle, 'Password', 'assets/pswd.svg'),
    );
  }

  Widget _buildConfPswdField(TextStyle inputStyle) {
    return TextFormField(
      obscureText: true,
      controller: _confPswdController,
      validator: (value) => _isEmpty(value, 'Please confirm your password'),
      keyboardType: TextInputType.visiblePassword,
      style: inputStyle,
      decoration: _buildInputDeco(
          inputStyle, 'Confirm Password', 'assets/conf-pswd.svg'),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
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
            Navigator.pop(context);
          },
          child: const Text(
            "Login",
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
          'Sign Up',
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
      if (_pswdController.text != _confPswdController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match!'),
          ),
        );
        return;
      }

      Account newUser = Account(
        email: _emailController.text.trim(),
        userName: _usernameController.text,
        urlImage:
            'https://www.pngfind.com/pngs/m/664-6644794_png-file-windows-10-person-icon-transparent-png.png',
        pswd: _pswdController.text,
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
