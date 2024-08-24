// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/product_modal.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import 'productDetailScreen.dart';

class SingleCategoryProductScreen extends StatelessWidget {
  String catId;
  String catName;
  SingleCategoryProductScreen(
      {super.key, required this.catId, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: Text("Category: $catName",
            style: mainHeading(24, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .where("catId", isEqualTo: catId)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error",
                  style: tittle(20, AppConstants.appErrorColor),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: Get.height / 5,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    color: AppConstants.appyellowColor,
                  ),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No Product Found",
                  style: tittle(20, AppConstants.appErrorColor),
                ),
              );
            }
            if (snapshot.data != null) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1),
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModal productModal = ProductModal(
                        productImage: productData['productImage'],
                        catId: productData['catId'],
                        catName: productData['catName'],
                        productId: productData['productId'],
                        productName: productData['productName'],
                        productDescription: productData['productDescription'],
                        productPrice: productData['productPrice'],
                        productSalePrice: productData['productSalePrice'],
                        isSale: productData['isSale'],
                        createAt: productData['createAt'],
                        deliveryTime: productData['deliveryTime']);
                    return GestureDetector(onTap:()=> Get.to(ProductDetailScreen(productModal:productModal,)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          width: Get.width * 0.5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FillImageCard(
                                tagRunSpacing: 0.0,
                                tagSpacing: 0.0,
                                color: AppConstants.appSecondryColor,
                                borderRadius: 20.0,
                                width: Get.width * 0.45,
                                heightImage: Get.height / 6,
                                imageProvider: CachedNetworkImageProvider(
                                  productModal.productImage[0],
                                ),
                                title: Center(
                                    child: Text(
                                  productModal.productName,
                                  style: mainHeading(
                                      18, AppConstants.appTextColor,
                                      fontweight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Text("data");
          }),
    );
  }
}
