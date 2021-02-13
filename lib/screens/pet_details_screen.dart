import 'package:animal_sanctuary/models/pet_details.dart';
import 'package:flutter/material.dart';

class PetDetailScreen extends StatelessWidget {
  final PetDetails petDetails;

  PetDetailScreen(this.petDetails);

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
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
              )
            ],
          ),
        ),),
    );
  }
}
