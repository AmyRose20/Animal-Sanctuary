import 'package:animal_sanctuary/models/pet_details.dart';
import 'package:animal_sanctuary/screens/edit_pet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/pet_details.dart';
import 'package:animal_sanctuary/screens/pets_list.dart';
import 'package:animal_sanctuary/models/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetDetailScreen extends StatelessWidget {
  final PetDetails petDetails;
  PetDetailScreen(this.petDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PetDetail(this.petDetails),
    );
  }
}

class PetDetail extends StatefulWidget {
  final PetDetails petDetails;
  PetDetail(this.petDetails);
  @override
  _PetDetailState createState() => _PetDetailState(this.petDetails);
}

class _PetDetailState extends State<PetDetail> {
  final Firestore db = Firestore.instance;
  final PetDetails petDetails;
  _PetDetailState(this.petDetails);
  UserDetails userDetails;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    if (mounted) {
      getUserDetails().then((userData) {
        setState(() {
          userDetails = userData;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Animals'),
            content: Text("Are you sure you want to delete?"),
            actions: <Widget>[
              FlatButton(child: Text('Yes'),
                onPressed: () async {
                  Firestore.instance.collection('PetDetails').document(petDetails.id).delete();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          PetScreen()));
                },),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar:  AppBar(
          title: Text("Back To Animals"),
        ),
        body: SingleChildScrollView(child: Center(
          child: Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  petDetails.petName,
                  style: TextStyle(
                      fontSize: 20,),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Image.network(petDetails.petImage),
                ),
                Container (
                  padding: EdgeInsets.all(16),
                  child: Text(petDetails.petDescription),
                ),
                userDetails != null && userDetails.userType == "staffMember" ? Stack(
                  children: <Widget>[
                    Align (
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.edit),
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    EditPetScreen(this.petDetails)));
                          }),),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.delete_forever),
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            _showDialog();
                          }),),
                  ],
                ) : Container(),
                Padding(padding: EdgeInsets.fromLTRB(10,10,10,10),),
              ]
          ),),
        )));
  }

  Future<UserDetails> getUserDetails() async {
    final FirebaseUser user = await auth.currentUser();
    var data = await db.collection('UserDetails').document(user.uid).get();

    if(data != null) {
      userDetails = UserDetails.fromMap(data);
      userDetails.id = data.documentID;
    }
    return userDetails;
  }
}




