// ignore_for_file: file_names

import 'package:ecommerce_app/utils/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class DeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        deviceToken = token;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "$e",
          backgroundColor: AppConstants.appErrorColor,
          colorText: AppConstants.appTextColor,
          snackPosition: SnackPosition.TOP);
    }
  }
}
