import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/main_home_screen.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/screens/on_boarding/on_boarding_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget home;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget nextScreen()
  {
    if (onBoarding != null) {
      if (uId != null) {
        home =  MainHomeScreen();
      } else {
        home = LoginScreen();
      }
    } else {
      home = const OnBoardingScreen();
    }
    return home;
  }
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => nextScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Image.asset('assets/images/trifecta.png'),
      ),
    );
  }
}
