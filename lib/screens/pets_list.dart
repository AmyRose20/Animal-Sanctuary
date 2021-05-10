import 'package:animal_sanctuary/screens/pet_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_details.dart';
import 'package:animal_sanctuary/screens/add_to_pet_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animal_sanctuary/models/user_details.dart';
import 'package:animal_sanctuary/screens/home_screen.dart';
import 'package:animal_sanctuary/screens/contact_screen.dart';

class PetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // this text appears in a bar at the top of the screen
        title: Text('Animals'),
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
  // Instance of Firestore database
  final Firestore db = Firestore.instance;
  // Instance of 'PetDetails' in a List
  List<PetDetails> petDetails = [];

  bool _plusSign = true;
  UserDetails userDetails;
  //String userType = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    if (mounted) {
      getPetDetailsList().then((data) {
        setState(() {
          petDetails = data;
        });
      });
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
    NetworkImage image;
    return Scaffold(
        body: ListView.builder(
          itemCount: (petDetails != null) ? petDetails.length : 0,
          itemBuilder: (context, position) {
            if(petDetails[position].petImage != null) {
              image = NetworkImage(
                petDetails[position].petImage
              );
              // To fix navigation
              /* if(position == 0 ) {
                return Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10),),
                      Expanded(child: RaisedButton(
                        color: Color(0xff009688),
                        child: Text("Home",
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    HomeScreen())),
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
                      Padding(padding: EdgeInsets.all(10),),
                    ]
                );
              } */
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

      floatingActionButton: userDetails != null && userDetails.userType == "staffMember" ? FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddToListScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ) : Container(),

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




