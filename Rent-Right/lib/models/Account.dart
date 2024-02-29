import 'dart:ffi';

class Account {
  String? _id;
  String _userName;
  String? _email;
  String _urlImage;
  String? _pswd;
  List<String> _predefSearchs;
  List<String> _properties;

  Account(
      {String? id,
      required String userName,
      String? email,
      required String urlImage,
      String? pswd,
      List<String>? predefSearchs,
      List<String>? properties})
      : _id = id,
        _pswd = pswd,
        _userName = userName,
        _email = email,
        _urlImage = urlImage,
        _predefSearchs = predefSearchs ?? [],
        _properties = properties ?? [];

  String? get id => _id;

  String get userName => _userName;
  set userName(String value) {
    _userName = value;
  }

  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  String get urlImage => _urlImage;
  set urlImage(String value) {
    _urlImage = value;
  }

  String? get pswd => _pswd;
  set pswd(String? value) {
    _pswd = value;
  }

  List<String> get searches => _predefSearchs;

  void addSearch(String value) {
    _predefSearchs.add(value);
  }

  bool removeSearch(String value) {
    return _predefSearchs.remove(value);
  }

  List<String> get properties => _properties;

  void addPropertie(String value) {
    _properties.add(value);
  }

  bool removePropertie(String value) {
    return _properties.remove(value);
  }
}
