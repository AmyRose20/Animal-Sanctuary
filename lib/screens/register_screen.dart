import 'package:animal_sanctuary/shared/authentication.dart';
import 'package:flutter/material.dart';
import 'package:animal_sanctuary/screens/home_screen.dart';
import 'package:animal_sanctuary/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {

  String _message;
  final TextEditingController _textFirstName = TextEditingController();
  final TextEditingController _textSecondName = TextEditingController();
  final TextEditingController _textEmail = TextEditingController();
  final TextEditingController _textPhoneNumber = TextEditingController();
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
      appBar: AppBar(title: Text('Register')),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                firstNameInput(),
                secondNameInput(),
                emailInput(),
                phoneNumberInput(),
                passwordInput(),
                registerButton(),
                validationMessage(),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Already a member?',),
                        MaterialButton(
                          child: Text('Sign in',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(decoration:
                          TextDecoration.underline),),
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  LoginScreen())
                            );}
                        ),],),),
              ],),),
        ),
      ),
    );
  }

  // Method returns FIRST NAME TextFormField widget
  Widget firstNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textFirstName,
        decoration: InputDecoration(
            hintText: 'John',
            labelText: 'First Name',
            icon: Icon(Icons.person)),
        validator: (text) => text.isEmpty ? 'First Name is required' : '',
      ),
    );
  }

  // Method returns SECOND NAME TextFormField widget
  Widget secondNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textSecondName,
        decoration: InputDecoration(
          hintText: 'Smith',
          labelText: 'Second Name',
            icon: Icon(Icons.person)
        ),
        validator: (text) => text.isEmpty ? 'Second Name is required' : '',
      ),
    );
  }

  // Method returns EMAIL TextFormField widget
  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'yourname@example.com',
            labelText: 'Email',
            icon: Icon(Icons.mail),
        ),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  // Method returns PHONE NUMBER TextFormField widget
  Widget phoneNumberInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textPhoneNumber,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: '0862805161',
            labelText: 'Phone Number',
            icon: Icon(Icons.phone)
        ),
        validator: (text) => text.isEmpty ? 'Phone Number is required' : '',
      ),
    );
  }

  // Method returns PASSWORD TextFormField widget
  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textPassword,
        keyboardType: TextInputType.emailAddress,
        // hide password characters
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
            icon: Icon(Icons.enhanced_encryption)
        ),
        validator: (text) => text.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  // Widget returns REGISTER BUTTON
  Widget registerButton() {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Container(
            height: 50,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).accentColor,
                elevation: 3,
                child: Text('Register'),
                onPressed: () async {
                  try {
                    FirebaseUser user = (await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _textEmail.text, password: _textPassword.text)).user;
                    Firestore.instance.collection('UserDetails').document().setData({ 'userid': user.uid,
                      'userFirstName': _textFirstName.text, 'userSecondName': _textSecondName.text,
                      'userEmail' : _textEmail.text, 'userPhoneNumber': _textPhoneNumber.text,
                        'userPassword': _textPassword.text,});

                    if(user != null)
                    {
                      // Holds all information pertaining to a firebase user
                      UserUpdateInfo updateUser = UserUpdateInfo();
                      // Modified display name
                      updateUser.displayName = _textFirstName.text;
                      user.updateProfile(updateUser);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              HomeScreen(false)));
                    }
                  } catch (e) {
                    print(e);
                    // Reset screen if error
                    _textFirstName.text = "";
                    _textSecondName.text = "";
                    _textEmail.text = "";
                    _textPhoneNumber.text = "";
                    _textPassword.text = "";
                  }} // End of Try/Catch Block and onPressed()
                ),),);
  } // End of registerButton()

  Widget validationMessage() {
    return Text(_message,
      style: TextStyle(
          fontSize: 14,
          color: Colors.red,
          fontWeight: FontWeight.bold),);
  }
} // END

