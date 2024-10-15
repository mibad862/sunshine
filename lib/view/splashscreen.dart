// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/controller/motion_detection_controller.dart';
import 'package:sunshine_app/view/home_screen.dart';
import 'package:sunshine_app/view/ipad3.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
    var accessToken = getStringAsync('auth_token');
    Future.delayed(const Duration(seconds: 5), () {
      if (accessToken == "") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserStatus(),
            ));
      }
    });
  }

  @override
  void initState() {
    Provider.of<MotionDetectionController>(context, listen: false)
        .checkPermissionsAndListenLocation();
    navigationPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          SizedBox(
            height: 235,
            width: MediaQuery.sizeOf(context).width * .75,
            child: Center(
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sunshine Driver Portal",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                Text('1.0.0+1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
