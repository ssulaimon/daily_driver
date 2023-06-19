import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_driver/authentication/firebase_email_auth.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataBase {
  static FirebaseFirestore get db => FirebaseFirestore.instance;

  Future<bool> updateMyProfile(
      {required Map<String, dynamic> data,
      required BuildContext context}) async {
    var loader = Provider.of<LoaderState>(context, listen: false);
    try {
      loader.loading = true;
      await db
          .collection(
            FirebaseEmailAuth.firebaseAuth.currentUser!.uid,
          )
          .doc(
            'Proifle',
          )
          .set(
            data,
          );
      loader.loading = false;
      return true;
    } catch (error) {
      loader.loading = false;
      log(
        error.toString(),
      );
      return false;
    }
  }

  Future<Map<String, dynamic>?> isUserVerified() async {
    Map<String, dynamic>? profile;
    final data = db
        .collection(FirebaseEmailAuth.firebaseAuth.currentUser!.uid)
        .doc('Proifle');
    await data.get().then((DocumentSnapshot doc) async {
      profile = doc.data() as Map<String, dynamic>;
    }).onError((error, stackTrace) {
      log(error.toString());
    });
    return profile;
  }
}
