// ignore_for_file: body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../modals/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../utils/constant.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //password visiblity
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signupMethod(
    String userName,
    String userEmail,
    String userPhone,
    String userPassword,
    String userDeviceToken,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait....");
      UserCredential usercredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      //send Email
      await usercredential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          uId: usercredential.user!.uid,
          username: userName,
          email: userEmail,
          phone: userPhone,
          userImg: "",
          userDeviceToken: userDeviceToken,
          country: "",
          userAddress: "",
          street: "",
          isAdmin: false,
          isActive: true,
          createOn: DateTime.now());

      //Send to Fire Store
      _fireStore
          .collection('users')
          .doc(usercredential.user!.uid)
          .set(userModel.toMap());
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
  }
}
