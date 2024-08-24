// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import '../../utils/constant.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 2,
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
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: AppConstants.appMainColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sub Total",style: mainHeading(24, AppConstants.appTextColor),),
              
              ],
          ),
        ),
      ),
    );
  }
}
