import 'package:flutter/material.dart';
import 'package:login_interface/models/building.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/services/housingService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/components/Observer.dart';
import 'package:login_interface/components/HistoryDatabase.dart';

import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/screens/profile.dart';
import 'package:login_interface/screens/createprop.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/models/buildingType.dart';

import 'search.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  late Database db;

  final UserService userService = UserService();

  final HousingService housingService = HousingService();

  bool editing = false;

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
                  const SizedBox(height: 35),
                  _buildBody(context),
                  const SizedBox(height: 35),
                  Hero(
                    tag: 'footer',
                    child: _buildFooter(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: '/crateprop'),
                  builder: (context) => CreatePropScreen()),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: const Color(0xFF161616),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Create new property',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: FutureBuilder<Account?>(
              future: userService.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error ?? "No user data available"}'));
                } else {
                  return FutureBuilder<List<Map<String, Building?>>>(
                    future: getAllProperties(snapshot.data!.properties),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final searches = snapshot.data ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: searches.map((property) {
                            return _buildPropertie(
                                property.entries.first.value!,
                                property.entries.first.key);
                          }).toList(),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ]);
  }

  Widget _buildPropertie(Building property, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: ShapeDecoration(
                color: Color(0xFF161616),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${property.type.name[0].toUpperCase()}${property.type.name.substring(1).toLowerCase()} - ${property.region}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            )),
                        Text('US\$${property.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              if (property.accommodations['comes-furnished'] ??
                                  false)
                                _buidFeature(
                                  'assets/furniture.svg',
                                  35,
                                ),
                              if (property.accommodations[
                                      'electric-vehicle-charge'] ??
                                  false)
                                _buidFeature(
                                  'assets/car.svg',
                                  35,
                                ),
                              if (property
                                      .accommodations['wheelchair-access'] ??
                                  false)
                                _buidFeature(
                                  'assets/wheelchair.svg',
                                  35,
                                ),
                              if (property.permissions['dogs'] ?? false)
                                _buidFeature(
                                  'assets/bone.svg',
                                  35,
                                ),
                              if (property.permissions['smoking'] ?? false)
                                _buidFeature(
                                  'assets/smoking.svg',
                                  35,
                                ),
                              if (property.permissions['cats'] ?? false)
                                _buidFeature(
                                  'assets/cat.svg',
                                  35,
                                )
                            ],
                          ),
                          IconButton(
                              iconSize: 25,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/crateprop'),
                                      builder: (context) => CreatePropScreen(
                                          editing: true,
                                          isSaved: true,
                                          id: id,
                                          prop: property)),
                                );
                              },
                              icon: const Icon(Icons.create_rounded,
                                  color: Colors.white))
                        ])
                  ])),
        ),
        const SizedBox.shrink()
      ],
    );
  }

  Widget _buidFeature(String icon, double size) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: SvgPicture.asset(icon,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
    );
  }

  Future<List<Map<String, Building?>>> getAllProperties(
      List<String> propertiesIds) async {
    List<Map<String, Building?>> propertieList = [];

    await Future.forEach(propertiesIds, (id) async {
      final bulding = await housingService.getBuilding(id);
      propertieList.add({id: bulding});
    });

    print(propertieList);
    return propertieList;
  }

  Future<List<Map<String, dynamic>>> fetchHistory() async {
    final db = HistoryDatabase.instance;
    return db.queryAllHistory();
  }

  Widget _buildHistory(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const SizedBox();
          }
          print(data[0]['id']);
          bool isFavorited = (data[0]['id'] as String).isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create new property:',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    color: Color(0xFF161616),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [])),
            ],
          );
        }
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'My properties',
            style: const TextStyle(
                fontFamily: 'Inter', fontSize: 32, fontWeight: FontWeight.w800),
          )
        ]);
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Material(
            color: const Color(0xFF161616),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/cog.svg',
                height: 100,
                width: 100,
              ),
              color: const Color(0xFFADADAD),
              onPressed: () {
                if (Observer().pages.contains('/profile')) {
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == '/profile');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(name: '/profile'),
                        builder: (context) => const ProfileScreen()),
                  );
                }
              },
              iconSize: 32,
              splashRadius: null,
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
