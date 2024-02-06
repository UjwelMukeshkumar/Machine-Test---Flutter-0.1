import 'dart:async';
import 'package:flutter/material.dart';
import 'package:novindius/Presentation/pages/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LOGIN(), // Replace with your desired screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash1.png'), fit: BoxFit.cover)),
    );
  }
}
