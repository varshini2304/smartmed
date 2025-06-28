import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'mongodb_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const SmartMedApp(),
    ),
  );
}
