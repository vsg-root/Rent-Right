import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_interface/models/Account.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUser(Account acc) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: acc.getEmail() ?? '',
      password: acc.getPswd() ?? '',
    );

    String userId = userCredential.user?.uid ?? '';

    await _firestore.collection('users').doc(userId).set({
      'username': acc.getUsername(),
      'profile_image': acc.getUrlImage(),
    });
  }

  Future<void> updateUser(Account acc) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      await currentUser.updateEmail(acc.getEmail()!);
      if (acc.getPswd() != null) {
        await currentUser.updatePassword(acc.getPswd()!);
      }

      await _firestore.collection('users').doc(userId).update(
          {'username': acc.getUsername(), 'profile_image': acc.getUrlImage()});
    } else {
      throw 'User not found';
    }
  }

  Future<void> deleteUser(String userId) async {
    User? user = await _auth.currentUser;
    if (user != null && user.uid == userId) {
      await _firestore.collection('users').doc(userId).delete();
      await user.delete();
    } else {
      throw 'User not found.';
    }
  }

  Future<Account?> getUser(String userId) async {
    User? selectedUser = await FirebaseAuth.instance
        .userChanges()
        .firstWhere((user) => user!.uid == userId);
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(userId).get();

    if (selectedUser != null && userSnapshot.exists) {
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
      return Account(
          id: selectedUser.uid,
          email: selectedUser.email,
          userName: data['username'],
          urlImage: data['profile_image']);
    } else {
      throw 'User not found.';
    }
  }

  Future<Account?> getCurrentUser() async {
    User? user = await _auth.currentUser;
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(user?.uid).get();

    if (user != null && userSnapshot.exists) {
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
      return Account(
          id: user.uid,
          email: user.email,
          userName: data['username'],
          urlImage: data['profile_image']);
    } else {
      throw 'User not found.';
    }
  }
}
