// Screen where methods of Authentication class are added
import 'package:animal_sanctuary/shared/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:animal_sanctuary/shared/authentication.dart';

class LoginLaunchScreen extends StatefulWidget {
  @override
  _LoginLaunchScreenState createState() => _LoginLaunchScreenState();
}

class _LoginLaunchScreenState extends State<LoginLaunchScreen> {
  // Check the current user state
  @override
  void initState() {
    super.initState();
    Authentication auth = Authentication();
    auth.getUser().then((user) {
      MaterialPageRoute route;
      /* If there is a logged in user, the Home Screen will display,
      else the Login Screen will display.*/
      if (user != null) {
        route = MaterialPageRoute(builder: (context) =>
            HomeScreen());
      }
      else {
        route = MaterialPageRoute(builder: (context) =>
            LoginScreen());
      }
      /* pushReplacement() not only pushed the new route to the top of the
      stack, but it also removes the previous route. This prevents the user
      from navigating back to the Launch Screen. */
      Navigator.pushReplacement(context, route);
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),)
      );
  }
}

