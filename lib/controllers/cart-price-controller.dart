// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartTotalPriceController extends GetxController {
  RxDouble totalPrice = 0.0.obs;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchProductPrice();
  }

  void fetchProductPrice() async {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(user!.uid)
        .collection('cartOrders')
        .snapshots()
        .listen((snapshot) {
      double sum = 0.0;

      // Check if there are items in the cart
      if (snapshot.docs.isNotEmpty) {
        for (final doc in snapshot.docs) {
          final data = doc.data();
          if (data != null && data.containsKey('productTotalPrice')) {
            sum += (data['productTotalPrice'] as num).toDouble();
          }
        }
      }

      // Update totalPrice with the calculated sum (0.0 if no items)
      totalPrice.value = sum;
    });
  }
}
