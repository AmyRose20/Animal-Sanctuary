import 'package:animal_sanctuary/screens/pet_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_details.dart';
import 'package:animal_sanctuary/screens/add_to_pet_list.dart';

class PetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // this text appears in a bar at the top of the screen
        title: Text('Pets'),
      ),
      body: PetList(),
    );
  }
}

class PetList extends StatefulWidget {
  //final bool isAdmin;
  //const PetList(this.isAdmin);

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  final admin = true;
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
              leading: CircleAvatar(
                  backgroundImage: image,
                ),
            ),
          );
        },
    ),
     /* Column(
        children: <Widget>[
          if(widget.isAdmin) FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      AddToListScreen()));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddToListScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Retrieve the list
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


