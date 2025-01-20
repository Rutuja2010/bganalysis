import 'dart:async';

import 'package:bganalysis/page/homePage.dart';
import 'package:bganalysis/page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String? stringValue; // Make it nullable

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    await getStringValuesSF();
    Timer(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                stringValue != null ? HomePage() : loginPage(),
          ),
        );
      },
    );
  }

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      stringValue = prefs.getString('appKeyCode');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 247, 250, 247),
      child: Image.asset(
        'assets/bglogo.jpeg',
      ),
    );
  }
}
