import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/components/HistoryDatabase.dart';

import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/components/CustomCheckbox.dart';
import 'package:login_interface/components/CustomRadio.dart';
import 'package:login_interface/components/Observer.dart';
import 'package:login_interface/components/NumericInput.dart';
import 'package:login_interface/screens/favorites.dart';
import 'package:login_interface/screens/profile.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/models/buildingType.dart';
import 'package:login_interface/models/Account.dart';

import 'dart:math';

class SearchScreen extends StatefulWidget {
  final String? id;
  bool? isSaved;
  bool? editing;
  final PredefinedSearch? search;
  SearchScreen({Key? key, this.editing, this.isSaved, this.id, this.search})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService searchService = SearchService();
  final UserService userService = UserService();
  late String _id = widget.id ?? "";
  late PredefinedSearch? _search = widget.search;

  late BuildingType _buildType =
      _id.isNotEmpty ? _search!.type : BuildingType.house;
  late int _sizeValue = _id.isNotEmpty ? _search!.size : 500;
  late int _nBedroomsValue = _id.isNotEmpty ? _search!.nBedrooms : 1;
  late int _nBathroomsValue = _id.isNotEmpty ? _search!.nBathrooms : 1;

  late bool _allowCatsValue =
      _id.isNotEmpty ? _search!.permissions["cats"] ?? false : false;
  late bool _allowDogsValue =
      _id.isNotEmpty ? _search!.permissions["dogs"] ?? false : false;
  late bool _allowSmokingValue =
      _id.isNotEmpty ? _search!.permissions["smoking"] ?? false : false;
  late bool _hasElectricVehicleChargeValue = _id.isNotEmpty
      ? _search!.accommodations["electric-vehicle-charge"] ?? false
      : false;
  late bool _hasWheelchairAccessValue = _id.isNotEmpty
      ? _search!.accommodations["wheelchair-access"] ?? false
      : false;
  late bool _comesFurnishedValue = _id.isNotEmpty
      ? _search!.accommodations["comes-furnished"] ?? false
      : false;

  late final TextEditingController _regionController =
      TextEditingController(text: _id.isNotEmpty ? _search!.region : "");

