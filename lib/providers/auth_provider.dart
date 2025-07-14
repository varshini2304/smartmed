import 'package:flutter/material.dart';
import '../services/mongodb_service.dart';

class AuthProvider with ChangeNotifier {
  final MongoDBService _mongoDBService = MongoDBService('mongodb+srv://varshini:admin@cluster0.xlcqu.mongodb.net/smartmed');

  String? _userId;
  String? _role;

  String? get userId => _userId;
  String? get role => _role;

  AuthProvider();

  Future<void> signIn(String email, String password) async {
    final success = await _mongoDBService.signIn(email, password);
    if (success) {
      // For simplicity, userId is email here
      _userId = email;
      _role = await _mongoDBService.getUserRole(email);
      notifyListeners();
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> signUp(String email, String password, String role) async {
    final userId = await _mongoDBService.signUp(email, password, role);
    if (userId != null) {
      _userId = userId;
      _role = role;
      notifyListeners();
    } else {
      throw Exception('User already exists');
    }
  }

  Future<void> signOut() async {
    _userId = null;
    _role = null;
    notifyListeners();
  }
}
