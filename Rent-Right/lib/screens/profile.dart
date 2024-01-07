import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/screens/search.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/models/predefinedSearch.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userService = UserService();
  final _searchService = SearchService();
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    minimumSize: const Size(132, 49),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: FutureBuilder<Account?>(
          future: _userService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text(
                  'Error: ${snapshot.error ?? "No user data available"}');
            } else {
              final imageUrl = snapshot.data!.getUrlImage();
              final userName = snapshot.data!.getUsername();
              final email = snapshot.data!.getEmail() ?? 'email';
              final searches = snapshot.data!.getSearches();

              return Column(
                children: [
                  buildTitle(),
                  const SizedBox(height: 54),
                  buildUserInfo(imageUrl, userName, email, searches),
                  const SizedBox(height: 54),
                  buildFooter(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 199,
            height: 31.16,
            child: Text(
              'Rent Right',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo(
      String imageUrl, String userName, String email, List searches) {
    return Expanded(
      child: Column(
        children: [
          buildUserProfile(imageUrl, userName, email),
          const SizedBox(height: 58),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Predefined Searches:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: Icon(color: Colors.white, Icons.add_circle_outline))
            ],
          ),
          buildPredefinedSearches(searches),
        ],
      ),
    );
  }

  Widget buildUserProfile(String imageUrl, userName, email) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 10,
            offset: Offset(2, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Color(0xFF31546B),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13.83,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 29,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _editBtn(
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()),
                        ),
                    29)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editBtn(void Function() onTap, double iconSize) {
    return IconButton(
        iconSize: iconSize,
        onPressed: onTap,
        icon: const Icon(Icons.create_rounded,
            color: Color.fromARGB(255, 0, 0, 0)));
  }

  Widget _addBtn(void Function() onTap, double iconSize) {
    return IconButton(
        iconSize: iconSize,
        onPressed: onTap,
        icon: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)));
  }

  Widget buildPredefinedSearchItem(String id, PredefinedSearch search) {
    return Container(
        width: 250,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          shadows: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 5.99,
              offset: Offset(1.20, 1.80),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    search.type == BuildingType.house
                        ? Icons.home_rounded
                        : (search.type == BuildingType.apartment
                            ? Icons.apartment
                            : Icons.store),
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 35,
                  ),
                  const SizedBox(width: 11),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${search.name}',
                        style: TextStyle(
                          color: Color(0xFF31546B),
                          fontSize: 14.37,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      Text(
                        "${search.type.name[0].toUpperCase()}${search.type.name.substring(1).toLowerCase()}- ${search.region}",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w200,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 18,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _editBtn(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(id: id, search: search)));
                      setState(() {});
                    }, 18)
                  ],
                ),
              ),
            ]));
  }

  Widget buildPredefinedSearches(List searches) {
    return Flexible(
      child: SizedBox(
        width: 304,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 24,
            ),
            Container(
              height: 8,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                    itemCount: searches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder<PredefinedSearch?>(
                              future: _searchService.getSearch(searches[index]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError ||
                                    snapshot.data == null) {
                                  return Text(
                                      'Error: ${snapshot.error ?? "No user data available"}');
                                } else {
                                  return buildPredefinedSearchItem(
                                      searches[index], snapshot.data!);
                                }
                              }));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 132,
              height: 49,
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PasswordConfirmationModal();
                    },
                  );
                },
                child: const Text('Delete Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      height: 0,
                    )),
              )),
          SizedBox(
              width: 132,
              height: 49,
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      height: 0,
                    )),
              )),
        ],
      ),
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
      title: Text('Confirmação de Senha'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
            onChanged: (value) {
              pswd = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o modal
          },
        ),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              AuthCredential credential = EmailAuthProvider.credential(
                  email: user.email!, password: pswd);

              try {
                await user.reauthenticateWithCredential(credential);

                Account? acc = await _userService.getCurrentUser();
                List idList = acc!.getSearches();
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
