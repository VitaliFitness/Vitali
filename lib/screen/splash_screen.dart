import 'package:flutter/material.dart';
import 'package:vitali/screen/welcome_screen.dart';



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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
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
