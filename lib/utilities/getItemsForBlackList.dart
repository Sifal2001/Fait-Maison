import 'package:cloud_firestore/cloud_firestore.dart';

List<String> veggies = [];
List<String> fruits = [];

getVeggies() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('ingredients')
      .doc('veggies')
      .get()
      .then((value) {
    veggies = List<String>.from(value.get('name') as List);
  });
}

getFruits() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('ingredients')
      .doc('fruits')
      .get()
      .then((value) {
    fruits = List<String>.from(value.get('name') as List);
  });
}