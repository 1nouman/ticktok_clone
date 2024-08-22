import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticktok_proj/core/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.uid,
      required super.profilePhoto,
      required super.email});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePhoto': profilePhoto,
      'email': email,
    };
  }

  static UserModel fromSnap(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['name'] as String,
      uid: snapshot['uid'] as String,
      profilePhoto: snapshot['profilePhoto'] as String,
      email: snapshot['email'] as String,
    );
  }
  // factory User.fromMap(Map<String, dynamic> map) {
  //   return
  // }
}
