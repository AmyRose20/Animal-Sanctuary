import 'package:flutter/material.dart';
import 'pets_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /* Scaffold widget represents a screen in a MaterialApp widget
    as it may contain several layouts such as a navigation bar,
    floating action buttons etc. */
    return Scaffold(
        /* In the appbar property, an AppBar widget is placed which will
        contain the text that I want to display in the application bar. */
        appBar: AppBar(
          title: Text('Wicklow SPCA App'),
          backgroundColor: Colors.deepPurple,
        ),
        // 'body' contains the main content of the screen
        body: Builder(builder: (context)=> SingleChildScrollView(
            /* child is a property that allows you to nest 
            widgets inside other widgets */
            child: Padding(
                padding: EdgeInsets.all(20),
                /* Center is a positional widget that centers its content on
                the screen. */
                child: Center(
                  /* Column container widget allows an array of 
                  widgets i.e., more than one child */
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Wicklow SPCA (insert from firebase)',
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
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: RaisedButton(
                          child: Text('Click here for list'),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                PetScreen())),
                        )
                      )
                    ])
                )
            )
        ))
    );
  }
}



