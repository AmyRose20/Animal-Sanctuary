/* Screen allows user to login in to the app,
 or to sign up and obtain an identity. */
import 'package:animal_sanctuary/screens/home_screen.dart';
import 'package:animal_sanctuary/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animal_sanctuary/shared/authentication.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // holds message for any error that may occur during login or sign up
  String _message;
  final TextEditingController _textEmail = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();

  Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
    setState(() {
      _message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                emailInput(),
                passwordInput(),
                loginButton(),
                validationMessage(),
              ],),)
        ),
      )
    );
  }

  // Method returns EMAIL TextFormField widget
  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'yourname@example.com',
            labelText: 'Email',
            icon: Icon(Icons.mail)),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  // Method returns PASSWORD TextFormField widget
  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _textPassword,
        keyboardType: TextInputType.emailAddress,
        // Hide password characters
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
            icon: Icon(Icons.enhanced_encryption)),
        validator: (text) => text.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Container(
          height: 50,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).accentColor,
              elevation: 3,
              child: Text('Login'),
              onPressed: () async {
                try {
                  FirebaseUser firebaseUser = (await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _textEmail.text,
                      password: _textPassword.text)).user;
                  if (firebaseUser != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            HomeScreen()));
                  }
                } catch (e) {
                  print('Error: $e');
                  setState(() {
                    _message = e.message;
                    //_textEmail.text = "";
                    //_textPassword.text = "";
                  });
                }
              }
          )),);
  }

  Widget validationMessage() {
    return Text(_message,
    style: TextStyle(
      fontSize: 14,
      color: Colors.red,
      fontWeight: FontWeight.bold),);
  }
}




