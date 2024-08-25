// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        actions: const <Widget>[Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(Icons.delete_forever,color: AppConstants.appTextColor,),
        )],
        elevation: 5,
        iconTheme: const IconThemeData(),
        title:
            Text("My Cart", style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: SizedBox(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      "Hello world",
                      style: mainHeading(20, AppConstants.appMainColor),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppConstants.appOrangeColor,
                      child: Text(
                        "H",
                        style: mainHeading(30, AppConstants.appSecondryColor),
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs: 1500',
                          style: tittle(18, AppConstants.appSecondryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.all(0),
                                      minimumSize:
                                          Size(Get.width / 15, Get.height / 40),
                                      backgroundColor:
                                          AppConstants.appSecondryColor),
                                  onPressed: () {},
                                  child: Text(
                                    '-',
                                    style:
                                        tittle(24, AppConstants.appTextColor),
                                  )),
                              SizedBox(
                                width: Get.width / 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.all(0),
                                      minimumSize:
                                          Size(Get.width / 15, Get.height / 40),
                                      backgroundColor:
                                          AppConstants.appSecondryColor),
                                  onPressed: () {},
                                  child: Text(
                                    '+',
                                    style:
                                        tittle(24, AppConstants.appTextColor),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
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
                    style: mainHeading(24, AppConstants.appTextColor,fontweight: FontWeight.w600),
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
                    maximumSize: const Size(120,50),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
