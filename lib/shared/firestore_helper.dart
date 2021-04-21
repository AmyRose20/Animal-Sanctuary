import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animal_sanctuary/screens/pets_list.dart';
import 'package:animal_sanctuary/models/pet_details.dart';

class FirestoreHelper {
  static final Firestore db = Firestore.instance;
}

