import 'package:mongo_dart/mongo_dart.dart';

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

  Future<bool> signIn(String email, String password) async {
    await open();
    final user = await usersCollection.findOne(
      where.eq('email', email).eq('password', password),
    );
    await close();
    return user != null;
  }

  Future<String?> signUp(String email, String password, String role) async {
    await open();
    final existingUser = await usersCollection.findOne(where.eq('email', email));
    if (existingUser != null) {
      await close();
      return null; // already exists
    }
    final result = await usersCollection.insertOne({
      'email': email,
      'password': password,
      'role': role,
      'createdAt': DateTime.now(),
    });
    await close();
    return result.isSuccess ? result.id.toHexString() : null;
  }

  // 🔧 Add this missing method 👇
  Future<String?> getUserRole(String email) async {
    await open();
    final user = await usersCollection.findOne(where.eq('email', email));
    await close();
    return user?['role'] as String?;
  }
}
