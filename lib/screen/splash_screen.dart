import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitali/screen/welcome_screen.dart';

import '../main_tab.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Future.delayed(
        const Duration(seconds: 4),(){
      final User? user = FirebaseAuth.instance.currentUser;
      print(user);

      //Further, if the user is already sign-in it will directly give the
      //user access into the application to reserve ticket
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainTabView(key: UniqueKey(), userEmail: '')
          ),
        );
      }
      //If the user is not sign-in, it will ask the user to sign-in
      //by navigating to login screen
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white30,
            child: Center(
              child: Image.asset(
                'images/vitali.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
        ),
    );
  }
}
