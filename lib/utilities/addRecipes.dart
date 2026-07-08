import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

addRecipes() async{
  await for (var messages in FirebaseFirestore.instance.collection('Breakfast_r').snapshots())
  {
    for (var message in messages.docs.toList()) {
      print(message.data());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('breakfast')
          .add(message.data());
    }
  }
}

addLunchRecipes() async{
  await for (var messages in FirebaseFirestore.instance.collection('Lunch_r').snapshots())
  {
    for (var message in messages.docs.toList()) {
      print(message.data());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('lunch')
          .add(message.data());
    }
  }
}

addDinnerRecipes() async{
  await for (var messages in FirebaseFirestore.instance.collection('Dinner_r').snapshots())
  {
    for (var message in messages.docs.toList()) {
      print(message.data());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('dinner')
          .add(message.data());
    }
  }
}