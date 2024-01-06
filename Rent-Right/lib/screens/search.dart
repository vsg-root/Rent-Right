import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/components/CustomCheckbox.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _regionController = TextEditingController();

  BuildingType? _buildType = BuildingType.house;
  RangeValues _sizeValues = const RangeValues(0, 1000);
  RangeValues _nBeroomsValues = const RangeValues(0, 10);
  RangeValues _nBathroomsValues = const RangeValues(0, 10);

  bool _allowCatsValue = false;
  bool _allowDogsValue = false;
  bool _allowSmokingValue = false;
  bool _hasElectricVehicleChargeValue = false;
  bool _hasWheelchairAccessValue = false;
  bool _comesFurnishedValue = false;

  final _formKey = GlobalKey<FormState>();
  final frameDeco = BoxDecoration(
    color: const Color(0xFCD9D9D9),
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Color(0x1F000000),
        blurRadius: 6,
        offset: Offset(7.50, 8),
        spreadRadius: 0,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF213644),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 10,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF213644)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height: 110,
                  constraints: const BoxConstraints(
                    minWidth: 319,
                    minHeight: 130,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: frameDeco,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInputField(
                          _regionController,
                          'Insert the Region',
                          'assets/img/magnifying-glass.svg',
                          TextInputType.text,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ListTileTheme(
                                horizontalTitleGap: -5,
                                contentPadding: const EdgeInsets.all(0),
                                child: RadioListTile<BuildingType>(
                                    activeColor:
                                        const Color.fromARGB(255, 49, 84, 107),
                                    title: const Text('House'),
                                    value: BuildingType.house,
                                    groupValue: _buildType,
                                    onChanged: (BuildingType? value) {
                                      setState(() {
                                        _buildType = value;
                                      });
                                    }),
                              ),
                            ),
                            Expanded(
                              child: ListTileTheme(
                                horizontalTitleGap: -5,
                                contentPadding: const EdgeInsets.all(0),
                                child: RadioListTile<BuildingType>(
                                    activeColor:
                                        const Color.fromARGB(255, 49, 84, 107),
                                    title: const Text('Apartment'),
                                    value: BuildingType.apartment,
                                    groupValue: _buildType,
                                    onChanged: (BuildingType? value) {
                                      setState(() {
                                        _buildType = value;
                                      });
                                    }),
                              ),
                            ),
                            Expanded(
                              child: ListTileTheme(
                                horizontalTitleGap: -5,
                                contentPadding: const EdgeInsets.all(0),
                                child: RadioListTile<BuildingType>(
                                    activeColor:
                                        const Color.fromARGB(255, 49, 84, 107),
                                    title: const Text('Other'),
                                    value: BuildingType.other,
                                    groupValue: _buildType,
                                    onChanged: (BuildingType? value) {
                                      setState(() {
                                        _buildType = value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ])),
              Container(
                  width: double.infinity,
                  height: 300,
                  constraints: const BoxConstraints(
                    minWidth: 319,
                    minHeight: 300,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: frameDeco,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildSliderWidget(
                            _sizeValues,
                            (RangeValues values) {
                              setState(() {
                                _sizeValues = values;
                              });
                            },
                            'Size',
                            105,
                            'assets/img/arrow-expand.svg',
                            0,
                            1000,
                            'ft²',
                          ),
                          _buildSliderWidget(_nBeroomsValues,
                              (RangeValues values) {
                            setState(() {
                              _nBeroomsValues = values;
                            });
                          }, 'Bedrooms', 105, 'assets/img/bed.svg', 0, 10, ''),
                          _buildSliderWidget(_nBathroomsValues,
                              (RangeValues values) {
                            setState(() {
                              _nBathroomsValues = values;
                            });
                          }, 'Bathrooms', 105, 'assets/img/shower.svg', 0, 10,
                              ''),
                        ],
                      ),
                      SizedBox(height: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildCheckBox(
                                'assets/img/cat.svg',
                                (bool? value) {
                                  setState(() {
                                    _allowCatsValue = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 50),
                              _buildCheckBox(
                                'assets/img/bone.svg',
                                (bool? value) {
                                  setState(() {
                                    _allowDogsValue = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 50),
                              _buildCheckBox(
                                'assets/img/smoking.svg',
                                (bool? value) {
                                  setState(() {
                                    _allowSmokingValue = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildCheckBox(
                                'assets/img/wheelchair.svg',
                                (bool? value) {
                                  setState(() {
                                    _hasWheelchairAccessValue = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 50),
                              _buildCheckBox(
                                'assets/img/car.svg',
                                (bool? value) {
                                  setState(() {
                                    _hasElectricVehicleChargeValue = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 50),
                              _buildCheckBox(
                                'assets/img/furniture.svg',
                                (bool? value) {
                                  setState(() {
                                    _comesFurnishedValue = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              _buildElevatedButton("Simulate", () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox(String assetPath, void Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCheckbox(size: 24, onChanged: onChanged),
        SizedBox(width: 5),
        SvgPicture.asset(
          assetPath,
          width: 30.0,
          height: 30.0,
        ),
      ],
    );
  }

  Widget _buildSliderWidget(
      RangeValues initValues,
      void Function(RangeValues) onChanged,
      String text,
      double textSize,
      String svgAsset,
      double min,
      double max,
      String unit) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SvgPicture.asset(
                svgAsset,
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
          SizedBox(
            width: textSize,
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Color(0XFF0E2433),
                inactiveTrackColor: Color(0XFFC8C4C4),
                thumbColor: Color(0xFFC2C2C2),
                valueIndicatorColor: Color(0xFFC8C8C8),
                valueIndicatorTextStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
              child: RangeSlider(
                values: initValues,
                min: min,
                max: max,
                divisions: (max.round() - min.round()),
                labels: RangeLabels(
                  '${initValues.start.round()}${unit.length > 0 ? (" " + unit) : ""}',
                  '${initValues.end.round()}${unit.length > 0 ? (" " + unit) : ""}',
                ),
                onChanged: (RangeValues values) {
                  onChanged(values);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller,
      String hintText,
      String svgAsset,
      TextInputType inputType,
      String? Function(String?) validator,
      {bool obscureText = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFC8C4C4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SvgPicture.asset(
                svgAsset,
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: inputType,
              obscureText: obscureText,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                color: Color.fromARGB(192, 0, 0, 0),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(192, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String buttonText, void Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF0E2433)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(255, 28, 71, 100);
              }
              return null;
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            height: 0,
          ),
        ),
      ),
    );
  }
}
