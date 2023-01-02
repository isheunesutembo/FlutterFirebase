import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
  User get user => firebaseAuth.currentUser!;

  void signOut() {
    try {
      firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firebaseFirestore.collection("users").doc(user.uid).set({
            "username": user.displayName,
            "uid": user.uid,
            "profilePhoto": user.photoURL
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      res = false;
    }
    return res;
  }
}
