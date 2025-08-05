import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class MongoDBService {
  final Db db;
  late final DbCollection usersCollection;

  MongoDBService(String connectionString) : db = Db(connectionString);

  Future<void> open() async {
    if (!db.isConnected) {
      await db.open();
      usersCollection = db.collection('users');
    }
  }

  Future<void> close() async {
    await db.close();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> signIn(String email, String password) async {
    await open();
    final user = await usersCollection.findOne(where.eq('email', email));
    if (user == null) {
      await close();
      return false;
    }
    final hashedPassword = user['password'] as String;
    final inputHashed = _hashPassword(password);
    await close();
    return hashedPassword == inputHashed;
  }

  Future<String?> signUp(String email, String password, String role) async {
    await open();
    final existingUser = await usersCollection.findOne(where.eq('email', email));
    if (existingUser != null) {
      await close();
      return null; // already exists
    }
    final hashedPassword = _hashPassword(password);
    final result = await usersCollection.insertOne({
      'email': email,
      'password': hashedPassword,
      'role': role,
      'createdAt': DateTime.now(),
    });
    await close();
    return result.isSuccess ? result.id.toHexString() : null;
  }

  Future<String?> getUserRole(String email) async {
    await open();
    final user = await usersCollection.findOne(where.eq('email', email));
    await close();
    return user?['role'] as String?;
  }
}
