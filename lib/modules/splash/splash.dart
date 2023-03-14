import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prayer/components/components.dart';
import 'package:prayer/modules/home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    log("hiiiiiiiiiiiiiiiiiiiii");
    Timer(const Duration(seconds: 3), () {
      navigatorAndPushReplacement(context: context, widget: Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
        Image.asset(
          "assets/ramadan.png",
          height: 150,
          width: 150,
        )
      ]),
    );
  }
}
