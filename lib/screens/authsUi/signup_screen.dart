// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/deviceToken_controller.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';
import '../../widgets/textfield.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignupController signupController = Get.put(SignupController());
  final DeviceTokenController deviceTokenController =
      Get.put(DeviceTokenController());
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerphone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: AppConstants.appTextColor,
        appBar: AppBar(
          toolbarHeight: 80,
          iconTheme: const IconThemeData(),
          elevation: 0,
          backgroundColor: AppConstants.appMainColor,
          title: Text(
            'Sign-Up',
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
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: isKeyboardVisible ? 5 : 10),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Welcome !\nFill The Details To Sign-Up",
                          style: mainHeading(24, AppConstants.appMainColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Get.width * 0.9,
                                child: customTextField(
                                  _controllerUsername,
                                  TextInputType.text,
                                  "Full Name",
                                  const Icon(
                                    Icons.person_4_outlined,
                                    color: AppConstants.appMainColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: Get.width * 0.9,
                                child: customTextField(
                                  _controllerEmail,
                                  TextInputType.emailAddress,
                                  "Email Address",
                                  const Icon(
                                    Icons.email_outlined,
                                    color: AppConstants.appMainColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: Get.width * 0.9,
                                child: customTextField(
                                  _controllerphone,
                                  TextInputType.number,
                                  "Phone #",
                                  const Icon(
                                    Icons.phone,
                                    color: AppConstants.appMainColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => SizedBox(
                                  width: Get.width * 0.9,
                                  child: customTextField(
                                    hideText: signupController
                                        .isPasswordVisible.value,
                                    suffixicon: GestureDetector(
                                        onTap: () {
                                          signupController.isPasswordVisible
                                              .toggle();
                                        },
                                        child: signupController
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
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: Get.width * 0.7,
                                height: Get.height / 15,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: AppConstants.appMainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    side: const BorderSide(
                                        style: BorderStyle.none),
                                  ),
                                  onPressed: () async {
                                    String userName =
                                        _controllerUsername.text.trim();
                                    String userEmail =
                                        _controllerEmail.text.trim();
                                    String userPhone =
                                        _controllerphone.text.trim();
                                    String userPassword =
                                        _controllerPassword.text.trim();
                                    String userDeviceToken =
                                        deviceTokenController.deviceToken
                                            .toString();
                                    if (userName.isEmpty ||
                                        userEmail.isEmpty ||
                                        userPhone.isEmpty ||
                                        userPassword.isEmpty) {
                                      Get.snackbar(
                                          'Error', "Please enter all Details",
                                          backgroundColor:
                                              AppConstants.appErrorColor,
                                          colorText: AppConstants.appTextColor,
                                          snackPosition: SnackPosition.TOP);
                                    } else {
                                      UserCredential? usercredential =
                                          await signupController.signupMethod(
                                              userName,
                                              userEmail,
                                              userPhone,
                                              userPassword,
                                              userDeviceToken);
                                      if (usercredential != null) {
                                        Get.snackbar('Verification Email Sent',
                                            "Please Check Your Email",
                                            backgroundColor:
                                                AppConstants.appSuccessColor,
                                            colorText:
                                                AppConstants.appTextColor,
                                            snackPosition: SnackPosition.TOP);
                                        FirebaseAuth.instance.signOut();
                                        Get.offAll(SigninScreen());
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Sign-Up",
                                    style: mainHeading(
                                        22, AppConstants.appTextColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => Get.to(SigninScreen()),
                                child: Text(
                                  "Already have account? Sign-in",
                                  style: tittle(16, AppConstants.appMainColor),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
