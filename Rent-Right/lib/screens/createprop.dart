import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_interface/components/HistoryDatabase.dart';
import 'package:login_interface/models/building.dart';

import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/components/CustomCheckbox.dart';
import 'package:login_interface/components/CustomRadio.dart';
import 'package:login_interface/components/Observer.dart';
import 'package:login_interface/components/NumericInput.dart';
import 'package:login_interface/models/state.dart';
import 'package:login_interface/screens/favorites.dart';
import 'package:login_interface/screens/profile.dart';
import 'package:login_interface/screens/search.dart';
import 'package:login_interface/services/housingService.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/services/userService.dart';
import 'package:login_interface/models/buildingType.dart';
import 'package:login_interface/models/Account.dart';

import 'dart:math';

class CreatePropScreen extends StatefulWidget {
  final String? id;
  bool? isSaved;
  bool? editing;
  final Building? prop;
  CreatePropScreen({Key? key, this.editing, this.isSaved, this.id, this.prop})
      : super(key: key);

  @override
  State<CreatePropScreen> createState() => _CreatePropScreenState();
}

class _CreatePropScreenState extends State<CreatePropScreen> {
  final HousingService housingService = HousingService();
  final UserService userService = UserService();
  late String _id = widget.id ?? "";
  late Building? _prop = widget.prop;

  late BuildingType _buildType =
      _id.isNotEmpty ? _prop!.type : BuildingType.house;
  late int _sizeValue = _id.isNotEmpty ? _prop!.size : 500;
  late int _nBedroomsValue = _id.isNotEmpty ? _prop!.nBedrooms : 1;
  late int _nBathroomsValue = _id.isNotEmpty ? _prop!.nBathrooms.floor() : 1;

  late bool _allowCatsValue =
      _id.isNotEmpty ? _prop!.permissions["cats"] ?? false : false;
  late bool _allowDogsValue =
      _id.isNotEmpty ? _prop!.permissions["dogs"] ?? false : false;
  late bool _allowSmokingValue =
      _id.isNotEmpty ? _prop!.permissions["smoking"] ?? false : false;
  late bool _hasElectricVehicleChargeValue = _id.isNotEmpty
      ? _prop!.accommodations["electric-vehicle-charge"] ?? false
      : false;
  late bool _hasWheelchairAccessValue = _id.isNotEmpty
      ? _prop!.accommodations["wheelchair-access"] ?? false
      : false;
  late bool _comesFurnishedValue = _id.isNotEmpty
      ? _prop!.accommodations["comes-furnished"] ?? false
      : false;

  late final TextEditingController _regionController =
      TextEditingController(text: _id.isNotEmpty ? _prop!.region : "");

  late double price = _id.isNotEmpty ? _prop!.price.toDouble() : 0;

  late final TextEditingController _priceController =
      TextEditingController(text: price.toString());

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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Your price:',
                              style: TextStyle(
                                color: Color(0xFF161616),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('US\$',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  )),
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: _priceController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*$')),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    border: const OutlineInputBorder(),
                                  ),
                                  onSubmitted: (text) {
                                    if (text.isEmpty) {
                                      _priceController.text = '0.00';
                                    }
                                  },
                                  onChanged: (text) {
                                    if (text.isNotEmpty) {
                                      price = double.parse(text);
                                    } else {
                                      price = 0;
                                    }
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      if (widget.editing ?? false)
                        IconButton(
                            iconSize: 36,
                            onPressed: () async {
                              await housingService.deleteBuilding(_id);
                              Account? acc = await userService.getCurrentUser();
                              acc!.removePropertie(_id);
                              await userService.updateUser(acc);
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.favorite, color: Colors.red))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            _prop = Building(
                                price: price,
                                state: USState.AL,
                                region: _regionController.text,
                                type: _buildType,
                                size: _sizeValue,
                                nBedrooms: _nBedroomsValue,
                                nBathrooms: _nBathroomsValue.toDouble(),
                                allowCats: _allowCatsValue,
                                allowDogs: _allowDogsValue,
                                allowSmoking: _allowSmokingValue,
                                hasElectricVehicleCharge:
                                    _hasElectricVehicleChargeValue,
                                hasWheelchairAccess: _hasWheelchairAccessValue,
                                comesFurnished: _comesFurnishedValue);

                            if (widget.editing ?? false) {
                              housingService.updateBuilding(_id, _prop!);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Property updated successfully.'),
                              ));
                              Navigator.of(context).pop();
                            } else {
                              String id =
                                  await housingService.addBuilding(_prop!);
                              if (id.isNotEmpty) {
                                Account? acc =
                                    await userService.getCurrentUser();
                                acc!.addPropertie(id);
                                await userService.updateUser(acc);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Property saved successfully.'),
                                ));
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 54, 54),
                                    content: Text('Error saving Property.'),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: const Color(0xFF161616),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            (widget.editing ?? false) ? 'Update' : 'Save',
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
                                  route.settings.name == '/properties');
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: '/properties'),
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
                items: [
                  RadioItem<BuildingType>(
                    value: BuildingType.house,
                    label: '',
                    icon: 'assets/house.svg',
                    unselectedColor: const Color(0xFFADADAD),
                    selectedColor: const Color(0xFF06AADD),
                    unselectedHeight: unselectedSize,
                    unselectedWidth: unselectedSize,
                    selectedHeight: selectedSize,
                    selectedWidth: selectedSize,
                  ),
                  RadioItem<BuildingType>(
                    value: BuildingType.apartment,
                    label: '',
                    icon: 'assets/apartment.svg',
                    unselectedColor: const Color(0xFFADADAD),
                    selectedColor: const Color(0xFF06AADD),
                    unselectedHeight: unselectedSize,
                    unselectedWidth: unselectedSize,
                    selectedHeight: selectedSize,
                    selectedWidth: selectedSize,
                  ),
                  RadioItem<BuildingType>(
                    value: BuildingType.other,
                    label: '',
                    icon: 'assets/other.svg',
                    unselectedColor: const Color(0xFFADADAD),
                    selectedColor: const Color(0xFF06AADD),
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

class NameModalUpdate extends StatelessWidget {
  var name = '';

  PredefinedSearch _search;
  SearchService _searchService;
  String _id;

  NameModalUpdate(
      {required PredefinedSearch search,
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
