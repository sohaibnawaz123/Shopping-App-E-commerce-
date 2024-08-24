// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/constant.dart';

Widget headingWidget(String heading,String subTitle,String buttonText, VoidCallback ontap) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading,style: mainHeading(24.0, AppConstants.appMainColor,fontweight: FontWeight.w500),),
            Text(subTitle,style: mainHeading(16.0, AppConstants.appSecondryColor),),
          ],
        ),
        ElevatedButton(onPressed: ontap,
        style:ElevatedButton.styleFrom(
          backgroundColor: AppConstants.appMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ) , child: Text(buttonText,style: mainHeading(16, AppConstants.appTextColor),),)
    ],),
  );
}
