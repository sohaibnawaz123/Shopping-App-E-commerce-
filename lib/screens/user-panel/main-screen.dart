// ignore_for_file: file_names
import '../../controllers/cart-price-controller.dart';
import '../../screens/user-panel/cartScreen.dart';

import '../../widgets/allProductWidget.dart';
import '../../widgets/bannerWidgets.dart';
import '../../widgets/categoryWidget.dart';
import '../../widgets/heding_Widget.dart';
import '../../widgets/saleProduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';
import '../../widgets/customDrawe.dart';
import 'allCategoryScreen.dart';
import 'allProductScreen.dart';
import 'allSallProductScreen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final CartTotalPriceController _cartTotalPriceController =
      Get.put(CartTotalPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(),
        title: Text(AppConstants.appMainName,
            style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
        actions: [
          SizedBox(
            width: 100,
            child: GestureDetector(
                onTap: () => Get.to(CartScreen()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment(0, 0),
                        child: Icon(
                          Icons.shopping_cart,
                          color: AppConstants.appTextColor,size: 35,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.5, -0.5),
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.appTextColor
                          ),
                          child: Obx(() => Text(
                                _cartTotalPriceController.cartproductCount.value
                                    .toString(),
                                style: appText(20, AppConstants.appMainColor),
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 120,
              ),
              //banners
              CustomBanner(),
              headingWidget("Categories", "Hello World", 'See More >', () {
                Get.to(const AllCategoryScreen());
              }),
              const CategoryWidget(),
              headingWidget("Sale Product", "Flash Sale", 'See More >', () {
                Get.to(const AllSaleProductScreen());
              }),
              const SaleProductWidget(),
              headingWidget("All Product", "In your budget", 'See More >', () {
                Get.to(const AllProductScreen());
              }),
              const SizedBox(
                child: AllProductWidget(),
              )
              // const AllProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
