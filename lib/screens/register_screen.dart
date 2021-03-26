import 'package:animal_sanctuary/screens/home_screen.dart';
import 'package:animal_sanctuary/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _textFirstName = TextEditingController();
  final TextEditingController _textSecondName = TextEditingController();
  final TextEditingController _textEmail = TextEditingController();
  final TextEditingController _textPhoneNumber = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();
  final TextEditingController _textRePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
                rePasswordInput(),
                registerButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Already a member?",),
                    MaterialButton(
                        child: Text("Sign in",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(decoration:
                          TextDecoration.underline),),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  LoginScreen())
                          );}
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method returns FIRST NAME TextFormField widget
  Widget firstNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _textFirstName,
        decoration: InputDecoration(
            hintText: 'John',
            labelText: 'First Name',
            icon: Icon(Icons.person)
        ),
        validator: (text) => text.isEmpty ? 'First Name is required' : '',
      ),
    );
  }

  // Method returns SECOND NAME TextFormField widget
  Widget secondNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
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
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'yourname@example.com',
            labelText: 'Email',
            icon: Icon(Icons.person),
        ),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  // Method returns PHONE NUMBER TextFormField widget
  Widget phoneNumberInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
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

  // Method returns password TextFormField widget
  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        //controller: textPassword,
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

  // Method returns REENTERED PASSWORD TextFormField widget
  Widget rePasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _textRePassword,
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

  Widget registerButton() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Container(
            height: 50,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Theme
                    .of(context)
                    .accentColor,
                elevation: 3,
                child: Text("Register"),
                onPressed: () async {
                  try {
                    FirebaseUser firebaseUser = (await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _textEmail.text,
                        password: _textPassword.text)).user;
                    if(firebaseUser != null) {
                      // holds all information pertaining to a firebase user
                      UserUpdateInfo updateUser = UserUpdateInfo();
                      // modified display name
                      updateUser.displayName = _textFirstName.text;
                      firebaseUser.updateProfile(updateUser);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                            HomeScreen()));
                    }
                  } catch (e) {
                    print(e);
                    // reset screen if error
                    _textFirstName.text = "";
                    _textSecondName.text = "";
                    _textEmail.text = "";
                    _textPhoneNumber.text = "";
                    _textPassword.text = "";
                    _textRePassword.text = "";
                  }
                }
                ),
            ),
        );
  }
} // END

