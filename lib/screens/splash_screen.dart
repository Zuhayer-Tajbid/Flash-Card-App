import 'dart:async';

import 'package:flash_card/colors.dart';
import 'package:flash_card/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DeckScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bodyC,
        child: Center(
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/start.png'))),
          ),
        ),
      ),
    );
  }
}
