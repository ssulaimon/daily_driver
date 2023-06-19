import 'package:flutter/material.dart';

class ButtonState extends ChangeNotifier {
  String _buttonTitle = 'Create Account';
  String get buttonTitle => _buttonTitle;
  set buttonTitle(String message) {
    _buttonTitle = message;
    notifyListeners();
  }

  String _login = 'Login';
  String get login => _login;
  set login(String message) {
    _login = message;
    notifyListeners();
  }
}
