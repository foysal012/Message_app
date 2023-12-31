import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  //user signin
  Future<UserCredential> SignInWithEmailandPassword(String email, String password) async{

    try{

      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      //add a new document for the user in users collection if it doesn't already exist
      _firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "uid" : userCredential.user!.uid,
        "email" : email,
      },
      SetOptions(merge: true),
      );


      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    //notifyListeners();
  }

  //create User
  Future<UserCredential> signUpWithEmailandPassword(String email, String password) async{

    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      //after creating the user, create a new document for the user in the users collection
      _firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "uid" : userCredential.user!.uid,
        "email" : email,

      });

      return userCredential;

    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }

  //user signOut
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
    //notifyListeners();
  }

  //reset password
  Future<void> resetPassword(String email) async{

       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    //notifyListeners();
  }

}