import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campus_connect/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // NOTE: You need to add your firebase_options.dart file
  // Run: flutterfire configure
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: CampusConnectApp()));
}
