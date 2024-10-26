// ignore_for_file: file_names

import 'package:ecommerce_app/screens/authsUi/welcome-screen.dart';
import 'package:ecommerce_app/screens/user-panel/allSallProductScreen.dart';
import 'package:ecommerce_app/screens/user-panel/fetchOrder.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/user-panel/allCategoryScreen.dart';
import '../screens/user-panel/allProductScreen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstants.appSecondryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Sohaib",
                  style: mainHeading(16.0, AppConstants.appTextColor)),
              subtitle: Text(
                AppConstants.appPowerBy,
                style: appText(12.0, AppConstants.appTextColor),
              ),
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: AppConstants.appyellowColor,
                child: Text(
                  "S",
                  style: mainHeading(
                    16.0,
                    AppConstants.appMainColor,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 5,
            thickness: 2,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: ()=>Get.offAll(const MainScreen()),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Home",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.home,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: ()=>Get.to(const AllProductScreen()),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Products",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.shopping_cart_outlined,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: ()=>Get.to(const AllSaleProductScreen()),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Sales Products",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.bar_chart,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: ()=>Get.to(const AllCategoryScreen()),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Categories",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.category_outlined,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: ()=>Get.to(FetchOrdersScreen()),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Confirm Orders",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.category_outlined,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Contact",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.question_answer_outlined,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 30.0,
            thickness: 1.5,
            color: AppConstants.appMainColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListTile(
              onTap: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final GoogleSignIn googleSignIn = GoogleSignIn();
                await auth.signOut();
                await googleSignIn.signOut();
                Get.offAll(WelcomeScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Logout",
                  style: mainHeading(24.0, AppConstants.appTextColor)),
              leading: const Icon(
                Icons.logout_outlined,
                color: AppConstants.appyellowColor,
                size: 28.0,
              ),
              trailing: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppConstants.appyellowColor,
                size: 24.0,
              ),
            ),
          ),
          const Divider(
            height: 5,
            thickness: 2,
            color: AppConstants.appMainColor,
          ),
        ],
      ),
    );
  }
}
