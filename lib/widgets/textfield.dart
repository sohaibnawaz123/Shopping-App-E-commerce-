import 'package:ecommerce_app/utils/constant.dart';
import 'package:flutter/material.dart';

TextField customTextField(TextEditingController controller,TextInputType keyboardType ,String hintText, Widget prefixIcon, {TextInputAction? textInputAction, Widget? suffixicon , bool hideText = false}) {
  return TextField(
    cursorColor: AppConstants.appMainColor,
    controller: controller,
    obscureText: hideText,
    textInputAction: textInputAction,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      prefixIcon:prefixIcon,
      suffixIcon: suffixicon,
      hintText: hintText,
      hintStyle: appText(16, AppConstants.appMainColor),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2,color: AppConstants.appMainColor,strokeAlign: BorderSide.strokeAlignOutside),borderRadius:BorderRadius.circular(10) ),

      focusedBorder:OutlineInputBorder(borderSide: const BorderSide(width: 2,color: Color.fromARGB(255, 5, 106, 156),strokeAlign: BorderSide.strokeAlignOutside),borderRadius:BorderRadius.circular(10) ),

      errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2,color: Color.fromARGB(255, 230, 73, 112),strokeAlign: BorderSide.strokeAlignOutside),borderRadius:BorderRadius.circular(10) ),
    ),

  );
}
