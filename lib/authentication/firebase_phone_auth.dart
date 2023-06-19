// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/const/routes_names.dart';
import 'package:daily_driver/pages/create_account.dart';
import 'package:daily_driver/state_manager/buttons_state.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class FirebasePhoneAuth {
  static FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  Future<String?> verifyPhoneNumber(
      {required String phoneNumber,
      required BuildContext context,
      String? name,
      required bool createAccount}) async {
    String? message;
    Provider.of<LoaderState>(context, listen: false).loading = true;

    await Future.delayed(const Duration(seconds: 5), () {
      firebaseAuth.verifyPhoneNumber(
          timeout: const Duration(
            seconds: 5,
          ),
          phoneNumber: phoneNumber,
          verificationCompleted: (
            PhoneAuthCredential phoneCredential,
          ) {
            message = 'Verification completed';
          },
          verificationFailed: (
            FirebaseAuthException firebaseAuthException,
          ) {
            message = firebaseAuthException.message;
            Provider.of<LoaderState>(context, listen: false).loading = false;
          },
          codeSent: (
            String id,
            int? time,
          ) async {
            await verifyCode(
              createAccount: createAccount,
              name: name,
              context: context,
              id: id,
            );
          },
          codeAutoRetrievalTimeout: (String code) {});
    });

    return message;
  }

  static Future<String?> createAccount({
    required String smsCode,
    required String verificationId,
    required String name,
    required BuildContext context,
  }) async {
    String? result;
    var buttonTitle = Provider.of<ButtonState>(
      context,
      listen: false,
    );
    var loader = Provider.of<LoaderState>(
      context,
      listen: false,
    );
    try {
      await firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        ),
      );
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(
          name,
        );
        await user.reload();
        user = firebaseAuth.currentUser;
        buttonTitle.buttonTitle = 'Account Created';
      }
      loader.loading = false;
      return result;
    } on FirebaseAuthException catch (error) {
      loader.loading = false;
      buttonTitle.buttonTitle = error.message ?? 'Something went wrong';
      result = error.message;
      return result;
    }
  }

  static Future<String?> loginToAccount(
      {required BuildContext context,
      required String verificationId,
      required String smsCode}) async {
    String? message;
    var buttonTitle = Provider.of<ButtonState>(
      context,
      listen: false,
    );
    var loader = Provider.of<LoaderState>(
      context,
      listen: false,
    );
    try {
      await firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        ),
      );
      loader.loading = false;

      context.go(RoutesName.homePage);
      return message;
    } on FirebaseAuthException catch (erorr) {
      message = erorr.message;
      buttonTitle.login = erorr.message ?? 'Something Went Wrong';
      loader.loading = false;
      return message;
    }
  }
}
