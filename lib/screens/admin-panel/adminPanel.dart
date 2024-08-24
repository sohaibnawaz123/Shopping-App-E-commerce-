// ignore_for_file: file_names

import 'package:ecommerce_app/screens/authsUi/welcome-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/constant.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () async {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signOut();
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  await googleSignIn.signOut();
                  Get.offAll(WelcomeScreen());
                },
                child: const Icon(
                  Icons.logout_outlined,
                  color: AppConstants.appTextColor,
                ))
          ],
          elevation: 0,
          backgroundColor: AppConstants.appMainColor,
          title: Text(
            'Admin Panel',
            style: mainHeading(28, AppConstants.appTextColor),
          ),
        ),
        body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: SafeArea(
                child: Stack(children: [
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
                          bottomRight: Radius.circular(100))))
            ]))));
  }
}
