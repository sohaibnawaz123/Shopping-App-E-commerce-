// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/product_modal.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screens/user-panel/productDetailScreen.dart';

class SaleProductWidget extends StatelessWidget {
  const SaleProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where('isSale', isEqualTo: true).limit(10)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return SizedBox(
              height: Get.height / 5,
              child: ListView.builder(
                
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ProductModal productModal = ProductModal(
                        productImage: snapshot.data!.docs[index]
                            ['productImage'],
                        catId: snapshot.data!.docs[index]['catId'],
                        catName: snapshot.data!.docs[index]['catName'],
                        productId: snapshot.data!.docs[index]['productId'],
                        productName: snapshot.data!.docs[index]['productName'],
                        productDescription: snapshot.data!.docs[index]
                            ['productDescription'],
                        productPrice: snapshot.data!.docs[index]
                            ['productPrice'],
                        productSalePrice: snapshot.data!.docs[index]
                            ['productSalePrice'],
                        isSale: snapshot.data!.docs[index]['isSale'],
                        createAt: snapshot.data!.docs[index]['createAt'],
                        deliveryTime: snapshot.data!.docs[index]
                            ['deliveryTime']);
                    return Row(
                      children: [
                        GestureDetector(onTap: ()=>Get.to(ProductDetailScreen(productModal: productModal,)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FillImageCard(
                              tagRunSpacing: 0.0,
                              tagSpacing: 0.0,
                              color: AppConstants.appSecondryColor,
                              borderRadius: 20.0,
                              width: Get.width / 3.5,
                              heightImage: Get.height / 12,
                              imageProvider: CachedNetworkImageProvider(
                                productModal.productImage[0],
                              ),
                              title: Center(
                                  child: Text(
                                productModal.productName,
                                style: mainHeading(18, AppConstants.appTextColor,
                                    fontweight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              )),
                              footer: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Rs ${productModal.productSalePrice}',
                                    style: tittle(12, AppConstants.appTextColor),
                                  ),Text(
                                    productModal.productPrice,
                                    style: tittle(12, AppConstants.appErrorColor,
                                        decoration: TextDecoration.lineThrough,dcolor: AppConstants.appErrorColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
          return const Text("data");
        });
  }
}
