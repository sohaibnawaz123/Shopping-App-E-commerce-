// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/orderModel.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:ecommerce_app/services/generateId.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';

void placeOrders(
    {required BuildContext context,
    required String name,
    required String phone,
    required String address,
    required String token}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please Wait...');
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        String orderId = generateId();
        Ordermodel orderModal = Ordermodel(
            productImage: data['productImage'],
            catId: data['catId'],
            catName: data['catName'],
            productId: data['productId'],
            productName: data['productName'],
            productDescription: data['productDescription'],
            productPrice: data['productPrice'],
            productSalePrice: data['productSalePrice'],
            isSale: data['isSale'],
            createdAt: DateTime.now(),
            updatedAt: data['updatedAt'],
            deliveryTime: data['deliveryTime'],
            productQuantity: data['productQuantity'],
            productTotalPrice: data['productTotalPrice'],
            customerId: user.uid,
            orderStatus: false,
            customerName: name,
            customerPhone: phone,
            customerAddress: address,
            customerDeviceToken: token);

        for (var i = 0; i < documents.length; i++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            'userId': user.uid,
            'customerName': name,
            'customerPhone': phone,
            'customerAddress': address,
            'customerDeviceToken': token,
            'orderStatus': false,
            'createdAt': DateTime.now()
          });
        }
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(user.uid)
            .collection('confirmOrders')
            .doc(orderId)
            .set(orderModal.toMap());

        await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .collection('cartOrders')
            .doc(orderModal.productId)
            .delete()
            .then((value) {
          // print('Delete ${orderModal.productId}');
        });
      }
      EasyLoading.dismiss();
      Get.snackbar(
        'Success',
        "Order Placed",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appSuccessColor,
        colorText: AppConstants.appTextColor,
      );
      Get.offAll(() => const MainScreen());
    } catch (e) {
      EasyLoading.dismiss();
      throw Exception(e);
    }
  }
}
