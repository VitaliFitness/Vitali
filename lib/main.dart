import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vitali/screen/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitali',
      theme: ThemeData(

      ),
      home: const SplashScreen(),
    );
  }
}
