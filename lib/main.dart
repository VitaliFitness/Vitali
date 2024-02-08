import 'package:flutter/material.dart';

import 'package:vitali/main_tab.dart';



void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainTabView(key: GlobalKey()),
    );
  }
}