  double value = 0;
  final _formKey = GlobalKey<FormState>();

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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 30),
                        _buildBody(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 130),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your prediction:',
                              style: TextStyle(
                                color: Color(0xFF161616),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                          Text('US\$ ${value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ))
                        ],
                      ),
                      _saveBtn(() {
                        PredefinedSearch predefSearch = _search ??
                            PredefinedSearch(
                                region: _regionController.text,
                                type: _buildType,
                                size: _sizeValue,
                                nBedrooms: _nBedroomsValue,
                                nBathrooms: _nBathroomsValue,
                                allowCats: _allowCatsValue,
                                allowDogs: _allowDogsValue,
                                allowSmoking: _allowSmokingValue,
                                hasElectricVehicleCharge:
                                    _hasElectricVehicleChargeValue,
                                hasWheelchairAccess: _hasWheelchairAccessValue,
                                comesFurnished: _comesFurnishedValue);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameModal(
                              search: predefSearch,
                              searchService: searchService,
                              userService: userService,
                              price: value,
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              widget.isSaved = value.isNotEmpty;
                              _id = value;
                            });
                          }
                        });
                      }, () async {
                        await searchService.deleteSearch(_id);
                        Account? acc = await userService.getCurrentUser();
                        acc!.removeSearch(_id);
                        await userService.updateUser(acc);
                        setState(() {
                          widget.isSaved = false;
                          _id = '';
                        });
                      }, 36)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            _search = PredefinedSearch(
                                region: _regionController.text,
                                type: _buildType,
                                size: _sizeValue,
                                nBedrooms: _nBedroomsValue,
                                nBathrooms: _nBathroomsValue,
                                allowCats: _allowCatsValue,
                                allowDogs: _allowDogsValue,
                                allowSmoking: _allowSmokingValue,
                                hasElectricVehicleCharge:
                                    _hasElectricVehicleChargeValue,
                                hasWheelchairAccess: _hasWheelchairAccessValue,
                                comesFurnished: _comesFurnishedValue);

                            int min = 50000;
                            int max = 220000;
                            double result =
                                (min + Random().nextInt((max + 1) - min)) / 100;

                            final db = HistoryDatabase.instance;
                            Account? user = await userService.getCurrentUser();
                            List<Map<String, dynamic>> history =
                                await db.queryHistory(user!.email!);
                            if (history.isEmpty) {
                              await db.insertHistory({
                                'user': user.email!,
                                'id': _id,
                                'type': _buildType.name,
                                'region': _regionController.text,
                                'sqfeet': _sizeValue,
                                'baths': _nBathroomsValue,
                                'beds': _nBedroomsValue,
                                'comes_furnished': _comesFurnishedValue ? 1 : 0,
                                'wheelchair_access':
                                    _hasWheelchairAccessValue ? 1 : 0,
                                'electric_vehicle_charge':
                                    _hasElectricVehicleChargeValue ? 1 : 0,
                                'cats_allowed': _allowCatsValue ? 1 : 0,
                                'dogs_allowed': _allowDogsValue ? 1 : 0,
                                'smoking_allowed': _allowSmokingValue ? 1 : 0,
                                'value': result
                              });
                            } else {
                              await db.updateHistory(user.email!, {
                                'user': user.email!,
                                'id': _id,
                                'type': _buildType.name,
                                'region': _regionController.text,
                                'sqfeet': _sizeValue,
                                'baths': _nBathroomsValue,
                                'beds': _nBedroomsValue,
                                'comes_furnished': _comesFurnishedValue ? 1 : 0,
                                'wheelchair_access':
                                    _hasWheelchairAccessValue ? 1 : 0,
                                'electric_vehicle_charge':
                                    _hasElectricVehicleChargeValue ? 1 : 0,
                                'cats_allowed': _allowCatsValue ? 1 : 0,
                                'dogs_allowed': _allowDogsValue ? 1 : 0,
                                'smoking_allowed': _allowSmokingValue ? 1 : 0,
                                'value': result
                              });
                            }

                            setState(() {
                              value = result;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: const Color(0xFF161616),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Generate!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (Observer().pages.contains('/searches')) {
                              Navigator.of(context).popUntil((route) =>
                                  route.settings.name == '/favorites');
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings:
                                        const RouteSettings(name: '/favorites'),
                                    builder: (context) =>
                                        const FavoritesScreen()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
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
                      ])
                ]))),
        if (widget.editing ?? false)
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                _search = PredefinedSearch(
                    region: _regionController.text,
                    type: _buildType,
                    size: _sizeValue,
                    nBedrooms: _nBedroomsValue,
                    nBathrooms: _nBathroomsValue,
                    allowCats: _allowCatsValue,
                    allowDogs: _allowDogsValue,
                    allowSmoking: _allowSmokingValue,
                    hasElectricVehicleCharge: _hasElectricVehicleChargeValue,
                    hasWheelchairAccess: _hasWheelchairAccessValue,
                    comesFurnished: _comesFurnishedValue);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NameModalUpdate(
                        search: _search!,
                        searchService: searchService,
                        id: _id);
                  },
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.isSaved = value.isNotEmpty;
                      _id = value;
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: const Color(0xFF161616),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Update',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ])
      ],
    );
  }

  Widget _saveBtn(void Function() saveFunction, void Function() unsaveFunction,
      double iconSize) {
    return IconButton(
        iconSize: iconSize,
        onPressed: (widget.isSaved ?? false) ? unsaveFunction : saveFunction,
        icon: Icon(
            (widget.isSaved ?? false)
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: (widget.isSaved ?? false)
                ? Colors.red
                : const Color.fromARGB(255, 0, 0, 0)));
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFirstSection(context),
        const SizedBox(height: 20),
        _buildSecondSection(context),
        const SizedBox(height: 20),
        _buildThirdSection(context),
      ],
    );
  }

  Widget _buildThirdSection(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 15,
        runSpacing: 15,
        children: [
          CustomCheckbox(
              icon: 'assets/furniture.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _comesFurnishedValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _comesFurnishedValue = value!;
                });
              }),
          CustomCheckbox(
              icon: 'assets/car.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _hasElectricVehicleChargeValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _hasElectricVehicleChargeValue = value!;
                });
              }),
          CustomCheckbox(
              icon: 'assets/wheelchair.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _hasWheelchairAccessValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _hasWheelchairAccessValue = value!;
                });
              }),
          CustomCheckbox(
              icon: 'assets/bone.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _allowDogsValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _allowDogsValue = value!;
                });
              }),
          CustomCheckbox(
              icon: 'assets/smoking.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _allowSmokingValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _allowSmokingValue = value!;
                });
              }),
          CustomCheckbox(
              icon: 'assets/cat.svg',
              checkedColor: const Color(0xFF06AADD),
              value: _allowCatsValue,
              size: 45,
              onChanged: (bool? value) {
                setState(() {
                  _allowCatsValue = value!;
                });
              }),
        ]);
  }

  Widget _buildSecondSection(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: SvgPicture.asset(
                      'assets/arrow-expand.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  NumericInput(
                    minValue: 0,
                    maxValue: 100,
                    initialValue: _sizeValue ?? 500,
                    onChanged: (value) {
                      setState(() {
                        _sizeValue = value;
                      });
                    },
                  )
                ],
              )),
          Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: SvgPicture.asset(
                      'assets/bed.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  NumericInput(
                    minValue: 0,
                    maxValue: 100,
                    initialValue: _nBedroomsValue ?? 1,
                    onChanged: (value) {
                      setState(() {
                        _nBedroomsValue = value;
                      });
                    },
                  )
                ],
              )),
          Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: SvgPicture.asset(
                      'assets/shower.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  NumericInput(
                    minValue: 0,
                    maxValue: 100,
                    initialValue: _nBathroomsValue ?? 1,
                    onChanged: (value) {
                      setState(() {
                        _nBathroomsValue = value;
                      });
                    },
                  )
                ],
              ))
        ]);
  }

  Widget _buildFirstSection(BuildContext context) {
    const double unselectedSize = 30;
    const double selectedSize = 36;

    return Container(
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
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              RadioGroup<BuildingType>(
                items: const [
                  RadioItem<BuildingType>(
                    value: BuildingType.house,
                    label: '',
                    icon: 'assets/house.svg',
                    unselectedColor: Color(0xFFADADAD),
                    selectedColor: Color(0xFF06AADD),
                    unselectedHeight: unselectedSize,
                    unselectedWidth: unselectedSize,
                    selectedHeight: selectedSize,
                    selectedWidth: selectedSize,
                  ),
                  RadioItem<BuildingType>(
                    value: BuildingType.apartment,
                    label: '',
                    icon: 'assets/apartment.svg',
                    unselectedColor: Color(0xFFADADAD),
                    selectedColor: Color(0xFF06AADD),
                    unselectedHeight: unselectedSize,
                    unselectedWidth: unselectedSize,
                    selectedHeight: selectedSize,
                    selectedWidth: selectedSize,
                  ),
                  RadioItem<BuildingType>(
                    value: BuildingType.other,
                    label: '',
                    icon: 'assets/other.svg',
                    unselectedColor: Color(0xFFADADAD),
                    selectedColor: Color(0xFF06AADD),
                    unselectedHeight: unselectedSize,
                    unselectedWidth: unselectedSize,
                    selectedHeight: selectedSize,
                    selectedWidth: selectedSize,
                  ),
                ],
                value: _buildType ?? BuildingType.house,
                onSelected: (value) {
                  setState(() {
                    _buildType = value;
                  });
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: _regionController,
                  validator: (value) =>
                      _isEmpty(value, 'Please enter a Region'),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: _buildInputDeco(
                      const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      'Region',
                      'assets/region.svg'),
                ),
              )
            ])));
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
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: SvgPicture.asset(iconPath),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
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
                height: 32,
                width: 32,
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
                height: 32,
                width: 32,
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
            child: Container(
              child: SvgPicture.asset(
                'assets/coin-active.svg',
                height: 64,
                width: 64,
              ),
            ),
          ),
        ]));
  }
}

