import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'An error occurred');
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
     required String mobile, 
    required String address,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential != null) {
        await storeUserData(
          name: name,
          password: password, 
          email: email,
          mobile:mobile,
          address:address,
        );
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'An error occurred');
      return null;
    }
    return userCredential;
  }

  Future<void> storeUserData({
    required String name,
    required String password,
    required String email,
    required String mobile,
    required String address,
  }) async {
    try {
      DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
      await store.set({
        'name': name,
        'password': password, 
        'email': email,
        'mobile':mobile,
        'address':address,
        'imageUrl': '',
        'id': currentUser!.uid,
       
      });
      print("User data stored successfully for UID: ${currentUser!.uid}");
    } catch (e) {
      print("Error storing user data: ${e.toString()}");
    }
  }

  Future<void> signoutMethod(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      VxToast.show(context, msg: 'Successfully signed out');
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
