// ignore_for_file: file_names, must_be_immutable

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/reviewController.dart';
import 'package:ecommerce_app/modals/orderModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';
import '../../widgets/textfield.dart';

class FetchOrdersScreen extends StatelessWidget {
  FetchOrdersScreen({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  final Reviewcontroller _reviewcontroller = Get.put(Reviewcontroller());
  final TextEditingController reviewController = TextEditingController();
  double rate = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 5,
        iconTheme: const IconThemeData(),
        title:
            Text("Orders", style: mainHeading(32, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(user!.uid)
              .collection('confirmOrders')
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
                  "Order Not Found",
                  style: tittle(20, AppConstants.appErrorColor),
                ),
              );
            }
            if (snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 322,
                                // childAspectRatio: 0.65,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final orderData = snapshot.data!.docs[index];
                          Ordermodel ordermodel = Ordermodel(
                              productImage: orderData['productImage'],
                              catId: orderData['catId'],
                              catName: orderData['catName'],
                              productId: orderData['productId'],
                              productName: orderData['productName'],
                              productDescription:
                                  orderData['productDescription'],
                              productPrice: orderData['productPrice'],
                              productSalePrice: orderData['productSalePrice'],
                              isSale: orderData['isSale'],
                              createdAt: orderData['createdAt'],
                              updatedAt: orderData['updatedAt'],
                              deliveryTime: orderData['deliveryTime'],
                              productQuantity: orderData['productQuantity'],
                              productTotalPrice: orderData['productTotalPrice'],
                              customerId: orderData['customerId'],
                              orderStatus: orderData['orderStatus'],
                              customerName: orderData['customerName'],
                              customerPhone: orderData['customerPhone'],
                              customerAddress: orderData['customerAddress'],
                              customerDeviceToken:
                                  orderData['customerDeviceToken']);

                          return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: AppConstants.appMainColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          ordermodel.productImage[0],
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 200,
                                          alignment: Alignment.topCenter,
                                        )),
                                    Text(
                                      ordermodel.productName,
                                      style: mainHeading(
                                          28, AppConstants.appMainColor),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "${ordermodel.productPrice} x ${ordermodel.productQuantity}",
                                      style: mainHeading(
                                          24, AppConstants.appMainColor),
                                      textAlign: TextAlign.left,
                                    ),
                                    ordermodel.orderStatus == true
                                        ? Text(
                                            "Order Status : Deliverd...",
                                            style: mainHeading(
                                                16, AppConstants.appErrorColor),
                                            textAlign: TextAlign.left,
                                          )
                                        : Text(
                                            "Order Status : Pending...",
                                            style: mainHeading(16,
                                                AppConstants.appSuccessColor),
                                            textAlign: TextAlign.left,
                                          ),
                                    ordermodel.orderStatus == true
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    Size(Get.width, 40),
                                                backgroundColor:
                                                    AppConstants.appMainColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {
                                              placeOrderSheet(context,
                                                  productId:
                                                      ordermodel.productId,
                                                  productName:
                                                      ordermodel.productName,
                                                  customerName:
                                                      ordermodel.customerName);
                                            },
                                            child: Text(
                                              "Review",
                                              style: mainHeading(18,
                                                  AppConstants.appTextColor),
                                              textAlign: TextAlign.left,
                                            ))
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ));
                        })),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }

  void placeOrderSheet(context,
      {required String productId,
      required String productName,
      required String customerName}) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppConstants.appTextColor),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate The Product",
                    style: mainHeading(28, AppConstants.appMainColor),
                  ),
                  AnimatedRatingStars(
                    initialRating: 1,
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: AppConstants.appyellowColor,
                    emptyColor: AppConstants.appMainColor,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star_border,
                    onChanged: (double rating) {
                      // Handle the rating change here
                      rate = rating;
                    },
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star_half,
                    customEmptyIcon: Icons.star_border,
                    starSize: 30.0,
                    animationDuration: const Duration(milliseconds: 300),
                    animationCurve: Curves.easeInOut,
                    readOnly: false,
                  ),
                ],
              ),
              customTextField(
                reviewController,
                TextInputType.text,
                textInputAction: TextInputAction.next,
                "Feed Back",
                const Icon(
                  Icons.reviews_outlined,
                  color: AppConstants.appMainColor,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width, 50),
                      backgroundColor: AppConstants.appMainColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    _reviewcontroller
                        .addReview(rate, reviewController.text.trim(),
                            productId, productName, customerName)
                        .then((value) {
                      reviewController.clear();
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Confirm Order",
                    style: mainHeading(28, AppConstants.appTextColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
