import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:ticktok_proj/core/exception/server_exception.dart';
import 'package:ticktok_proj/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDatasources {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required File image,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<String> uploadToStorage({required File image});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasources {
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.auth, this.storage, this.firestore);

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    final res =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    if (res.user == null) {
      throw const ServerException('User is null!');
    }
    print("loged user ID iS :::: ${res.user!} ");
    final user_document =
        await firestore.collection('users').doc(res.user!.uid).get();

    final userData = UserModel.fromSnap(user_document);
    return userData;
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    final res = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (res.user == null) {
      throw const ServerException('User is null!');
    }
    print("loged user ID iS :::: ${res.user!} ");

    String downloadUrl = await uploadToStorage(image: image);
    UserModel user = UserModel(
      name: name,
      email: email,
      uid: res.user!.uid,
      profilePhoto: downloadUrl,
    );

// write to database
    await firestore.collection('users').doc(res.user!.uid).set(user.toJson());

    // read from database
    final user_document =
        await firestore.collection('users').doc(res.user!.uid).get();

    final userData = UserModel.fromSnap(user_document);

    return userData;
  }
  
  @override
  Future<String> uploadToStorage({required File image}) async {
   Reference ref =
        storage.ref().child('profilePics').child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  

 
}
