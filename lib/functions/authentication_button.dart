// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/authentication/firebase_email_auth.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationButton {
  static Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    String? message;
    Provider.of<LoaderState>(context, listen: false).loading = true;
    await Future.delayed(
        const Duration(
          seconds: 5,
        ), () async {
      FirebaseEmailAuth firebaseEmailAuth = FirebaseEmailAuth(
        email: email,
        password: password,
      );
      message = await firebaseEmailAuth.loginToAccount();
    });
    Provider.of<LoaderState>(context, listen: false).loading = false;
    return message;
  }

  static Future<String?> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    String? message;
    Provider.of<LoaderState>(context, listen: false).loading = true;
    await Future.delayed(
        const Duration(
          seconds: 5,
        ), () async {
      FirebaseEmailAuth firebaseEmailAuth =
          FirebaseEmailAuth(email: email, password: password, name: name);
      message = await firebaseEmailAuth.createAccount();
    });
    Provider.of<LoaderState>(context, listen: false).loading = false;
    return message;
  }
}
