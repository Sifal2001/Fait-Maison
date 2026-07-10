import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreHelpers.dart';

List<String> veggies = [];
List<String> fruits = [];

getVeggies() async
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('ingredients')
      .doc('veggies')
      .get()
      .then((value) {
    veggies = readListField<String>(value, 'name');
  });
}

getFruits() async
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('ingredients')
      .doc('fruits')
      .get()
      .then((value) {
    fruits = readListField<String>(value, 'name');
  });
}