import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'LogScreen/LogScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitali',
      theme: ThemeData(

      ),
      home: LogScreen(),
    );
  }
}