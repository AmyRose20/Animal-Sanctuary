import 'package:animal_sanctuary/screens/login_launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/home_screen.dart';

// runApp() method inflates a widget and attaches it to the screen
void main() => runApp(MyApp());

/* Note: A widget is a description of the user interface. This
description gets "inflated" into an actual view when the objects
are built. */
// StatelessWidget as widget does not need to be changed after its creation
// Extending a stateless widget class requires overriding a build() method
class MyApp extends StatelessWidget {
  // This widget is the root of the application
  @override
  /* In the build method you describe the
  widget returned by the method. */
  Widget build(BuildContext context) {
    testData();
    /* Content is wrapped in a MaterialApp widget. This allows
    you to give a title to your app. */
    return MaterialApp(
      title: 'Wicklow Animal Sanctuary',
      home: HomeScreen(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // HomeScreen is what the user will see at the start of the app
    return HomeScreen();
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



