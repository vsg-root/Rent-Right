import 'package:flutter/material.dart';
import 'package:login_interface/screens/favorites.dart';
import 'package:login_interface/screens/properties.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/models/building.dart';
import 'package:login_interface/services/housingService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/components/DropDown.dart';
import 'package:login_interface/components/Observer.dart';
import 'package:login_interface/components/HistoryDatabase.dart';

import 'search.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database db;

  final _userService = UserService();
  final HousingService housingService = HousingService();

  String _selectedSortingOption = 'Prices';

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
                  const SizedBox(height: 30),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Rent Right,',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              FutureBuilder<Account?>(
                future: _userService.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Text(
                        'Error: ${snapshot.error ?? "No user data available"}');
                  } else {
                    final userName = snapshot.data!.userName;

                    return Text(
                      userName,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          fontWeight: FontWeight.w800),
                    );
                  }
                },
              ),
            ],
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/profile.svg',
              width: 100.0,
              height: 100.0,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: '/properties'),
                    builder: (context) => const PropertiesScreen()),
              );
              setState(() {});
            },
            iconSize: 50,
            splashRadius: 30,
          ),
        ]);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHistory(context),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Recomendations:',
            style: TextStyle(
                fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
          ),
          _buildRecomendations(context)
        ]);
  }

  Future<List<Map<String, dynamic>>> fetchHistory() async {
    final db = HistoryDatabase.instance;
    Account? user = await _userService.getCurrentUser();
    return db.queryHistory(user!.email!);
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your last search:',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        'assets/${data[0]['type']}.svg',
                        width: 32,
                        height: 32,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF06AADD),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${data[0]['type'][0].toUpperCase()}${data[0]['type'].substring(1).toLowerCase()} - ${data[0]['region']}',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text('US\$ ${data[0]['value'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800))
                          ]),
                    ]),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: const RouteSettings(name: '/favorites'),
                              builder: (context) => const FavoritesScreen()),
                        );
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 21),
                        backgroundColor: const Color(0xFF161616),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/list.svg',
                        height: 30,
                        width: 30,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRecomendations(BuildContext context) {
    TextStyle base = TextStyle(
        fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400);

    TextStyle winnerName = TextStyle(
        fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w800);

    TextStyle winnerValue = TextStyle(
        fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w400);

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sorting by:',
                      style: TextStyle(
                        color: Color(0xFF161616),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CustomDropdown<int>(
                      onChange: (String? newValue) {
                        setState(() {
                          _selectedSortingOption = newValue!;
                        });
                      },
                      dropdownButtonStyle: DropdownButtonStyle(
                        height: 49,
                        elevation: 1,
                        backgroundColor: Colors.white,
                        primaryColor: Colors.black87,
                      ),
                      dropdownStyle: DropdownStyle(
                          elevation: 1,
                          padding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(7))),
                      items: [
                        'Prices',
                        'Sizes',
                      ]
                          .asMap()
                          .entries
                          .map(
                            (item) => DropdownItem<int>(
                              value: item.key + 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.value,
                                  style: base,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      child: Text(
                        _selectedSortingOption,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF161616),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  padding: EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    'assets/heart.svg',
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
            FutureBuilder<List<Building>>(
              future: housingService.getAllBuildings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Building> buildings = snapshot.data ?? [];
                  Map<String, List<Building>> buildingsByState =
                      _groupBuildingsByState(buildings);

                  List<MapEntry<String, double>> sortedStates;
                  if (_selectedSortingOption == 'Prices') {
                    Map<String, double> averagePricesByState =
                        _calculateAveragePricesByState(buildingsByState);
                    sortedStates =
                        _sortStatesByAveragePrice(averagePricesByState);
                  } else {
                    Map<String, double> averageSizesByState =
                        _calculateAverageSizesByState(buildingsByState);
                    sortedStates =
                        _sortStatesByAverageSize(averageSizesByState);
                  }
                  print(sortedStates);
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < 5 && i < sortedStates.length; i++)
                          Column(
                            children: [
                              Row(children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: Text(
                                      sortedStates[i].key,
                                      style: i == 0 ? winnerName : base,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Text(
                                      _selectedSortingOption == 'Prices'
                                          ? 'US\$ ${sortedStates[i].value.toStringAsFixed(2)}'
                                          : '${sortedStates[i].value.round()}ft²',
                                      style: i == 0 ? winnerValue : base,
                                    ),
                                  ),
                                ),
                              ]),
                              if (i < 5 && i < sortedStates.length)
                                const SizedBox(height: 10)
                            ],
                          )
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ));
  }

  Map<String, List<Building>> _groupBuildingsByState(List<Building> buildings) {
    Map<String, List<Building>> result = {};

    for (var building in buildings) {
      if (!result.containsKey(building.state.fullName)) {
        result[building.state.fullName] = [];
      }
      result[building.state.fullName]!.add(building);
    }

    return result;
  }

  Map<String, double> _calculateAveragePricesByState(
      Map<String, List<Building>> buildingsByState) {
    Map<String, double> result = {};

    for (var state in buildingsByState.keys) {
      final buildings = buildingsByState[state]!;
      final totalPrices = buildings
          .map((building) => building.price)
          .reduce((value, element) => value + element);
      final averagePrice = totalPrices / buildings.length;
      result[state] = averagePrice;
    }

    return result;
  }

  List<MapEntry<String, double>> _sortStatesByAveragePrice(
      Map<String, double> averagePricesByState) {
    List<MapEntry<String, double>> sortedStates =
        averagePricesByState.entries.toList();
    sortedStates.sort((a, b) => b.value.compareTo(a.value));
    return sortedStates;
  }

  Map<String, double> _calculateAverageSizesByState(
      Map<String, List<Building>> buildingsByState) {
    Map<String, double> result = {};

    for (var state in buildingsByState.keys) {
      final buildings = buildingsByState[state]!;
      final totalSizes = buildings
          .map((building) => building.size)
          .reduce((value, element) => value + element);
      final averageSize = totalSizes / buildings.length;
      result[state] = averageSize;
    }

    return result;
  }

  List<MapEntry<String, double>> _sortStatesByAverageSize(
      Map<String, double> averageSizesByState) {
    List<MapEntry<String, double>> sortedStates =
        averageSizesByState.entries.toList();
    sortedStates.sort((a, b) => b.value.compareTo(a.value));
    return sortedStates;
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: const RouteSettings(name: '/profile'),
                      builder: (context) => const ProfileScreen()),
                );
                setState(() {});
              },
              iconSize: 32,
              splashRadius: null,
            ),
          ),
          Material(
            color: const Color(0xFF161616),
            child: Container(
              child: SvgPicture.asset(
                'assets/home-active.svg',
                height: 64,
                width: 64,
              ),
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: const RouteSettings(name: '/search'),
                      builder: (context) => SearchScreen()),
                );
                setState(() {});
              },
              iconSize: 32,
              splashRadius: null,
            ),
          ),
        ]));
  }

  void _logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Retorna para a tela anterior após o logout
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }
}
