import 'package:animal_sanctuary/screens/register_launch_screen.dart';
import 'package:animal_sanctuary/shared/authentication.dart';
import 'package:flutter/material.dart';
import 'pets_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animal_sanctuary/screens/contact_screen.dart';
import 'package:animal_sanctuary/models/home_details.dart';
import 'package:animal_sanctuary/screens/login_launch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final bool isLogin;
  const HomeScreen(this.isLogin);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final Firestore db = Firestore.instance;
  final double defaultPadding = 5.0;
  HomeDetails homeDetails;
  final Authentication auth = new Authentication();
  bool _isLogin;

  @override
  void initState() {
    if (mounted) {
      getHomeDetails().then((data) {
        setState(() {
          homeDetails = data;
        });
      });
    }
    super.initState();
  }

  // SCREEN UI
  @override
  Widget build(BuildContext context) {
    //if(auth.getUser().then((value) => null))
    /* Scaffold widget represents a screen in a MaterialApp widget
    as it may contain several layouts such as a navigation bar,
    floating action buttons etc. */
    return Scaffold(
      /* In the appbar property, an AppBar widget is placed which will
      contain the text that I want to display in the application bar. */
      appBar: AppBar(
        title: Text('Wicklow Animal Sanctuary'),
        actions: [ IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            auth.signOut().then((result) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      LoginLaunchScreen()));});},
        )
          /*Padding(
              padding: EdgeInsets.all(10),
              child: (_isLogin) ? loginButton() : logoutButton(),
        )*/],
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              headerButtons(),
              screenInfo(),

              if (widget.isLogin) FlatButton (
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            LoginLaunchScreen()));}),

              if (widget.isLogin) FlatButton (
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            RegisterLaunchScreen()));}),


            ],),
        ),
      ),
    );
  }

  void checkUserLogin() async {

  }


  Widget headerButtons() {
    return Row(
        children: [
          Padding(padding: EdgeInsets.all(defaultPadding),),
          Expanded(child: RaisedButton(
            color: Color(0xff009688),
            child: Text("Animals",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        PetScreen())),
          )),

          Padding(padding: EdgeInsets.all(10),),
          Expanded(child: RaisedButton(
            color: Color(0xff6009688),
            child: Text("Contact Us",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ContactScreen())),
          )),
          Padding(padding: EdgeInsets.all(defaultPadding),),
        ]);
  }

  Widget screenInfo() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            homeDetails.homeHeader,
            style: TextStyle(
              fontSize: 20,),
          ),
        ),
        Image.network(homeDetails.homeImage),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(homeDetails.homeDescription),
        ),
      ],),
    );
  }


  Future<HomeDetails> getHomeDetails() async {
    var data = await db.collection('HomeDetails').document('qGxAmYdi6gG1DwAytk2t').get();
    /* If 'data' is not null, the map() method is called on the
    pet details retrieved by the getDocuments() method, and a list of
    'PetDetails' objects is created calling the 'fromMap' constructor. */
    if(data != null) {
      homeDetails = HomeDetails.fromMap(data);
      homeDetails.id = data.documentID;
    }
    // returns List instance of 'PetDetails'
    return homeDetails;
  }
}

