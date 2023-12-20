import 'dart:ffi';

class Account {
  String? _id;
  String _userName;
  String? _email;
  String _urlImage;
  String? _pswd;

  Account(
      {String? id,
      required String userName,
      String? email,
      required String urlImage,
      String? pswd})
      : _id = id,
        _pswd = pswd,
        _userName = userName,
        _email = email,
        _urlImage = urlImage;

  String? getId() => _id;

  String getUsername() => _userName;

  void setUsername(String value) => {_userName = value};

  String? getEmail() => _email;

  void setEmail(String value) => {_email = value};

  String getUrlImage() => _urlImage;

  void setUrlImage(String value) => {_urlImage = value};

  String? getPswd() => _pswd;

  void setPswd(String value) => {_pswd = value};
}
