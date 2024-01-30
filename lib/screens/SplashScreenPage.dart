import 'dart:async';
import 'package:daudy_app/screens/ChatPage.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // Timer for the splash screen duration
    Timer(const Duration(seconds: 4), () {
      // Navigate to the home page after 4 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0), // Adjust the gap as needed
          child: Image.asset(
            'assets/logo.png',
            height: 150,
            // You can set other properties like width, alignment, etc.
          ),
        ),
      ),
    );
  }
}
