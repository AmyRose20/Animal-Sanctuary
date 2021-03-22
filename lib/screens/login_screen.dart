/* Screen allows user to login in to the app,
 or to sign up and obtain an identity. */
import 'package:animal_sanctuary/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animal_sanctuary/shared/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /* When the _isLogin Boolean is used a login will be performed,
  when it is false a sign up will be enabled. */
  bool _isLogin = true;
  String _userId;
  String _password;
  String _email;
  String firstName;
  // String lastName;
  // String address;
  // String phoneNumber;
  // String memberType;
  // holds message for any error that may occur during login or sign up
  String _message = '';

  final TextEditingController textEmail = TextEditingController();
  final TextEditingController textPassword = TextEditingController();

  Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(child: Column(
            children: <Widget>[
              emailInput(),
              passwordInput(),
              mainButton(),
              secondaryButton(),
              validationMessage(),],
          )),
        ),
      ),
    );
  }

  // Method returns email TextFormField widget
  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'email',
            icon: Icon(Icons.mail)
        ),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  // Method returns password TextFormField widget
  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: textPassword,
        keyboardType: TextInputType.emailAddress,
        // hide password characters
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            icon: Icon(Icons.enhanced_encryption)
        ),
        validator: (text) => text.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  Widget mainButton() {
    /* The main button depends on whether or not _isLogin is true. When
    _isLogin is true, the user needs to login, and the primary button
    will be the login action, while the secondary button will be the
    sign up action. When _isLogin is false, the primary button will be the
    sign up action and the secondary button will be the log in action. */
    String buttonText = _isLogin ? 'Login' : 'Sign up';
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Container(
        height: 50,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius:
          BorderRadius.circular(20)),
          color: Theme
              .of(context)
              .accentColor,
          elevation: 3,
          child: Text(buttonText),
          /* submit() will validate and submit the data that was
          typed by the user */
          onPressed: submit,
        ),
      ),
    );
  }

  Widget secondaryButton() {
    /* Similar to mainButton(). The secondary button
    will switch from login and sign up and vice-versa, depending on the value
    of _isLogin. */
    String buttonText = !_isLogin ? 'Login' : 'Sign up';
    return FlatButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Widget validationMessage() {
    return Text(
        _message,
        style: TextStyle(
          fontSize: 14,
          color: Colors.red,
          fontWeight: FontWeight.bold,)
        );
  }

  Future submit() async {
    /* _message reset so if there was a previous validation message,
    it has been removed from the screen */
    setState(() {
      _message = "";
    });

    try {
      if (_isLogin) {
        _userId = await auth.login(textEmail.text, textPassword.text);
        print('Login for user $_userId');
      }
      else
      {
        _userId = await auth.signUp(textEmail.text, textPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context)=> HomeScreen())
        );
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _message = e.message;
        //_formKey.currentState.reset();
      });
    }
  }
}


