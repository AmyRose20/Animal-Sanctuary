import 'package:animal_sanctuary/models/pet_details.dart';
import 'package:animal_sanctuary/screens/edit_pet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/pet_details.dart';
import 'package:animal_sanctuary/screens/pets_list.dart';



class PetDetailScreen extends StatelessWidget {
  final PetDetails petDetails;

  PetDetailScreen(this.petDetails);

  @override
  Widget build(BuildContext context) {

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Pet From List'),
            content: Text("Are you sure you want to delete this pet?"),
            actions: <Widget>[
              FlatButton(child: Text('Yes'),
                onPressed: () async {
                  Firestore.instance.collection('PetDetails').document(petDetails.id).delete();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          PetScreen()));
                },),
              // usually buttons at the bottom of the dialog
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

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar:  AppBar(
           title: Text(petDetails.petName),
    ),
        body: SingleChildScrollView(child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: height / 1.5,
                child: Image.network(petDetails.petImage),
              ),
              Container (
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(petDetails.petDescription),
              ),

              Container (
                padding: EdgeInsets.fromLTRB(10,10,10,10),
              ),
              Stack(
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
                        }
                    ),),
                ],),
            ]),),
        ));
  }
}

