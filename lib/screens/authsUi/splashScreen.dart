// ignore_for_file: file_names

import 'dart:async';

import 'package:ecommerce_app/controllers/getUserData_controller.dart';
import 'package:ecommerce_app/screens/admin-panel/adminPanel.dart';
import 'package:ecommerce_app/screens/authsUi/welcome-screen.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      isLoggedIn(context);
    });
  }

  Future<void>isLoggedIn(BuildContext context) async {
    if (user != null) {
      final GetuserdataController getuserdataController =
          Get.put(GetuserdataController());
      var userData = await getuserdataController.getData(user!.uid);
      if (userData[0]["isAdmin"] == true) {
        Get.offAll(() => const AdminPanel());
      } else {
        Get.offAll(() => const MainScreen());
      }
    } else {
      Get.offAll(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppConstants.appTextColor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                height: Get.height * 0.6,
                decoration: const BoxDecoration(
                  color: AppConstants.appMainColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                height: Get.height * 0.6,
                decoration: const BoxDecoration(
                  color: AppConstants.appTextColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.appMainName,
                      style: mainHeading(48, AppConstants.appMainColor),
                    ),
                    Text(
                      "Powered BY :${AppConstants.appPowerBy}",
                      style: appText(16, AppConstants.appMainColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

//top Cotainer
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: Get.width,
                height: Get.height * 0.4,
                decoration: const BoxDecoration(
                    color: AppConstants.appMainColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(100))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(
                    child: Lottie.asset("assets/images/splashIcon.json",
                        width: 300, height: 300, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}