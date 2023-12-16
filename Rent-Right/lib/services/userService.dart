import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_interface/models/user.dart';

class UserService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    await _usersCollection.add({
      'userName': user.getUserName(),
      'email': user.getEmail(),
      'urlImage' : user.getUrlImage()
    });
  }

  Stream<List<User>> getUsers() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return User(
          id: doc.id,
          userName: doc['userName'],
          password: '****',
          email: doc['email'],
          urlImage: doc['urlImage'], // Corrigir para 'urlImage'
        );
      }).toList();
    });
  }



Future<void> updateUser(User user) async {
  await _usersCollection.doc(user.getId()).update({
    'userName' : user.getUserName(),
    'email' : user.getEmail(),
    'urlImage': user.getUrlImage(),
  });
}


Future<void> deleteUser (String userId) async {
  await _usersCollection.doc(userId).delete();
}

}