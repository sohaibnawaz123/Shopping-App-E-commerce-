// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/cartModal.dart';
import 'package:ecommerce_app/modals/product_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';

class ProductDetailScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  ProductModal productModal;

  ProductDetailScreen({super.key, required this.productModal});
  var isFav = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 2,
        iconTheme: const IconThemeData(),
        title: Text("Product Detail",
            style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //productSlider
              Container(
                width: Get.width - 10,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3, color: AppConstants.appSecondryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: CarouselSlider(
                    items: productModal.productImage
                        .map((imageUrls) => ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: CachedNetworkImage(
                                imageUrl: imageUrls,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                width: Get.width,
                                placeholder: (context, url) => const ColoredBox(
                                  color: Colors.white,
                                  child: Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        viewportFraction: 1,
                        height: Get.height * 0.3,
                        scrollPhysics: const ScrollPhysics())),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  width: Get.width,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(60),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        side: BorderSide(
                            width: 3, color: AppConstants.appSecondryColor)),
                    color: AppConstants.appTextColor,
                    elevation: 1,
                    shadowColor: AppConstants.appSecondryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productModal.productName,
                                    style: mainHeading(
                                        28, AppConstants.appMainColor,
                                        fontweight: FontWeight.w600)),
                                const Icon(
                                  Icons.favorite,
                                  color: AppConstants.appErrorColor,
                                )
                              ],
                            ),
                            const Divider(
                              height: 10,
                              thickness: 2,
                              color: AppConstants.appMainColor,
                            ),
                            Text(
                              "Category Name: ${productModal.catName}",
                              style: mainHeading(
                                  20, AppConstants.appSecondryColor,
                                  fontweight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              productModal.productDescription,
                              style: tittle(
                                14,
                                AppConstants.appMainColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                productModal.isSale == true
                                    ? Text(
                                        "Rs ${productModal.productSalePrice}",
                                        style: mainHeading(
                                            32, AppConstants.appSecondryColor,
                                            fontweight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      )
                                    : Text(
                                        "Rs ${productModal.productPrice}",
                                        style: mainHeading(
                                            32, AppConstants.appSecondryColor,
                                            fontweight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      ),
                                SizedBox(
                                  width: Get.width * 0.45,
                                  height: Get.height / 19,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          backgroundColor:
                                              AppConstants.appSecondryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          side: const BorderSide(
                                              style: BorderStyle.none)),
                                      onPressed: () async {
                                        checkProductExistence(uId: user!.uid);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Add To Cart",
                                            style: mainHeading(
                                                24, AppConstants.appTextColor),
                                          ),
                                          const Icon(
                                            Icons.add_shopping_cart_outlined,
                                            color: AppConstants.appTextColor,
                                          )
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(productModal.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(productModal.isSale
              ? productModal.productSalePrice
              : productModal.productPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });

      print("product exists");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId': uId,
          'createdAt': DateTime.now(),
        },
      );

      CartModel cartModel = CartModel(
        productId: productModal.productId,
        catId: productModal.catId,
        productName: productModal.productName,
        catName: productModal.catName,
        productSalePrice: productModal.productSalePrice,
        productPrice: productModal.productPrice,
        productImage: productModal.productImage,
        deliveryTime: productModal.deliveryTime,
        isSale: productModal.isSale,
        productDescription: productModal.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(productModal.isSale
            ? productModal.productSalePrice
            : productModal.productPrice),
      );

      await documentReference.set(cartModel.toMap());

      print("product added");
    }
  }
}
