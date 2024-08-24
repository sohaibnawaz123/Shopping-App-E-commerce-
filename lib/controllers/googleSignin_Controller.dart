// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/deviceToken_controller.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../modals/user_modal.dart';

class GooglesigninController extends GetxController {
  final GoogleSignIn googlesignin = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    final DeviceTokenController deviceTokenController =
        Get.put(DeviceTokenController());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googlesignin.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please Wait .......");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImg: user.photoURL.toString(),
              userDeviceToken: deviceTokenController.deviceToken.toString(),
              country: "",
              userAddress: "",
              street: "",
              isAdmin: false,
              isActive: true,
              createOn: DateTime.now());

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap());
          EasyLoading.dismiss();
          Get.offAll(const MainScreen());
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Error: $e");
    }
  }
}
