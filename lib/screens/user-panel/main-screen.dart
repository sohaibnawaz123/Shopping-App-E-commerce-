// ignore_for_file: file_names
import 'package:ecommerce_app/screens/user-panel/cartScreen.dart';

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
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: Text(AppConstants.appMainName,
            style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
        actions: [GestureDetector(
          onTap: () => Get.to(const CartScreen()),child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.shopping_cart,color: AppConstants.appTextColor,),
          ))],
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
