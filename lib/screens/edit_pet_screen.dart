import 'dart:io';
import 'package:animal_sanctuary/models/pet_details.dart';
import 'package:flutter/material.dart';
import 'package:animal_sanctuary/screens/pets_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class EditPetScreen extends StatefulWidget {
  PetDetails petDetails;

  EditPetScreen(this.petDetails);
  @override
  _AddToListScreenState createState() => _AddToListScreenState(this.petDetails);
}

class _AddToListScreenState extends State<EditPetScreen> {
  PetDetails petDetails;
  _AddToListScreenState(this.petDetails);
  TextEditingController _petName = TextEditingController();
  TextEditingController _petAge = TextEditingController();
  TextEditingController _petDescription = TextEditingController();
  /* Initial value set to 'Dog' so one of the radio buttons is
  pre-selected when a staff member is adding new data to a new item
  in the list. */
  String _petType = 'Dog';

  void _handleRadioValueChange(String value) {
    setState(() {
      _petType = value;
    });
  }

  /* String assigned to the value of the returned URL String from
  the uploadFile() function. _imageURL is then assigned to the value of
  the 'petImage' field in the petDetails collection, referencing the
  URL of the stored image in Firebase storage. */
  String _imageURL;
  /* File(image) retrieved from users phone and subsequently uploaded
  to Firestore using the uploadFile() function. */
  File _image;
  bool isUploaded = true;
  // Code sourced from
  // https://medium.com/swlh/uploading-images-to-cloud-storage-using-flutter-130ac41741b2
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if(gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,);
    }
    // Otherwise open camera to get new photo
    else{
      pickedFile = await picker.getImage(
        source: ImageSource.camera,);
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit Pet Info')),
        body: Container(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Pet Name Field
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _petName,
                                decoration: InputDecoration(
                                  hintText: 'Rex',
                                  labelText: 'Pet Name',
                                ),
                              ),
                          ),

                          // Pet Age Field
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _petAge,
                                decoration: InputDecoration(
                                  hintText: '3',
                                  labelText: 'Pet Age',
                                ),
                              ),
                          ),

                          // Pet Description Field
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _petDescription,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                ),
                                maxLines: 10,
                                minLines: 5,
                              ),
                          ),
                          Padding(padding: EdgeInsets.all(10),),

                          // Pet Type
                          //Text('Pet Type'),
                          // Dog
                          /* Row(
                              children: <Widget> [
                                Radio (
                                  value: 'Dog',
                                  groupValue: _petType,
                                  onChanged: _handleRadioValueChange,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _petType = 'Dog';
                                    });
                                  },
                                  child: Text('Dog'),
                                ),
                              ]),
                          // Cat
                          Row(
                              children: <Widget> [
                                Radio (
                                  value: 'Cat',
                                  groupValue: _petType,
                                  onChanged: _handleRadioValueChange,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _petType = 'Cat';
                                    });
                                  },
                                  child: Text('Cat'),
                                ),
                              ]),
                          // Other
                          Row(
                              children: <Widget> [
                                Radio (
                                  value: 'Other',
                                  groupValue: _petType,
                                  onChanged: _handleRadioValueChange,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _petType = 'Other';
                                    });
                                  },
                                  child: Text('Other'),
                                ),
                              ]), */
                          Padding(padding: EdgeInsets.all(10),),

                          // Pet Image
                          RawMaterialButton(
                            fillColor: Theme.of(context).accentColor,
                            child: Icon(Icons.add_photo_alternate_rounded,
                              color: Colors.white,),
                            elevation: 8,
                            onPressed: () {
                              getImage(true);
                              isUploaded = true;
                            },
                            padding: EdgeInsets.all(15),
                            shape: CircleBorder(),
                          ),
                          Padding(padding: EdgeInsets.all(10),),

                          _image != null ? Container(
                            child: Image.file(_image),
                          ) :
                          Image.network('https://i.imgur.com/sUFH1Aq.png'),

                         _image != null && isUploaded ? RaisedButton(
                            child: Text('Upload File'),
                            onPressed: () {
                              uploadFile(_image, context).then((value) => setState(() {
                                _imageURL = value;
                                isUploaded = false;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return AlertDialog(
                                        title: Text('File Uploaded'),
                                      );
                                    });
                              }));},
                            color: Colors.blue,
                          ) :
                          Container(),

                          Padding(padding: EdgeInsets.all(10),),
                          // Adding all the data to the List
                          FloatingActionButton(
                              child: Icon(Icons.done,),
                              onPressed: () async {
                                if(_petName.text.isEmpty) {
                                  _petName.text = petDetails.petName;
                                }
                                if(_petAge.text.isEmpty) {
                                  _petAge.text = petDetails.petAge;
                                }
                                if(_petDescription.text.isEmpty) {
                                  _petDescription.text = petDetails.petDescription;
                                }
                                if(_petType.isEmpty) {
                                  _petType = petDetails.petType;
                                }
                                if(_imageURL.isEmpty) {
                                  _imageURL = petDetails.petImage;
                                }
                                Firestore.instance.collection('PetDetails').document(petDetails.id).updateData({
                                  'petName': _petName.text,
                                  'petAge': _petAge.text,
                                  'petDescription': _petDescription.text,
                                  'petType': _petType,
                                  'petImage': _imageURL,
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        PetScreen()));
                              }
                              ),
                        ]
                    )
                )
            )
        ));
  }
}

// Code sourced from
// https://medium.com/swlh/uploading-images-to-cloud-storage-using-flutter-130ac41741b2
Future<String> uploadFile(File _image, context) async {
  //bool isUploaded = false;
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('Animals/${Path.basename(_image.path)}');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  print('File Uploaded');
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text('File Uploaded'),
        );
      });
  //isUploaded = true;
  String returnURL;
  await storageReference.getDownloadURL().then((fileURL) {
    returnURL =  fileURL;
  });
  return returnURL;
}
