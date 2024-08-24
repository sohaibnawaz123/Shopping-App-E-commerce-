// ignore_for_file: file_names

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';

class SigninController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //password visiblity
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signinMethod(
    String userEmail,
    String userPassword,
    
  ) async {
    try {
      EasyLoading.show(status: "Please Wait....");
      UserCredential usercredential =
          await _auth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword);

      
      EasyLoading.dismiss();
      return usercredential;
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
    return null;
  }
}
