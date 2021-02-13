import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/home_screen.dart';
import './screens/pets_list.dart';

// runApp() method inflates a widget and attaches it to the screen
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    testData();
    return MaterialApp(
      title: 'Wicklow Animal Sanctuary',
      home: PetScreen(),
    );
  }
}

Future testData() async {
  // instance of Firestore database
  Firestore db = Firestore.instance;
  /* getDocuments() gets all available data from the collection
  'PetDetails'. */
  var data = await db.collection('PetDetails').getDocuments();
  /* If 'data' is not null, the documents from the collection 'PetDetails'
  are put in the list variable below, 'details'. */
  var details = data.documents.toList();
  // loop prints ID of each document within the collection
  details.forEach((d) {
    print(d.documentID);
  });
}



