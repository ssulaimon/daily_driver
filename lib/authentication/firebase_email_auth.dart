import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseEmailAuth {
  String email;
  String password;
  String? name;
  FirebaseEmailAuth({
    required this.email,
    required this.password,
    this.name,
  });
  static FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  static Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  static String? get userEmail => firebaseAuth.currentUser?.email;
  static String? get userPhoneNumber => firebaseAuth.currentUser?.phoneNumber;
  static String? get userName => firebaseAuth.currentUser?.displayName;
  static String? get userProfileImage => firebaseAuth.currentUser?.photoURL;

  Future<String?> loginToAccount() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {}
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  Future<String?> createAccount() async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = userCredential.user;
      }
      return null;
    } on FirebaseAuthException catch (erorr) {
      return erorr.message;
    }
  }

  static Future<bool> updateEMailAddress({
    required BuildContext context,
    required String email,
  }) async {
    bool verified = false;
    User? user = firebaseAuth.currentUser;
    var loader = Provider.of<LoaderState>(context, listen: false);
    try {
      loader.loading = true;
      await Future.delayed(
        const Duration(
          seconds: 5,
        ),
      );
      await user!.updateEmail(email);
      await user.reload();
      user = firebaseAuth.currentUser;
      loader.loading = false;

      verified = true;
      return verified;
    } on FirebaseAuthException catch (erorr) {
      loader.loading = false;
      return verified;
    }
  }
}
