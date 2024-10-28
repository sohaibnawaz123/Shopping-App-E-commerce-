// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:ecommerce_app/screens/admin-panel/adminPanel.dart';
import 'package:ecommerce_app/screens/authsUi/forgetpassword_screen.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/getUserData_controller.dart';
import '../../controllers/signIn_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constant.dart';
import '../../widgets/textfield.dart';
import 'signup_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final SigninController signinController = Get.put(SigninController());
  final GetuserdataController _getuserdataController =
      Get.put(GetuserdataController());
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
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
              'Sign-In',
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
                          ? Text(
                              "\nWelcome !\nFill The Details To Sign-Up",
                              style: mainHeading(24, AppConstants.appMainColor),
                              textAlign: TextAlign.center,
                            )
                          : Center(
                              child: Lottie.asset(
                                  "assets/images/splashIcon.json",
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover),
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
                                  Obx(
                                    () => customTextField(
                                      hideText: signinController
                                          .isPasswordVisible.value,
                                      suffixicon: GestureDetector(
                                          onTap: () => signinController
                                              .isPasswordVisible
                                              .toggle(),
                                          child: signinController
                                                  .isPasswordVisible.value
                                              ? const Icon(
                                                  Icons.visibility_off,
                                                  color:
                                                      AppConstants.appMainColor,
                                                )
                                              : const Icon(
                                                  Icons.visibility,
                                                  color:
                                                      AppConstants.appMainColor,
                                                )),
                                      _controllerPassword,
                                      TextInputType.text,
                                      "Password",
                                      const Icon(
                                        Icons.password_outlined,
                                        color: AppConstants.appMainColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.to(ForgetPasswordScreen()),
                                    child: Text(
                                      "Forget Password",
                                      style: tittle(
                                        16,
                                        AppConstants.appMainColor,
                                      ),
                                      textAlign: TextAlign.end,
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
                                        String userPassword =
                                            _controllerPassword.text.trim();

                                        if (userEmail.isEmpty ||
                                            userPassword.isEmpty) {
                                          Get.snackbar(
                                              "Error", "Fill all feilds",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor:
                                                  AppConstants.appErrorColor,
                                              colorText:
                                                  AppConstants.appTextColor);
                                        } else {
                                          UserCredential? usercredential =
                                              await signinController
                                                  .signinMethod(
                                                      userEmail, userPassword);
                                          var userData =
                                              await _getuserdataController
                                                  .getData(usercredential!.user!.uid);
                                          if (usercredential != null) {
                                            if (usercredential
                                                .user!.emailVerified) {
                                                  if (userData[0]['isAdmin']== true) {
                                                    Get.offAll(const AdminPanel());
                                                    Get.snackbar("Success",
                                                  "Admin Login Successfull",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: AppConstants
                                                      .appSuccessColor,
                                                  colorText: AppConstants
                                                      .appTextColor);
                                                  }else{
                                                    Get.offAll(MainScreen());
                                                    Get.snackbar("Success",
                                                  "Login Successfull",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: AppConstants
                                                      .appSuccessColor,
                                                  colorText: AppConstants
                                                      .appTextColor);
                                                  }
                                                  
                                            } else {
                                              Get.snackbar(
                                                  "Error", "Email Not Verified",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: AppConstants
                                                      .appErrorColor,
                                                  colorText: AppConstants
                                                      .appTextColor);
                                            }
                                          } else {
                                            Get.snackbar("Error", "Try Again",
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                backgroundColor:
                                                    AppConstants.appErrorColor,
                                                colorText:
                                                    AppConstants.appTextColor);
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Sign-In",
                                        style: mainHeading(
                                            22, AppConstants.appTextColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.to(SignUpScreen()),
                                    child: Text(
                                      "Don't have account? Sign-up",
                                      style: tittle(
                                        16,
                                        AppConstants.appMainColor,
                                      ),
                                      textAlign: TextAlign.end,
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
