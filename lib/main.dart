import 'package:flutter/material.dart';
import 'package:projects/features/auth/domain/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: WidgetTree()),
    );
  }
}
//Add Google Sign In for better Accessibility
//Start Working on the HomeScreen
