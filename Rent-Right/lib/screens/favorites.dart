import 'package:flutter/material.dart';
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
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/models/buildingType.dart';

import 'search.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Database db;

  final SearchService searchService = SearchService();
  final UserService userService = UserService();

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
          _buildHistory(context),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'My saved searches:',
            style: TextStyle(
                fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
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
                  return FutureBuilder<List<Map<String, PredefinedSearch?>>>(
                    future: getAllSearches(snapshot.data!.getSearches()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final searches = snapshot.data ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: searches.map((search) {
                            return _buildSearch(search.entries.first.value!,
                                search.entries.first.key);
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

  Widget _buildSearch(PredefinedSearch search, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              padding: const EdgeInsets.all(15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${search.type.name[0].toUpperCase()}${search.type.name.substring(1).toLowerCase()} - ${search.region}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buidFeature(
                                  'assets/furniture.svg',
                                  35,
                                  search.accommodations['comes-furnished'] ??
                                      false),
                              _buidFeature(
                                  'assets/car.svg',
                                  35,
                                  search.accommodations[
                                          'electric-vehicle-charge'] ??
                                      false),
                              _buidFeature(
                                  'assets/wheelchair.svg',
                                  35,
                                  search.accommodations['wheelchair-access'] ??
                                      false),
                              _buidFeature('assets/bone.svg', 35,
                                  search.permissions['dogs'] ?? false),
                              _buidFeature('assets/smoking.svg', 35,
                                  search.permissions['smoking'] ?? false),
                              _buidFeature('assets/cat.svg', 35,
                                  search.permissions['cats'] ?? false)
                            ],
                          ),
                          IconButton(
                              iconSize: 25,
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: const RouteSettings(
                                            name: '/search'),
                                        builder: (context) => SearchScreen(
                                            editing: true,
                                            isSaved: true,
                                            id: id,
                                            search: search)),
                                  ),
                              icon: const Icon(Icons.create_rounded,
                                  color: Colors.black))
                        ])
                  ])),
        ),
        const SizedBox.shrink()
      ],
    );
  }

  Widget _buidFeature(String icon, double size, bool present) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: present ? Color(0xFF06AADD) : Color(0x1CADADAD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: SvgPicture.asset(icon,
          colorFilter: ColorFilter.mode(
              present ? Colors.white : Colors.black, BlendMode.srcIn)),
    );
  }

  Future<List<Map<String, PredefinedSearch?>>> getAllSearches(
      List<String> searchesIds) async {
    print(searchesIds);
    List<Map<String, PredefinedSearch?>> searchList = [];

    await Future.forEach(searchesIds, (id) async {
      final search = await searchService.getSearch(id);
      searchList.add({id: search});
    });

    print(searchList);
    return searchList;
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
                'Your last search:',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.all(15),
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
                    IconButton(
                        iconSize: 35,
                        onPressed: () {
                          if (isFavorited) {
                            _unfavoriteSearch(data[0]);
                          } else {
                            _favoriteSearch(data[0]);
                          }
                        },
                        icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorited ? Colors.red : Colors.black)),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void _unfavoriteSearch(Map<String, dynamic> search) async {
    if (search['id'] != null && search['id'].isNotEmpty) {
      await searchService.deleteSearch(search['id']);
      Account? acc = await userService.getCurrentUser();
      acc!.removeSearch(search['id']);
      await userService.updateUser(acc);

      Map<String, dynamic> newSearch = Map.from(search)..['id'] = '';
      await HistoryDatabase.instance.updateHistory(search['id'], newSearch);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Search removed from favorites.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error removing search from favorites: ID not found.'),
      ));
    }
  }

  void _favoriteSearch(Map<String, dynamic> search) async {
    PredefinedSearch predefSearch = PredefinedSearch(
      region: search['region'],
      type: BuildingType.values.byName(search['type']),
      size: search['sqfeet'],
      nBedrooms: search['beds'],
      nBathrooms: search['baths'],
      allowCats: search['cats_allowed'] == 1,
      allowDogs: search['dogs_allowed'] == 1,
      allowSmoking: search['smoking_allowed'] == 1,
      hasElectricVehicleCharge: search['electric_vehicle_charge'] == 1,
      hasWheelchairAccess: search['wheelchair_access'] == 1,
      comesFurnished: search['comes_furnished'] == 1,
    );

    String? id = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return NameModal(
          search: predefSearch,
          searchService: searchService,
          userService: userService,
        );
      },
    );

    if (id != null && id.isNotEmpty) {
      search = Map.from(search)..['id'] = id;
      await HistoryDatabase.instance.updateHistory('', search);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Search saved successfully.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 54, 54),
        content: Text('Error saving search.'),
      ));
    }
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
                future: userService.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Text(
                        'Error: ${snapshot.error ?? "No user data available"}');
                  } else {
                    final userName = snapshot.data!.getUsername();

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
            onPressed: () {},
            iconSize: 50,
            splashRadius: 35,
          ),
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

class NameModal extends StatelessWidget {
  var name = '';

  PredefinedSearch _search;
  SearchService _searchService;
  UserService _userService;

  NameModal(
      {required PredefinedSearch search,
      required SearchService searchService,
      required UserService userService})
      : _search = search,
        _searchService = searchService,
        _userService = userService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Give your search a name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: ''),
            obscureText: false,
            onChanged: (value) {
              name = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Confirm'),
          onPressed: () async {
            _search.name = name;

            String id = await _searchService.addSearch(_search);
            if (id.isNotEmpty) {
              Account? acc = await _userService.getCurrentUser();
              acc!.addSearch(id);
              await _userService.updateUser(acc);
            }
            Navigator.of(context).pop(id);

            if (id.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Search saved successfully.'),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromARGB(255, 255, 54, 54),
                  content: Text('Error saving search.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
