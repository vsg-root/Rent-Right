class User{
  String _userName;
  String _email;
  String _password;

   User({
    required String userName,
    required String email,
    required String password,
  })  : _userName = userName,
        _email = email,
        _password = password;

  String getUserName() => _userName;
  

  String getEmail() => _email;
  

  String _getPassword() => _password;

} 


void main(List<String> args) {
  User user = new User(userName: "userName", email: "email", password: "password");
  print(user.getUserName());
  print(user.getEmail());
  print(user._getPassword());
}


