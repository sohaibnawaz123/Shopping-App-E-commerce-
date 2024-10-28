// ignore_for_file: file_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/cart-price-controller.dart';
import 'package:ecommerce_app/controllers/deviceToken_controller.dart';
import 'package:ecommerce_app/services/placeOrders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modals/cartModal.dart';
import '../../utils/constant.dart';
import '../../widgets/textfield.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final CartTotalPriceController cartTotalPriceController =
      Get.put(CartTotalPriceController());
  final DeviceTokenController _deviceTokenController =
      Get.put(DeviceTokenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 5,
        iconTheme: const IconThemeData(),
        title:
            Text("Checkout", style: mainHeading(28, AppConstants.appTextColor)),
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
                        cartTotalPriceController.fetchProductPrice();

                        return Container(
                          height: 160,
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppConstants.appTextColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Color.fromARGB(139, 33, 157, 188),
                                    blurRadius: 5,
                                    spreadRadius: 0),
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        cartModal.productName,
                                        style: mainHeading(
                                            32, AppConstants.appMainColor),
                                      ),
                                      Text(
                                        '${cartModal.productPrice} x ${cartModal.productQuantity}',
                                        style: mainHeading(
                                            28, AppConstants.appMainColor),
                                      ),
                                      Text(
                                        'Category : ${cartModal.catName}',
                                        style: mainHeading(
                                            18, AppConstants.appMainColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        cartModal.productImage[0],
                                        fit: BoxFit.cover,
                                        scale: 1,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }));
            }
            return const Text("data");
          }),
      bottomNavigationBar: Container(
        width: Get.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppConstants.appyellowColor),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width, 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                placeOrderSheet(context);
              },
              child: Text(
                "Place Order",
                style: mainHeading(28, AppConstants.appSecondryColor),
              )),
        ),
      ),
    );
  }

  void placeOrderSheet(context) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 2.5,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: AppConstants.appyellowColor),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customTextField(
                _nameController,
                TextInputType.text,
                textInputAction: TextInputAction.next,
                "Name",
                const Icon(
                  Icons.person,
                  color: AppConstants.appMainColor,
                ),
              ),
              customTextField(
                _phoneController,
                TextInputType.number,
                textInputAction: TextInputAction.next,
                "Phone #",
                const Icon(
                  Icons.phone,
                  color: AppConstants.appMainColor,
                ),
              ),
              customTextField(
                _addressController,
                TextInputType.text,
                textInputAction: TextInputAction.done,
                "Address",
                const Icon(
                  Icons.location_city_outlined,
                  color: AppConstants.appMainColor,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    String name = _nameController.text.trim();
                    String phoneNumber = _phoneController.text.trim();
                    String address = _addressController.text.trim();
                    
                    if (name.isNotEmpty &&
                        phoneNumber.isNotEmpty &&
                        address.isNotEmpty) {
                      String deviceToken =
                        await _deviceTokenController.getCustomerDeviceToken();
                        placeOrders(context:context,name:name,
                      phone:phoneNumber,address:address,token:deviceToken);
                    } else {
                      Get.snackbar("Error", "Fill The Feilds",
                          backgroundColor: AppConstants.appErrorColor,
                          colorText: AppConstants.appTextColor,
                          snackPosition: SnackPosition.TOP);
                    }
                  },
                  child: Text(
                    "Confirm Order",
                    style: mainHeading(28, AppConstants.appSecondryColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}




// Card(
//                           elevation: 5,
//                           shadowColor: AppConstants.appSecondryColor,
//                           child: ListTile(
                            
//                             title: Text(
//                               cartModal.productName,
//                               style:
//                                   mainHeading(20, AppConstants.appMainColor),
//                             ),
//                             leading: CircleAvatar(
//                               backgroundColor: AppConstants.appOrangeColor,
//                               backgroundImage:
//                                   NetworkImage(cartModal.productImage[0]),
//                               child: Text(
//                                 cartModal.productName[0],
//                                 style: mainHeading(
//                                     20, AppConstants.appMainColor),
//                               ),
//                             ),
//                             subtitle: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Rs ${cartModal.productTotalPrice.toString()}',
//                                   style: tittle(
//                                       18, AppConstants.appSecondryColor),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )