// ignore_for_file: file_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/orderModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';

class FetchOrdersScreen extends StatelessWidget {
  FetchOrdersScreen({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 5,
        iconTheme: const IconThemeData(),
        title:
            Text("Orders", style: mainHeading(28, AppConstants.appTextColor)),
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
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,childAspectRatio: 0.75,mainAxisSpacing: 10,crossAxisSpacing: 10),
                            itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final orderData = snapshot.data!.docs[index];
                          Ordermodel ordermodel = Ordermodel(
                              productImage: orderData['productImage'],
                              catId: orderData['catId'],
                              catName: orderData['catName'],
                              productId: orderData['productId'],
                              productName: orderData['productName'],
                              productDescription: orderData['productDescription'],
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
                                width: 3,color: AppConstants.appMainColor
                              ),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(ordermodel.productImage[0],fit:BoxFit.cover,height: 150,width:200,alignment: Alignment.topCenter,)),
                                  Text(ordermodel.productName,style: mainHeading(28, AppConstants.appMainColor),textAlign: TextAlign.left,),
                                  Text("${ordermodel.productPrice} x ${ordermodel.productQuantity}",style: mainHeading(24, AppConstants.appMainColor),textAlign: TextAlign.left,),

                                  ordermodel.orderStatus==true? Text("Order Status : Deliverd...",style: mainHeading(16, AppConstants.appErrorColor),textAlign: TextAlign.left,):Text("Order Status : Pending...",style: mainHeading(16, AppConstants.appSuccessColor),textAlign: TextAlign.left,)
                                ],
                              ),
                            )
                          );
                        })),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}

// ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
                      
//                       })