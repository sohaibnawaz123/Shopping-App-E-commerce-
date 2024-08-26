// ignore_for_file: file_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import '../../modals/cartModal.dart';
import '../../utils/constant.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 5,
        iconTheme: const IconThemeData(),
        title:
            Text("My Cart", style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
              .snapshots(),
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
              return SizedBox(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final cartData = snapshot.data!.docs[index];
                        CartModel cartModal = CartModel(
                            productImage: cartData['productImage'],
                            catId: cartData['catId'],
                            catName: cartData['catName'],
                            productId: cartData['productId'],
                            productName: cartData['productName'],
                            productDescription: cartData['productDescription'],
                            productPrice: cartData['productPrice'],
                            productSalePrice: cartData['productSalePrice'],
                            isSale: cartData['isSale'],
                            createdAt: cartData['createdAt'],
                            updatedAt: cartData['updatedAt'],
                            deliveryTime: cartData['deliveryTime'],
                            productQuantity: cartData['productQuantity'],
                            productTotalPrice: cartData['productTotalPrice']);
                        return SwipeActionCell(
                          key: ObjectKey(cartModal.productId),
                          leadingActions: [
                            SwipeAction(
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: AppConstants.appTextColor,
                                ),
                                color: AppConstants.appSecondryColor,
                                backgroundRadius: 20,
                                forceAlignmentToBoundary: true,
                                performsFirstActionWithFullSwipe: true,
                                onTap: (CompletionHandler handler) async {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModal.productId)
                                      .delete();
                                })
                          ],
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                cartModal.productName,
                                style:
                                    mainHeading(20, AppConstants.appMainColor),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppConstants.appOrangeColor,
                                backgroundImage:
                                    NetworkImage(cartModal.productImage[0]),
                                child: Text(
                                  cartModal.productName[0],
                                  style: mainHeading(
                                      20, AppConstants.appMainColor),
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs ${cartModal.productTotalPrice.toString()}',
                                    style: tittle(
                                        18, AppConstants.appSecondryColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                minimumSize: Size(
                                                    Get.width / 15,
                                                    Get.height / 40),
                                                backgroundColor: AppConstants
                                                    .appSecondryColor),
                                            onPressed: () async {
                                              if (cartModal.productQuantity >
                                                  1) {
                                                await FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(user!.uid)
                                                    .collection('cartOrders')
                                                    .doc(cartModal.productId)
                                                    .update({
                                                  'productQuantity': cartModal
                                                          .productQuantity -
                                                      1,
                                                  'productTotalPrice': (double
                                                              .parse(cartModal.isSale?cartModal
                                                                  .productSalePrice:cartModal.productPrice) *
                                                          (cartModal
                                                              .productQuantity -1))
                                                });
                                              }
                                            },
                                            child: Text(
                                              '-',
                                              style: tittle(24,
                                                  AppConstants.appTextColor),
                                            )),
                                        SizedBox(
                                          width: Get.width / 20,
                                          child: Text(
                                            cartModal.productQuantity
                                                .toString(),
                                            style: mainHeading(28,
                                                AppConstants.appSecondryColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                minimumSize: Size(
                                                    Get.width / 15,
                                                    Get.height / 40),
                                                backgroundColor: AppConstants
                                                    .appSecondryColor),
                                            onPressed: () async{
                                              if (cartModal.productQuantity >
                                                  0) {
                                                await FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(user!.uid)
                                                    .collection('cartOrders')
                                                    .doc(cartModal.productId)
                                                    .update({
                                                  'productQuantity': cartModal
                                                          .productQuantity +
                                                      1,
                                                  'productTotalPrice': (double
                                                              .parse(cartModal.isSale?cartModal
                                                                  .productSalePrice:cartModal.productPrice) *
                                                          (cartModal
                                                              .productQuantity +1))
                                                });
                                              }
                                            },
                                            child: Text(
                                              '+',
                                              style: tittle(24,
                                                  AppConstants.appTextColor),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
            }
            return const Text("data");
          }),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height / 8,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppConstants.appSecondryColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "SUB TOTAL=",
                    style: mainHeading(24, AppConstants.appTextColor,
                        fontweight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Rs: 3000",
                    style: mainHeading(24, AppConstants.appTextColor),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      maximumSize: const Size(120, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Checkout",
                        style: mainHeading(20, AppConstants.appSecondryColor),
                      ),
                      const Icon(
                        Icons.shopping_cart_checkout_outlined,
                        color: AppConstants.appSecondryColor,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
