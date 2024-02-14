import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ToastMessage.dart';


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
        showToast('Email Already Regsitered', context);
      } else if (e.code == 'weak-password') {

        showToast('Password Should Contain At least 6 Characters', context);
      }
    }catch (e) {
      showToast('Registration Fail', context);
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password, context) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      showToast("Login Failed", context);
    }
    return null;

  }

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('Email');
    } catch (e) {
      showToast("Logout Failed", context);
    }
  }

}