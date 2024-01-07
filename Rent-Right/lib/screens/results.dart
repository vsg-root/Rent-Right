import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/models/Account.dart';
import 'package:login_interface/services/searchService.dart';
import 'package:login_interface/services/userService.dart';

import 'profile.dart';

class ResultsPage extends StatefulWidget {
  final PredefinedSearch result;
  final bool? isSaved;
  final String? id;
  const ResultsPage({Key? key, required this.result, this.isSaved, this.id}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ResultsPage> createState() => _ResultsPageState(result: result, isSaved: isSaved, id: id);
}

class _ResultsPageState extends State<ResultsPage> {
  final SearchService _searchService = SearchService();
  final UserService _userService = UserService();

  bool _isSaved;
  PredefinedSearch _result;
  String _id;

  _ResultsPageState(
      {required PredefinedSearch result, bool? isSaved, String? id})
      : _result = result,
        _isSaved = isSaved ?? false,
        _id = id ?? '';

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    minimumSize: const Size(132, 49),
    padding: const EdgeInsets.symmetric(horizontal: 16),
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
        child: Column(
          children: [
            buildHeader(context),
            const SizedBox(height: 54),
            buildBody(),
            const SizedBox(height: 54),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 199,
            height: 31.16,
            child: Text(
              'Rent Right',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(0, 255, 255, 255),
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/img/user.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Column(
        children: [
          buildCurrentSearch(),
          const SizedBox(height: 58),
          buildPredefinedSearches(),
        ],
      ),
    );
  }

  Widget buildCurrentSearch() {
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
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset(
                  'assets/img/dollar-coin.svg',
                  width: 70,
                  height: 70.0,
                ),
              ),
              const SizedBox(width: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'The predicted value was',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  const Text(
                    'US\$ 1,750.00',
                    style: TextStyle(
                      color: Color(0xFF31546B),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    '${_result.type.name} - ${_result.region}',
                    style: const TextStyle(
                      color: Color.fromARGB(133, 0, 0, 0),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
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
                    _saveBtn(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameModal(
                            search: _result,
                            searchService: _searchService,
                            userService: _userService,
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            _isSaved = value.isNotEmpty;
                            _id = value;
                          });
                        }
                      });
                    }, () async {
                      await _searchService.deleteSearch(_id);
                      Account? acc = await _userService.getCurrentUser();
                      acc!.removeSearch(_id);
                      await _userService.updateUser(acc);
                      setState(() {
                        _isSaved = false;
                        _id = '';
                      });
                    }, 29)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saveBtn(void Function() saveFunction, void Function() unsaveFunction,
      double iconSize) {
    return IconButton(
        iconSize: iconSize,
        onPressed: _isSaved ? unsaveFunction : saveFunction,
        icon: Icon(Icons.favorite,
            color: _isSaved ? Colors.red : const Color.fromARGB(255, 0, 0, 0)));
  }

  Widget buildPredefinedSearchItem(double value) {
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
                  SvgPicture.asset(
                    'assets/img/dollar-coin.svg',
                    width: 35.0,
                    height: 35.0,
                  ),
                  const SizedBox(width: 11),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'US\$ ${value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF31546B),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Casa - Sacramento',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]));
  }

  Widget buildPredefinedSearches() {
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
              child: Text(
                'Prevous Searches:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    buildPredefinedSearchItem(950.00),
                    const SizedBox(height: 32),
                    buildPredefinedSearchItem(975.00),
                    const SizedBox(height: 32),
                    buildPredefinedSearchItem(1250.00),
                  ],
                ),
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Search Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
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
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    )),
              )),
        ],
      ),
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
