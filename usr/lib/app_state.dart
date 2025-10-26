import 'package:flutter/material.dart';
import 'models/user_model.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userRole = UserRole.client;

  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

  void login(String role) {
    _isLoggedIn = true;
    _userRole = role;
    notifyListeners();
    // NOTE: Actual authentication requires Supabase backend - this is UI simulation only
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}