import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/reviewModel.dart';
import 'package:ecommerce_app/services/generateId.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';

class Reviewcontroller extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addReview(double rate, String feedback, String productId,
      String productName, String customerName) async {
    try {
      if (feedback.isNotEmpty &&
          productId.isNotEmpty &&
          productName.isNotEmpty &&
          customerName.isNotEmpty) {
        var reviewId = generateId();
        Reviewmodel reviewmodel = Reviewmodel(
            reviewId: reviewId,
            rate: rate,
            productId: productId,
            productName: productName,
            customerName: customerName,
            createdAt: DateTime.now(),
            feedback: feedback);
        await _firebaseFirestore
            .collection('reviews')
            .doc(reviewId)
            .set(reviewmodel.toMap());
        Get.snackbar("Success", "Review Submitted....",
            backgroundColor: AppConstants.appSuccessColor,
            colorText: AppConstants.appTextColor,
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "Fill The Feilds",
            backgroundColor: AppConstants.appErrorColor,
            colorText: AppConstants.appTextColor,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
