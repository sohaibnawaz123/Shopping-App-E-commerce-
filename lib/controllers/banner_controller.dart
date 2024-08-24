import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constant.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);
  @override
  void onInit() {
    super.onInit();
    fetchBannersUrl();
  }

  Future<void> fetchBannersUrl() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection("banners").get();
      if (bannersSnapshot.docs.isNotEmpty) {
        bannerUrls.value =
            bannersSnapshot.docs.map((doc) => doc['imgUrl'] as String).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppConstants.appErrorColor,
          colorText: AppConstants.appTextColor);
    }
  }
}
