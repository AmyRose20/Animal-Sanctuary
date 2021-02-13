import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/home_details.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: HomeScreenContent()
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Sharpeshill Sanctuary",
        // home is what the user will see on the screen of the app
        /* Scaffold widget represents a screen in a MaterialApp widget
        as it may contain several layouts including a bottom navigation bar,
        floating action buttons etc. */
        home: Scaffold(
          /* In the appbar property, an AppBar widget is placed which will
          contain the text that I want to display in the application bar. */
            appBar: AppBar(
              title: Text('Wicklow SPCA App'),
              backgroundColor: Colors.deepPurple,
            ),
            // body contains the main content of the screen
            // Center is a positional widget that centers its content on the screen
            body: Builder(builder: (context)=> SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      // child is a property that allows you to nest widgets inside other widgets
                      // Column container widget allows an array of widgets i.e., more than one child
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Wicklow SPCA',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Image.network(
                              'https://images.freeimages.com/images/large-previews/c04/puppy-1367856.jpg',
                              height: 350,
                            ),
                          ),
                        ])
                    )
                )
            )
            )
        )
    );
  }
}



