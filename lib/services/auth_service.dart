import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String? name) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore
          .collection('users')
          .doc(cred.user?.uid)
          .set({'name': name, 'email': email, 'auth': "SignUp"});

      return cred.user;
    } catch (e) {
      log("Error creating user: $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('users')
          .doc(cred.user?.uid)
          .update({'auth': "LoggedIn"});
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({'auth': "Signout"});
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
