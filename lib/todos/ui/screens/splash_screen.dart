import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Get.to(() => MyApp());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/ceo.png'))),
            ),
            Text("Be Professional,\nBe Loyal.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
