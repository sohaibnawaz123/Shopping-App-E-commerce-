// ignore_for_file: file_names

import 'package:ecommerce_app/screens/authsUi/signin_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../utils/constant.dart';

class ForgetpasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait....");
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        'Request sent Successfully',
        "Password reset link sent to: $userEmail",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appSuccessColor,
        colorText: AppConstants.appTextColor,
      );
      Get.offAll(() => SigninScreen());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appErrorColor,
        colorText: AppConstants.appTextColor,
      );
    }
  }
}
