import 'dart:ffi';

class User{
  String _id;
  String _userName;
  String _email;
  String _password;
  String _urlImage;

   User({
    required String id,
    required String userName,
    required String email,
    required String password,
    required String urlImage,
  })  : _id = id, 
        _userName = userName,
        _email = email,
        _password = password,
        _urlImage = urlImage;


  String getId() => _id;

  String getUserName() => _userName;
  

  String getEmail() => _email;
  

  String _getPassword() => _password;

  String getUrlImage() => _urlImage;


  bool checkPassword(String inputPassword){
    if (inputPassword == _getPassword()){
      return true;
    } else{
      return false;
    }
  }

} 




