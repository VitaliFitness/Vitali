import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(BuildContext context, String email, String password) async {

    try {
      //provide the email and password for firebase authentication
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;

      //catch and display any firebase authentication error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email Already Regsitered');
      } else if (e.code == 'weak-password') {

        print('Password Should Contain At least 6 Characters');
      }
    }catch (e) {
      print('Registration Fail');
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Login Failed");
    }
    return null;

  }

}