import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  /* FirebaseAuth is the object that enables the use of Firebase
  Authentication methods and properties. */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /* As methods in FirebaseAuth are asynchronous, I shall be returning
  a Future of type String. */
  Future<String> login(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // Check whether user is logged in or not by retrieving current user
  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // Creating a new user
  Future<String> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }
}


