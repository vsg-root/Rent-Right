import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 45),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 74),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: _buildOptions(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 176,
            height: 88,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29.29,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 73,
                  child: Text(
                    'How can we help you today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 28,
                  child: Text(
                    'Rent Right',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: IconButton(
                iconSize: 60,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(0, 255, 255, 255)),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage())),
                icon: SvgPicture.asset(
                  'assets/img/user.svg',
                  width: 100,
                  height: 100,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              _buildOption('Search', 'assets/img/dollar-coin.svg', () {}),
              const SizedBox(width: 32),
              _buildOption('Suggestions', 'assets/img/eyeball.svg', () {}),
            ])),
        const SizedBox(height: 32),
        Expanded(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              _buildOption('Settings', 'assets/img/cog.svg', () {}),
              const SizedBox(width: 32),
              _buildOption(
                  'Exit', 'assets/img/logout.svg', () => _logoutUser()),
            ])),
      ],
    );
  }

  void _logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Retorna para a tela anterior após o logout
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  Widget _buildOption(String btnText, String svgAsset, void Function() onTap) {
    return Expanded(
        child: Container(
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xFFD9D9D9),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgAsset,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 15),
            Text(
              btnText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0E2433),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
