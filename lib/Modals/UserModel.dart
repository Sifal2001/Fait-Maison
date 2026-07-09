
class UserModel{
  String? uid;
  String? name;
  String? email;

  UserModel({this.uid, this.name, this.email});

  //Getting data from server
  factory UserModel.fromMap(map){
  return UserModel(
    uid: map['uid'],
    email: map['email'],
    name: map['name'],
  );
  }
  //Sending data to server
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}