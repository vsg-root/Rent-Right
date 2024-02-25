// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/screens/search.dart';
import 'package:login_interface/components/Observer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/services/housingService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userService = UserService();
  final searchService = SearchService();
  final housingService = HousingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EEF2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 30),
                    _buildBody(context),
                    const SizedBox(height: 100),
                    Hero(
                      tag: 'footer',
                      child: _buildFooter(context),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    TextStyle title = TextStyle(
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    );

    TextStyle basic = TextStyle(
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 5),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Account?>(
          future: userService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text(
                  'Error: ${snapshot.error ?? "No user data available"}');
            } else {
              final imageUrl = snapshot.data!.urlImage;
              final userName = snapshot.data!.userName;
              final email = snapshot.data!.email ?? 'email';
              final searches = snapshot.data!.searches;

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            'User:',
                            style: title,
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                            userName,
                            style: basic,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            'Email:',
                            style: title,
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                            email,
                            style: basic,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return UsernameChangeDialog();
                        },
                      );
                      await Future.delayed(Duration(milliseconds: 1000));
                      setState(() {});
                    },
                    child: const Text(
                      "Change username",
                      style: TextStyle(
                        color: Color(0xBF161616),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  TextButton(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PasswordChangeDialog();
                        },
                      );
                    },
                    child: const Text(
                      "Change password",
                      style: TextStyle(
                        color: Color(0xBF161616),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Color(0xBFFF0000),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PasswordConfirmationModal();
                            },
                          );
                        },
                        child: const Text(
                          "Delete account",
                          style: TextStyle(
                            color: Color(0xBFFF0000),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        WhiteBtn('Clear favorites', () async {
          Account? acc = await userService.getCurrentUser();
          List<String> searches = acc!.searches;
          searches.forEach((element) async {
            await searchService.deleteSearch(element);
            acc.removeSearch(element);
          });
          await userService.updateUser(acc);
        }),
        SizedBox(
          height: 30,
        ),
        WhiteBtn('Clear my properties', () async {
          Account? acc = await userService.getCurrentUser();
          List<String> props = acc!.properties;
          props.forEach((element) async {
            await housingService.deleteBuilding(element);
            acc.removePropertie(element);
          });
          await userService.updateUser(acc);
        })
      ],
    );
  }

  Widget WhiteBtn(String text, void Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  //Widget _buildBody(BuildContext context) {}

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Material(
            color: const Color(0xFF161616),
            child: Container(
              child: SvgPicture.asset(
                'assets/cog-active.svg',
                height: 64,
                width: 64,
              ),
            ),
          ),
          Material(
            color: const Color(0xFF161616),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/home.svg',
                height: 100,
                width: 100,
              ),
              color: const Color(0xFFADADAD),
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/home');
              },
              iconSize: 32,
              splashRadius: null,
            ),
          ),
          Material(
            color: const Color(0xFF161616),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/coin.svg',
                height: 100,
                width: 100,
              ),
              color: const Color(0xFFADADAD),
              onPressed: () {
                if (Observer().pages.contains('/search')) {
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == '/search');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(name: '/search'),
                        builder: (context) => SearchScreen()),
                  );
                }
              },
              iconSize: 32,
              splashRadius: null,
            ),
          ),
        ]));
  }
}

class UsernameChangeDialog extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final _userService = UserService();
  final _searchService = SearchService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Username'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _pswdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'New Username',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_pswdController.text.isEmpty ||
                _usernameController.text.isEmpty) {
              // Verifica se algum dos campos está vazio
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all fields'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
              return;
            }

            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              AuthCredential credential = EmailAuthProvider.credential(
                  email: user.email!, password: _pswdController.text);

              try {
                await user.reauthenticateWithCredential(credential);

                Account? acc = await _userService.getCurrentUser();
                acc!.userName = _usernameController.text;
                _userService.updateUser(acc);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Username changed successfully'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wrong password'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text('Confirm'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

class PasswordChangeDialog extends StatelessWidget {
  final TextEditingController _newPswdController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final _userService = UserService();
  final _searchService = SearchService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _pswdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _newPswdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_pswdController.text.isEmpty ||
                _newPswdController.text.isEmpty) {
              // Verifica se algum dos campos está vazio
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all fields'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
              return;
            }
            if (_newPswdController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('The password must be at least 6 characters long'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
              return;
            }

            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              AuthCredential credential = EmailAuthProvider.credential(
                  email: user.email!, password: _pswdController.text);

              try {
                await user.reauthenticateWithCredential(credential);

                Account? acc = await _userService.getCurrentUser();
                acc!.pswd = _newPswdController.text;
                _userService.updateUser(acc);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wrong password'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text('Confirm'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

class PasswordConfirmationModal extends StatelessWidget {
  final _userService = UserService();
  final _searchService = SearchService();
  var pswd = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm your password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) {
              pswd = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Confirm'),
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              AuthCredential credential = EmailAuthProvider.credential(
                  email: user.email!, password: pswd);

              try {
                await user.reauthenticateWithCredential(credential);

                Account? acc = await _userService.getCurrentUser();
                List idList = acc!.searches;
                idList.forEach((element) async =>
                    await _searchService.deleteSearch(element));
                await _userService.deleteUser(user.uid);
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wrong password'),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
