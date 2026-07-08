import 'package:cloud_firestore/cloud_firestore.dart';

var collection_path;
var doc_path;
var likes;

getLikes() async{
  await FirebaseFirestore.instance
      .collection(collection_path)
      .doc(doc_path)
      .get()
      .then((value) {
     likes = value.get('love');
  });
  print(likes);
}