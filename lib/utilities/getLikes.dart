import 'package:cloud_firestore/cloud_firestore.dart';

var collection_path;
var doc_path;
var likes;

getLikes() async{
  final snapshot = await FirebaseFirestore.instance
      .collection(collection_path)
      .doc(doc_path)
      .get();
  final data = snapshot.data();
  if (snapshot.exists && data != null && data['love'] != null) {
    likes = data['love'];
  } else {
    likes = 0;
  }
  print(likes);
}