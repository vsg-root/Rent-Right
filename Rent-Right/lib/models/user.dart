class User{
  String _userName;
  String _email;
  String _password;
  String _urlImage;

   User({
    required String userName,
    required String email,
    required String password,
    required String urlImage,
  })  : _userName = userName,
        _email = email,
        _password = password,
        _urlImage = urlImage;

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


void main(List<String> args) {
  User user = new User(userName: "userName", email: "email", password: "password", urlImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPQzg2-modiBeSBIckt_NcpipPPGQfZA_dbQ&usqp=CAU");
  print(user.getUserName());
  print(user.getEmail());
  print(user._getPassword());
  print(user.getUrlImage());
}


