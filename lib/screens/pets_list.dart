import 'package:animal_sanctuary/screens/pet_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_details.dart';

class PetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // this text appears int a bar at the top of the screen
        title: Text('Pets'),
      ),
      body: PetList(),
    );
  }
}

class PetList extends StatefulWidget {
  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  // instance of Firestore database
  final Firestore db = Firestore.instance;
  // instance of 'PetDetails' in a List
  List<PetDetails> petDetails = [];

  @override
  void initState() {
    if (mounted) {
      getPetDetailsList().then((data) {
        setState(() {
          petDetails = data;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        body: ListView.builder(
          itemCount: (petDetails != null) ? petDetails.length : 0,
          itemBuilder: (context, position) {
          if(petDetails[position].petImage != null) {
            image = NetworkImage(
                petDetails[position].petImage
            );
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            /* 'ListTile' is a material widget that can contain one to
            three lines of text with optional icons at the beginning
            and end. */
            child: ListTile(
              onTap: () {
                /*MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => PetDetailScreen(petDetails[position])
                ) ; */
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    PetDetailScreen(petDetails[position])));
              },
              title: Center(
                child: Text(petDetails[position].petName),
              ),
              subtitle: Text(petDetails[position].petDescription),
              leading: CircleAvatar(
                  backgroundImage: image,
                ),
            ),
          );
        },
    ));
  }

  // retrieve the list
  Future<List<PetDetails>> getPetDetailsList() async {
    // getDocuments() gets all available data from 'PetDetails'
    var data = await db.collection('PetDetails').getDocuments();
    /* If 'data' is not null, the map() method is called on the
    pet details retrieved by the getDocuments() method, and a list of
    'PetDetails' objects is created calling the 'fromMap' constructor. */
    if(data != null) {
      petDetails = data.documents.map((document) =>
          PetDetails.fromMap(document)).toList();
      int i = 0;
      // set each pet detail's id as the documentID instance
      petDetails.forEach((detail) {
        detail.id = data.documents[i].documentID;
        i++;
      });
    }
    // returns List instance of 'PetDetails'
    return petDetails;
  }
}


