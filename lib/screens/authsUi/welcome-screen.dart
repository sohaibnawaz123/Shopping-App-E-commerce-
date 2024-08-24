// ignore_for_file: file_names

import 'package:ecommerce_app/screens/authsUi/signin_screen.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/googleSignin_Controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final GooglesigninController _googlesigninController =
      Get.put(GooglesigninController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.appMainColor,
        title: Text(
          'Welcome To App',
          style: mainHeading(28, AppConstants.appTextColor),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: AppConstants.appMainColor,
              ),
              Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.asset("assets/images/splashIcon.json",
                          width: 300, height: 300, fit: BoxFit.cover),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.7,
                            height: Get.height / 15,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppConstants.appMainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    side: const BorderSide(
                                        style: BorderStyle.none)),
                                onPressed: () {
                                  _googlesigninController.signInWithGoogle();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      "Sign In With Google",
                                      style: mainHeading(
                                          22, AppConstants.appTextColor),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: Get.width * 0.7,
                            height: Get.height / 15,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: AppConstants.appMainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    side: const BorderSide(
                                        style: BorderStyle.none)),
                                onPressed: () {
                                  Get.to(SigninScreen());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/images/gmail.png',
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      "Sign In With Email",
                                      style: mainHeading(
                                          22, AppConstants.appTextColor),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
