// ignore_for_file: must_be_immutable
import '../../controllers/forgetPassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constant.dart';
import '../../widgets/textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgetpasswordController _forgetpasswordController =
      Get.put(ForgetpasswordController());
  final TextEditingController _controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: AppConstants.appTextColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(),
            elevation: 0,
            backgroundColor: AppConstants.appMainColor,
            title: Text(
              'Reset Password',
              style: mainHeading(28, AppConstants.appTextColor),
            ),
          ),
          body: SizedBox(
            width: Get.width,
            height: Get.height,
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
                      isKeyboardVisible
                          ? SizedBox(
                              width: Get.width * 0.8,
                              child: Text(
                                "\nEnter your email to sent Password Reset link",
                                style:
                                    mainHeading(24, AppConstants.appMainColor),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Center(
                              child: Lottie.asset(
                                  "assets/images/splashIcon.json",
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover),
                            ),
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: SizedBox(
                            width: Get.width * 0.9,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customTextField(
                                    _controllerEmail,
                                    TextInputType.emailAddress,
                                    "Email Address",
                                    const Icon(
                                      Icons.email_outlined,
                                      color: AppConstants.appMainColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.7,
                                    height: Get.height / 15,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              AppConstants.appMainColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          side: const BorderSide(
                                              style: BorderStyle.none)),
                                      onPressed: () async {
                                        String userEmail =
                                            _controllerEmail.text.trim();
                                        _forgetpasswordController
                                            .forgetPasswordMethod(userEmail);

                                        if (userEmail.isEmpty) {
                                          Get.snackbar(
                                              "Error", "Enter your Email",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor:
                                                  AppConstants.appErrorColor,
                                              colorText:
                                                  AppConstants.appTextColor);
                                        } else {}
                                      },
                                      child: Text(
                                        "Reset",
                                        style: mainHeading(
                                            22, AppConstants.appTextColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
