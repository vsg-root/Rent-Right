import 'dart:ffi';

class Account {
  String? _id;
  String _userName;
  String? _email;
  String _urlImage;
  String? _pswd;
  List<dynamic> _predefSearchs;

  Account(
      {String? id,
      required String userName,
      String? email,
      required String urlImage,
      String? pswd,
      List<dynamic>? predefSearchs})
      : _id = id,
        _pswd = pswd,
        _userName = userName,
        _email = email,
        _urlImage = urlImage,
        _predefSearchs = predefSearchs ?? [];

  String? getId() => _id;

  String getUsername() => _userName;

  void setUsername(String value) => {_userName = value};

  String? getEmail() => _email;

  void setEmail(String value) => {_email = value};

  String getUrlImage() => _urlImage;

  void setUrlImage(String value) => {_urlImage = value};

  String? getPswd() => _pswd;

  void setPswd(String value) => {_pswd = value};

  List<dynamic> getSearches() => _predefSearchs;

  void addSearch(String value) {
    _predefSearchs.add(value);
  }

  bool removeSearch(String value) {
    return _predefSearchs.remove(value);
  }
}