class NameModalUpdate extends StatelessWidget {
  var name = '';

  final PredefinedSearch _search;
  final SearchService _searchService;
  final String _id;

  NameModalUpdate(
      {super.key, required PredefinedSearch search,
      required SearchService searchService,
      required String id})
      : _search = search,
        _searchService = searchService,
        _id = id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Give your search a new name'),
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
          child: const Text('Confirm'),
          onPressed: () async {
            _search.name = name;

            _searchService.updateSearch(_id, _search);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Search updated successfully.'),
            ));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class NameModal extends StatelessWidget {
  var name = '';

  final PredefinedSearch _search;
  final SearchService _searchService;
  final UserService _userService;
  double price;

  NameModal(
      {super.key, required this.price,
      required PredefinedSearch search,
      required SearchService searchService,
      required UserService userService})
      : _search = search,
        _searchService = searchService,
        _userService = userService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Give your search a name'),
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
          child: const Text('Confirm'),
          onPressed: () async {
            _search.name = name;

            String id = await _searchService.addSearch(_search);
            if (id.isNotEmpty) {
              Account? acc = await _userService.getCurrentUser();
              acc!.addSearch(id);
              await _userService.updateUser(acc);

              final db = HistoryDatabase.instance;
              Account? user = await _userService.getCurrentUser();
              List<Map<String, dynamic>> history =
                  await db.queryHistory(user!.email!);
              if (history.isEmpty) {
                await db.insertHistory({
                  'user': user.email!,
                  'id': id,
                  'type': _search.type.name,
                  'region': _search.region,
                  'sqfeet': _search.size,
                  'baths': _search.nBathrooms,
                  'beds': _search.nBedrooms,
                  'comes_furnished':
                      _search.getAccommodations()['comes-furnished']! ? 1 : 0,
                  'wheelchair_access':
                      _search.getAccommodations()['wheelchair-access']! ? 1 : 0,
                  'electric_vehicle_charge':
                      _search.getAccommodations()['electric-vehicle-charge']!
                          ? 1
                          : 0,
                  'cats_allowed': _search.getPermissions()['cats']! ? 1 : 0,
                  'dogs_allowed': _search.getPermissions()['dogs']! ? 1 : 0,
                  'smoking_allowed':
                      _search.getPermissions()['smoking']! ? 1 : 0,
                  'value': price
                });
              } else {
                await db.updateHistory(user.email!, {
                  'user': user.email!,
                  'id': id,
                  'type': _search.type.name,
                  'region': _search.region,
                  'sqfeet': _search.size,
                  'baths': _search.nBathrooms,
                  'beds': _search.nBedrooms,
                  'comes_furnished':
                      _search.getAccommodations()['comes-furnished']! ? 1 : 0,
                  'wheelchair_access':
                      _search.getAccommodations()['wheelchair-access']! ? 1 : 0,
                  'electric_vehicle_charge':
                      _search.getAccommodations()['electric-vehicle-charge']!
                          ? 1
                          : 0,
                  'cats_allowed': _search.getPermissions()['cats']! ? 1 : 0,
                  'dogs_allowed': _search.getPermissions()['dogs']! ? 1 : 0,
                  'smoking_allowed':
                      _search.getPermissions()['smoking']! ? 1 : 0,
                  'value': price
                });
              }
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
